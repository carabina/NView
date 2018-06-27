# NView
Imitate the native Notification Banner for any alert.
[![](https://raw.githubusercontent.com/vladaccess/NView/master/i2.png ) ](https://raw.githubusercontent.com/vladaccess/NView/master/i2.png)
> If you use Iphone X make sure `View controller-based status bar appearance` was set to `NO` in your info.plist


## Requirements
* iOS 7.0+ / Mac OS X 10.9+
* Xcode 9.0+, Swift 4.0

## Installation

NView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NView', :git => 'https://github.com/vladaccess/NView.git'
```

## Using
```swift
// Creating instance
let notification = RNNotificationView()

notification.titleFont = UIFont(name: "AvenirNext-Bold", size: 10)!
notification.titleColor = UIColor.blueColor()
notification.iconSize = CGSize(width: 46, height: 46) // Optional setup
notification.show(withImage: nil,
title: "Title",
message: "Message")
```

## Customizing
You can to create the instance of NotificationView and then setup properties.
* Icon size. (*CGSize(22,22)*)
```swift
iconSize:CGSize
```
* Subtitle text color. (*UIColor.white*)
```swift
subtitleColor:UIColor
```
* Title text color. (*UIColor.white*)
```swift
titleColor:UIColor
```
* Subtitle font. (*UIFont.systemFontOfSize(13)*)
```swift
subtitleFont: UIFont
```
* Title font. (*UIFont.boldSystemFontOfSize(14)*)
```swift
titleFont:UIFont
```
* The time where *RNNotificationView* stay on *UIView*. (4.0)
```swift
duration: TimeInterval
```


## Author

Vlad, vladaccess@outlook.com

## License

NView is available under the MIT license. See the LICENSE file for more info.
