workspace 'SwaylorTift.xcworkspace'
platform :ios, '10.0'
inhibit_all_warnings!

target 'SwaylorTift' do
	project 'SwaylorTift/SwaylorTift.xcodeproj'
	use_frameworks!
end

target 'SwaylorTiftTests' do
	project 'SwaylorTift/SwaylorTift.xcodeproj'
	use_frameworks!
	inherit! :search_paths
	pod 'SwaylorTift', :path => 'SwaylorTift.podspec'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['ENABLE_BITCODE'] = 'NO'
		end
	end
end
