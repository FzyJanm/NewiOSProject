# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'NewiOSProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NewiOSProject
  #    网络
  pod 'AFNetworking'
  #progress
  pod 'MBProgressHUD'
  #下拉刷新
  pod 'MJRefresh'
  #图片网络加载
  pod 'SDWebImage'
  #autolayout
#  pod 'Masonry'
  #UITextView带Placeholder
  pod 'UITextView+Placeholder'
  #键盘
  pod 'IQKeyboardManager'
  #自定义navigationbar手势
  pod 'FDFullscreenPopGesture'
  #封装了一些常用的方法（使用分类）
  pod 'YYCategories'
  #数模转换
  pod 'MJExtension'
#  #微信支付
  pod 'WechatOpenSDK'
  #支付宝
  pod 'AlipaySDK-iOS'
  #文字处理
  pod 'YYText'

post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              #忽略因为版本出现的警告
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
              config.build_settings['ENABLE_BITCODE'] = 'NO'
              config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
              
          end
      end
  end
end
