require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-landmarksid"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/NZME/react-native-landmarksid.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm}"

  s.frameworks = 'CoreLocation', 'CoreTelephony', 'SystemConfiguration', 'Foundation', 'AdSupport', 'UIKit'
  s.weak_framework = 'AppTrackingTransparency'

  # NODE: LandmarksID pod need to be added to the project podfile when including this pod.
#   s.weak_framework = 'LandmarksID'

  s.dependency "React-Core"

  s.default_subspec = 'LO'
  s.subspec 'LO' do |sp|
    sp.vendored_frameworks = 'Libraries/LandmarksID-LO/LandmarksIDSDK.framework'
  end
  s.subspec 'LOD' do |sp|
    sp.dependency 'BluedotPointSDK', '~> 15.3'
    sp.vendored_frameworks = 'Libraries/LandmarksID-LOD/LandmarksIDSDK.framework'
  end
end
