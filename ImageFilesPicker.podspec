Pod::Spec.new do |s|

s.name              = 'ImageFilesPicker'
s.version           = '0.1.0'
s.summary           = 'ImageFilesPicker'
s.homepage          = 'https://github.com/mcmatan/ImageFilesPicker'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Matan'
}
s.source            = {
:git => 'https://github.com/mcmatan/ImageFilesPicker.git',
:tag => s.version.to_s
}
s.source_files      = 'ImageFilesPicker/*.{m,h}', 'ImageFilesPicker/*.{m,h}'
s.requires_arc      = true

end