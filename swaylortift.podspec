Pod::Spec.new do |spec|
	spec.name                  = "SwaylorTift"
	spec.version               = "1.0.12"
	spec.license               = { :type => "MIT", :file => "LICENSE" }
	spec.homepage              = "https://github.com/ciathyza/SwaylorTift"
	spec.authors               = { "Ciathyza" => "ciathyza@ciathyza.com" }
	spec.summary               = "Utils and Extensions for iOS Swift Projects."
	spec.platform              = :ios, "10.0"
	spec.source                = { :git => "https://github.com/ciathyza/SwaylorTift.git", :branch => "master", :tag => spec.version.to_s }
	spec.framework             = "UIKit"
	spec.source_files          = "SwaylorTift/SwaylorTift/Source/**/*.{swift,h,m}"
	spec.ios.deployment_target = "10.0"
	spec.swift_version         = "4.2"
	spec.requires_arc          = true
end
