source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'Movs' do
    pod 'Moya/RxSwift', '~> 12.0'
    
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.name == 'Debug'
          config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
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