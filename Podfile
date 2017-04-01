platform :ios, '9.0'
use_frameworks!

# Pods for Honeybee
def pods
    pod 'SnapKit', '~> 3.0.2'
    pod 'Charts', '~> 3.0.1'
    #pod 'RealmSwift', '~> 2.1.2'
    pod 'RealmSwift', '~> 2.4.4'
    pod 'ObjectMapper', '~> 2.2.5'
    #pod 'PNChart', '~> 0.8.9'
    pod 'Then', '~> 2.1.0'    
    #pod 'ARSLineProgress', '~> 2.1.0'
    pod 'PKHUD', '~> 4.2.0'
end

target 'Honeybee' do
    pods
end

# Pods for testing
target 'HoneybeeTests' do
    inherit! :search_paths
end

target 'HoneybeeUITests' do
    inherit! :search_paths
end
