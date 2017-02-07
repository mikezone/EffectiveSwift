Pod::Spec.new do |s|
  s.name         = "SwiftExtension"
  s.version      = "0.9.9"
  s.summary      = "some useful extension for Swift"
  s.homepage     = "https://github.com/mikezone/SwiftExtension"
  s.license      = "GNU"
  s.author       = { "Mike" => "82643885@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mikezone/SwiftExtension.git", :tag => s.version }
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.requires_arc = true

  s.source_files  = ["SwiftExtension/Classes/*.swift", "SwiftExtension/Extension/**/*.swift", "SwiftExtension/SwiftExtension.h"]
  s.public_header_files = ["SwiftExtension/SwiftExtension.h"]
  s.preserve_paths = 'modulemapFiles/**/*'
  s.libraries = "z"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0',
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]' => '$(SRCROOT)/SwiftExtension/modulemapFiles/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]' => '$(SRCROOT)/SwiftExtension/modulemapFiles/iphonesimulator'
  }
end
