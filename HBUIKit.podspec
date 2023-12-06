#
# Be sure to run `pod lib lint HBUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBUIKit'
  s.version          = '0.0.2'
  s.summary          = 'HBUIKit just like SwiftUI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  HBUIKit 自定义封装了UIKit 使用SwiftUI调用方法的方式调用.
                   DESC

  s.homepage         = 'https://github.com/HBLove'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HBLove' => '376894729@qq.com' }
  s.source           = { :git => 'https://github.com/HBLove/HBUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  s.frameworks = 'UIKit'
  s.ios.deployment_target = '13.0'

  s.source_files = 'HBUIKit/**/*.swift'
  
  # Swift Base
  s.subspec 'Base' do |sp|
    sp.source_files  = 'HBUIKit/Base/*.swift'
  end
  
  # Swift Common
  s.subspec 'Common' do |sp|
    sp.source_files  = 'HBUIKit/Common/*.swift'
    sp.dependency 'HBUIKit/Base'
  end
  
  # Swift CoreGraphics
  s.subspec 'CoreGraphics' do |sp|
    sp.source_files  = 'HBUIKit/CoreGraphics/*.swift'
    sp.dependency 'HBUIKit/Base'
  end
  
  # Swift Extension
  s.subspec 'Extension' do |sp|
    sp.source_files  = 'HBUIKit/Extension/*.swift'
    sp.dependency 'HBUIKit/Base'
  end
  
  # Swift UIKit
  s.subspec 'UIKit' do |sp|
    sp.source_files  = 'HBUIKit/UIKit/*.swift'
#    sp.dependency 'HBUIKit/Base'
    sp.dependency 'HBUIKit/Extension'
    sp.dependency 'HBUIKit/CoreGraphics'
  end
  
  # s.resource_bundles = {
  #   'HBUIKit' => ['HBUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
