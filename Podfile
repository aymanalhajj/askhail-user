# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AskHail' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end

  # Pods for AskHail
pod 'Alamofire', '~> 4.2'
pod 'Kingfisher', '~> 4.0'
pod 'LXStatusAlert'
pod 'UIView+Shake'
pod 'AJMessage'
pod 'BottomPopup'
pod 'FSPagerView'
pod 'RxSwift'
pod 'RxCocoa'
pod 'FAPanels'
pod 'Cosmos', '~> 16.0'
pod 'JHSpinner'
pod 'OTPFieldView'
pod 'TextFieldEffects'
pod 'IQAudioRecorderController'
pod "PageControls/PillPageControl"
pod 'Firebase/Core'
pod 'Firebase/Database'
pod 'Firebase/Messaging'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'FirebaseMessaging'
pod 'NotificationBannerSwift'
pod 'GoogleMaps' , '~> 3.9.0'
pod 'GooglePlaces'
pod 'STTabbar'
pod 'Socket.IO-Client-Swift'
pod 'Firebase/DynamicLinks'
pod 'IQKeyboardManager'
pod 'Toast-Swift', '~> 5.0.1'
pod 'lottie-ios'

pod 'PMAlertController'
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'
end
