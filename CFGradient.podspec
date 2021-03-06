#
# Be sure to run `pod lib lint CFGradient.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CFGradient'
  s.version          = '1.0.1'
  s.summary          = "The gradient package you've been waiting for."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This pod defines two classes: CFGradientView and CFGradientLayer.  They are effectively the same when used--CAGradientView simply uses CAGradientLayer as its base layer and uses its base layer's getter and setter methods for its custom properties.  These classes allow you to create beautiful, animatable gradients, either axial or radial!  Perhaps the best addition is the curveConstant property of CFGradientView and CFGradientLayer.  This allows you to define the exact distribution of colors between the startColor and endColor.
                       DESC

  s.homepage         = 'https://github.com/cfeenstra67/CFGradient'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cfeenstra67' => 'cameron.l.feenstra@gmail.com' }
  s.source           = { :git => 'https://github.com/cfeenstra67/CFGradient.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

s.source_files  =  "CFGradient/*.{h,m}"

  # s.resource_bundles = {
  #   'CFGradient' => ['CFGradient/Assets/*.png']
  # }

  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
