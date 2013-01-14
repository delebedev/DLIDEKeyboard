Pod::Spec.new do |s|
  s.name         = "DLIDEKeyboard"
  s.version      = "1.0.0"
  s.summary      = "Drop-in component for adding additional keyboard keys to both iPad/iPhone keyboards"
  s.homepage     = "https://github.com/garnett/DLIDEKeyboard"
  s.author       = { "Denis Lebedev" => "d2.lebedev@gmail.com" }
  s.source       = { :git => "https://github.com/garnett/DLIDEKeyboard.git", :tag => '1.0.0' }
  s.platform     = :ios
  s.source_files = 'DLIDEKeyboard', 'DLIDEKeyboard/Classes/*.{h,m}'
  s.resources = "DLIDEKeyboard/Assets/*.png"
  s.requires_arc = true
  end
