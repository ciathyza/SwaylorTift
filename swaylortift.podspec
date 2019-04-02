Pod::Spec.new do |spec|
	spec.name                = 'swaylortift'
	spec.version             = '1.0.0'
	spec.license             = { :type => "Proprietary", :file => "LICENSE" }
	spec.homepage            = 'https://github.com/ciathyza/swaylor-tift'
	spec.authors             = { "Ciathyza" => "ciathyza@ciathyza.com" }
	spec.summary             = 'Utils & Extensions for iOS Swift Projects.'
	spec.platform            = :ios, '10.0'
	spec.source              = { :git => 'https://github.com/ciathyza/swaylor-tift.git', :tag => spec.version.to_s }
	spec.source_files        = 'swaylortift/swaylortift/Source/**/*.{swift,h,m}'
	spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
	spec.requires_arc        = true
	spec.pod_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"', }
end
