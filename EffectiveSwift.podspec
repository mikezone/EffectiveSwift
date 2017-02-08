Pod::Spec.new do |s|
  s.name         = "EffectiveSwift"
  s.version      = "0.9.0"
  s.summary      = "Some useful extension for Swift"
  s.homepage     = "https://github.com/mikezone/EffectiveSwift"
  s.license      = "GPL-3.0"
  s.author       = { "Mike" => "82643885@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mikezone/EffectiveSwift.git", :tag => s.version }
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.requires_arc = true

  s.source_files  = ["EffectiveSwift/Classes/*.swift", "EffectiveSwift/Extension/**/*.swift"]
  # s.public_header_files = ["EffectiveSwift/EffectiveSwift.h"]
  s.preserve_paths = 'modulemapFiles/**/*'
  s.libraries = "z"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]' => '$(SRCROOT)/EffectiveSwift/modulemapFiles/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]' => '$(SRCROOT)/EffectiveSwift/modulemapFiles/iphonesimulator'
  }
end
