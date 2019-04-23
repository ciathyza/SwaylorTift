Pod::Spec.new do |spec|
	spec.name                  = "SwaylorTift"
	spec.version               = "1.0.7"
	spec.license               = { :type => "MIT", :file => "LICENSE" }
	spec.homepage              = "https://github.com/ciathyza/swaylor-tift"
	spec.authors               = { "Ciathyza" => "ciathyza@ciathyza.com" }
	spec.summary               = "Utils and Extensions for iOS Swift Projects."
	spec.platform              = :ios, "10.0"
	spec.source                = { :git => "https://github.com/ciathyza/swaylor-tift.git", :branch => "master", :tag => spec.version.to_s }
	spec.framework             = "UIKit"
	spec.source_files          = "swaylortift/swaylortift/Source/**/*.{swift,h,m}"
	spec.ios.deployment_target = "10.0"
	spec.swift_version         = "4.2"
	spec.requires_arc          = true
end
