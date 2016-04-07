
##ImageFilesPicker

[![Pod version](https://img.shields.io/cocoapods/v/ImageFilesPicker.svg?style=flat)](http://cocoadocs.org/docsets/ImageFilesPicker)


![demo](http://gifimgs.com/res/0416/57065e786bd4a151447737.gif)

## Description

**ImageFilesPicker** Is a butifuly designed UICompenent for uploading content

**ImageFilesPicker** has full screen preview from recent camera roll

![demo](https://i.imgflip.com/121euk.gif)

## Usage

**ImageFilesPicker** works as a normal controller, just instantiate it and present it.

```objectivec
 self.filePicker = [[JVTFilesPicker alloc] init];
 self.filePicker.delegate = self;
 [self.filePicker presentFilesPickerOnController:self];
```

**ImageFilesPicker** has two delegate methods that will inform you what the users are up to:

```objectivec
- (void)didPickFile:(NSData *)file
           fileName: (NSString *) fileName {
    NSLog(@"Did pick file");
}

- (void)didPickImage:(UIImage *)image
       withImageName:(NSString *) imageName {
    NSLog(@"Did pick image");
}
```


## Installation

**ImagePicker** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ImageFilesPicker', '~> 0.1.0'
```


## Author

[Matan](https://github.com/mcmatan) made this with ❤️.

##License

```
Copyright 2013-2016 Jive Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
