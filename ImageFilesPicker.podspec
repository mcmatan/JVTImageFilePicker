Pod::Spec.new do |s|

s.name              = 'ImageFilesPicker'
s.version           = '0.1.9'
s.summary           = 'ImageFilesPicker'
s.homepage          = 'https://github.com/mcmatan/ImageFilesPicker'
s.ios.deployment_target = '8.0'
s.platform = :ios, '8.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Matan'
}
s.source            = {
:git => 'https://github.com/mcmatan/ImageFilesPicker.git',
}
s.framework = "UIKit"
s.source_files      =  'Vendor/*', 'Resource/*', 'ImagePicker/Resource'
s.requires_arc      = true

end
