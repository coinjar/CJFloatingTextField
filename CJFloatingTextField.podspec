Pod::Spec.new do |s|
  s.name         = "CJFloatingTextField"
  s.version      = "1.0.0"
  s.summary      = "A versatile, highly configurable text field that with a floating display label and icon image view"

  s.description  = <<-DESC
                  CJFloatingLabel is a UI component designed as part of CoinJar touch.
                  Inspired by the Google's polymer project, CJFloatingLabel provides a versatile,
                  highly configurable text field that comes with a floating display label and icon image view.
                   DESC

  s.homepage     = "https://github.com/coinjar/cjfloatingtextfield"

  s.license      = 'MIT'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "CoinJar" => "info@coinjar.com" }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'

  s.source       = { :git => "git@github.com/coinjar/cjfloatingtextfield.git", :tag => s.version.to_s }
  s.source_files  = 'CJFloatingTextField', 'CJFloatingTextField/**/*.{h,m}'

  s.requires_arc = true
  s.dependency 'Masonry'
end
