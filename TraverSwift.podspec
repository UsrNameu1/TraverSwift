Pod::Spec.new do |s|
  s.name         = "TraverSwift"
  s.version      = "0.5"
  s.summary      = "A thin framework for swift's Collection."
  s.homepage     = "https://github.com/UsrNameu1/TraverSwift"
  s.license      = "MIT"
  s.author       = { "UsrNameu1" => "tea_room_1028[at]yahoo.co.jp" }
  s.source       = { :git => "https://github.com/UsrNameu1/TraverSwift.git", :tag => s.version }
  s.documentation_url = "http://usrnameu1.github.io/TraverSwift/docs/"

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'TraverSwift/*.swift'

  s.requires_arc = true
end
