//
//  WLButtonCountdownManager.m
//  WLButtonCountingDownDemo
//
//  Created by wayne on 16/1/14.
//  Copyright © 2016年 ZHWAYNE. All rights reserved.
//

#import "FZYButtonCountdownManager.h"
#import <UIKit/UIKit.h>

@interface FZYCountdownTask : NSOperation

/**
 *  计时中回调
 */
@property (copy, nonatomic) void (^countingDownBlcok)(NSTimeInterval timeInterval);
/**
 *  计时结束后回调
 */
@property (copy, nonatomic) void (^finishedBlcok)(NSTimeInterval timeInterval);
/**
 *  计时剩余时间
 */
@property (assign, atomic) NSTimeInterval leftTimeInterval;
/**
 *  后台任务标识，确保程序进入后台依然能够计时
 */
@property (assign, nonatomic) UIBackgroundTaskIdentifier taskIdentifier;

/**
 *  `NSOperation`的`name`属性只在iOS8+中存在，这里定义一个属性，用来兼容 iOS 7
 */
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
@property (copy) NSString *name;
#endif

@end


@implementation FZYCountdownTask

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
@synthesize name;
#endif

- (void)dealloc {
    _countingDownBlcok = nil;
    _finishedBlcok     = nil;
}

- (void)main {
    
    self.taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    do {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (self.countingDownBlcok) self.countingDownBlcok(self.leftTimeInterval);
        });
        
        [NSThread sleepForTimeInterval:1];
    } while (--self.leftTimeInterval > 0);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (self.finishedBlcok) {
            self.finishedBlcok(0);
        }
    });
    
    if (self.taskIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.taskIdentifier];
        self.taskIdentifier = UIBackgroundTaskInvalid;
    }

}

@end




@interface FZYButtonCountdownManager ()

@property (nonatomic, strong) NSOperationQueue *pool;

@end

@implementation FZYButtonCountdownManager

+ (instancetype)defaultManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self _alloc] _init];
    });
    
    if ([instance class] != [FZYButtonCountdownManager class]) {
        NSCAssert(NO, @"该类不允许被继承");
    }
    
    return instance;
}

+ (instancetype)alloc {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

+ (instancetype)_alloc {
    return [super allocWithZone:NSDefaultMallocZone()];
}

- (instancetype)init {
    NSCAssert(NO, @"请使用`+defaultManager`方法获取实例");
    return nil;
}

- (instancetype)_init {
    if (self = [super init]) {
        _pool = [[NSOperationQueue alloc] init];
    }
    
    return self;
}


- (void)scheduledCountDownWithKey:(NSString *)aKey
                     timeInterval:(NSTimeInterval)timeInterval
                     countingDown:(void (^)(NSTimeInterval))countingDown
                         finished:(void (^)(NSTimeInterval))finished
{
    if (timeInterval > 120) {
        NSCAssert(NO, @"受操作系统后台时间限制，倒计时时间规定不得大于 120 秒.");
    }
    
    if (_pool.operations.count >= 20)  // 最多 20 个并发线程
        return;
    
    FZYCountdownTask *task = nil;
    if ([self countdownTaskExistWithKey:aKey task:&task]) {
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        if (countingDown && task.leftTimeInterval > 0) {
            countingDown(task.leftTimeInterval);
        }
    } else {
        task                   = [[FZYCountdownTask alloc] init];
        task.leftTimeInterval  = timeInterval;
        task.countingDownBlcok = countingDown;
        task.finishedBlcok     = finished;
        
        task.name = aKey;
        
        [_pool addOperation:task];
    }
}


- (BOOL)countdownTaskExistWithKey:(NSString *)akey
                             task:(FZYCountdownTask *__autoreleasing  _Nullable *)task
{
    __block BOOL taskExist = NO;
    
    [_pool.operations enumerateObjectsUsingBlock:^(__kindof FZYCountdownTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:akey]) {
            if (task) *task = obj;
            taskExist = YES;
            *stop     = YES;
        }
    }];
    
    return taskExist;
}


@end
