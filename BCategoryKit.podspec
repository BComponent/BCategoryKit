#
# Be sure to run `pod lib lint BCategoryKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  #组件名
  s.name             = 'BCategoryKit'
  #版本号
  s.version          = '0.1.0'
  #描述
  s.summary          = 'A short description of BCategoryKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
#详细描述--修改记录
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/BComponent/BCategoryKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangbaoming' => 'wangbaoming@log56.com' }
  s.source           = { :git => 'https://github.com/BComponent/BCategoryKit', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
#组件资源文件路径
  s.source_files = 'BCategoryKit/Classes/**/*'
  #组件资源bundle路径
  # s.resource_bundles = {
  #   'BCategoryKit' => ['BCategoryKit/Assets/*.png']
  # }
  s.resource_bundles = {
    'BCategoryKit' => ['BCategoryKit/SWQRCode/*.bundle']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  #组件依赖库
  # s.dependency 'AFNetworking', '~> 2.3'
end
