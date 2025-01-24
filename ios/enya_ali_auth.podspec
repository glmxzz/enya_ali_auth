#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint enya_ali_auth.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'enya_ali_auth'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }


  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.frameworks = 'Network'
  
s.ios.vendored_frameworks = 'ATAuthSDK.framework', 'YTXMonitor.framework', 'YTXOperators.framework'
  s.vendored_frameworks = 'libs/ATAuthSDK.framework', 'libs/YTXMonitor.framework', 'libs/YTXOperators.framework'
  
  s.static_framework = false

  # 解决移动crash
  s.xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC',
    'ENABLE_BITCODE' => 'NO'
  }


  # 加载静态资源
  s.resources = ['Assets/*']

  s.ios.deployment_target = '11.0'
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'   }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # Flutter.framework does not contain a i386 slice.
  
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'enya_ali_auth_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
