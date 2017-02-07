Pod::Spec.new do |s|
  s.name         = "SwiftExtension"
  s.version      = "0.9.5"
  s.summary      = "some useful extension for Swift"
  s.homepage     = "https://github.com/mikezone/SwiftExtension"
  s.license      = "GNU"
  s.author       = { "Mike" => "82643885@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mikezone/SwiftExtension.git", :tag => s.version }
  s.source_files  = ["SwiftExtension/SwiftExtension/Classes/*.swift", "SwiftExtension/SwiftExtension/Extension/**/*.swift", "SwiftExtension/SwiftExtension/SwiftExtension.h"]
  s.public_header_files = ["SwiftExtension/SwiftExtension/SwiftExtension.h"]
  s.prefix_header_contents = ["#import <CommonCrypto/CommonCrypto.h>", "#import <zlib.h>", "#import <sys/sysctl.h>"]
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.libraries = "z"
  s.requires_arc = true
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include" }
  # s.dependency "JSONKit", "~> 1.4"
  s.pod_target_xcconfig = { 
    'SWIFT_VERSION' => '3.0',
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]' => '$(SRCROOT)/SwiftExtension/modulemapFiles/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]' => '$(SRCROOT)/SwiftExtension/modulemapFiles/iphonesimulator'
  }
end
