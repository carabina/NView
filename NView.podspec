#
# Be sure to run `pod lib lint NView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NView'
  s.version          = '0.1.0'
  s.summary          = 'Just a viwe that appear in top'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
111
                       DESC

  s.homepage         = 'https://github.com/vladaccess/NView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vlad' => 'vladaccess@outlook.com' }
  s.platform     = :ios, '8.0'
  s.source           = { :git => 'https://github.com/vladaccess/NView.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

#s.ios.deployment_target = '8.0'

s.source_files = 'Source/**/*.{swift}'
s.frameworks = 'UIKit'
s.requires_arc = true
s.swift_version = '4.0'
  # s.resource_bundles = {
  #   'NView' => ['NView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  
  # s.dependency 'AFNetworking', '~> 2.3'
end
