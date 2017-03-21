

workspace 'N_Workspace'

project 'SwiftDemo/SwiftDemo.xcodeproj'
project 'SwiftUtil/SwiftUtil.xcodeproj'

target 'SwiftDemo' do
    use_frameworks!
    platform:ios, '8.0'
    pod 'MJRefresh'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
    pod 'Moya'
    pod 'Moya/RxSwift'
    pod 'ObjectMapper'
    pod 'SwiftyJSON'
    project 'SwiftDemo/SwiftDemo.xcodeproj'
end

target 'SwiftUtil' do
    platform:ios, '8.0'
    pod 'AFNetworking', '~> 3.1.0'
    project 'SwiftUtil/SwiftUtil.xcodeproj'
end

