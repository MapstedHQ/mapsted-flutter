#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mapsted_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mapsted_flutter'
  s.version          = '26.7.1'
  s.summary          = "A Flutter plugin for Mapsted's indoor/outdoor location and mapping SDK (native 26.7.1)."
  s.description      = <<-DESC
A Flutter plugin for integrating Mapsted's advanced location and mapping technology,
offering easy access to precise indoor and outdoor navigation features.
                       DESC
  s.homepage         = 'https://developer.mapsted.com/mobile-sdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mapsted' => 'apps@mapsted.com' }
  s.source           = { :path => '.' }
  # Swift/ObjC sources only; the storyboard is a RESOURCE (must be bundled, not compiled as source).
  s.source_files = 'Classes/**/*.{swift,h,m}'
  s.resources    = 'Classes/**/*.storyboard'
  s.dependency 'Flutter'
  s.platform = :ios, '16.0'

  # Native Mapsted SDK 26.7.1 (geofence folded into core at 26.7.1 — pod dropped).
  s.dependency 'mapsted-sdk-map', '~> 26.7.1'
  s.dependency 'mapsted-sdk-map-ui', '~> 26.7.1'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
