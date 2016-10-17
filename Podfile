def shared_pods
    use_frameworks!
    pod 'FLKAutoLayout', '~> 1.0'
end

target 'SpyCraft Utility Belt' do
    shared_pods
end

target 'SpyCraft Utility BeltTests' do
    shared_pods
end

target 'SpyCraft Utility BeltUITests' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
