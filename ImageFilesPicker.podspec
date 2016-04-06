Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "ImageFilesPicker"
s.summary = "ImageFilesPicker lets a user select between images and files."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "[Matan]" => "[cohen.abravanel@gmail.com]" }

# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "[cohen.abravanel@gmail.com]"

# For example,
# s.homepage = "https://github.com/mcmatan/ImageFilesPicker"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "[https://github.com/mcmatan/ImageFilesPicker]", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "ImageFilesPicker/**/*.{swift}"

# 9
s.resources = "ImageFilesPicker/**/*.{png,jpeg,jpg,storyboard,xib}"
end
