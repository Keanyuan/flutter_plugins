#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'aj_flutter_scan'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = ['Classes/**/*']
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'MTBBarcodeScanner'
  s.ios.vendored_library = 'Classes/ZBarSDK/libzbar.a'
  
#  s.vendored_libraries='Classes/ZBarSDK/libzbar.a'
#  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.resources = ['Classes/images/*.png']

  s.ios.deployment_target = '8.0'
  s.subspec 'ZBarSDK' do |zbar|
    zbar.source_files = 'Classes/ZBarSDK/headers/ZBarSDK/zbar/*.{h}'
  end
end

