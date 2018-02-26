Pod::Spec.new do |s|
s.name         = "FGNumberStepper"
s.version      = "1.0"
s.summary      = "FGNumberStepper convenice amount picker"
s.homepage     = "https://github.com/Insfgg99x/FGNumberStepper"
s.license      = "MIT"
s.authors      = { "CGPointZero" => "newbox0512@yahoo.com" }
s.source       = { :git => "https://github.com/Insfgg99x/FGNumberStepper.git", :tag => "1.0"}
s.frameworks   = 'Foundation','UIKit'
s.ios.deployment_target = '8.0'
s.source_files = 'lib/*.{h,m}'
s.requires_arc  = true

end

