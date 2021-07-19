#
# Be sure to run `pod lib lint Pathfinder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Pathfinder-KODE'
  s.version          = '0.1.0'
  s.summary          = 'Pathfinder is a simple URL resolver that allow you to simply add any environment parameters to URLs via UI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Pathfinder - simple URL resolver with basic user interface allowing you to substitute environment parameters for debugging and testing purposes.
                       DESC

  s.homepage         = 'https://git.appkode.ru/dev-department/pathfinder-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Medvedev Semyon' => 'sm@kode.ru' }
  s.source           = { :git => 'https://git.appkode.ru/dev-department/pathfinder-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'Pathfinder' => ['Pathfinder/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
