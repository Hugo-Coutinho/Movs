source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'Movs' do
  pod 'Moya/RxSwift', '~> 12.0'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxDataSources', '~> 3.0'
  pod 'Kingfisher'
  pod 'lottie-ios'
    
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name == 'Movs'
          target.build_configurations.each do |config|
              if config.name == 'Debug'
                  config.build_settings['OTHER_SWIFT_FLAGS'] = '-DDEBUG'
                  else
                  config.build_settings['OTHER_SWIFT_FLAGS'] = ''
              end
          end
      end
  end
end

  # post_install do |installer|

  #   installer.pods_project.targets.each do |target|
  #     installer.pods_project.build_configurations.each do |config|
  #       config.build_settings['ENABLE_BITCODE'] = 'NO'
  #     end
  
  #     target.build_configurations.each do |config|
  #       config.build_settings['ENABLE_BITCODE'] = 'NO'
  #     end
  #   end
  # end