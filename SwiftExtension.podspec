Pod::Spec.new do |s|
  s.name         = "SwiftExtension"
  s.version      = "0.9.0"
  s.summary      = "some useful extension for Swift"
  s.homepage     = "https://github.com/mikezone/SwiftExtension"
  s.license      = "GNU"
  s.author       = { "Mike" => "82643885@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/mikezone/SwiftExtension.git", :tag => s.version }
  s.source_files  = ["SwiftExtension/SwiftExtension/Classes/*.swift", "SwiftExtension/SwiftExtension/Extension/**/*.swift"]
  s.public_header_files = ["SwiftExtension/SwiftExtension/SwiftExtension.h", "SwiftExtension/SwiftExtension/AppGenerate/SwiftExtension-Bridging-Header.h"]
  s.frameworks = "Foundation", "UIKit", "CoreGraphics"
  s.libraries = "z"
  # s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
