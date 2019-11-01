![image](https://github.com/daisukenagata/MaskingLayer/blob/master/MaskImage.png?raw=true)

# MaskingLayer Xcode11 Swift5
[![Version](https://img.shields.io/cocoapods/v/MaskingLayer.svg?style=flat)](https://cocoapods.org/pods/MaskingLayer)
[![License](https://img.shields.io/cocoapods/l/MaskingLayer.svg?style=flat)](https://cocoapods.org/pods/MaskingLayer)
[![Platform](https://img.shields.io/cocoapods/p/MaskingLayer.svg?style=flat)](https://cocoapods.org/pods/MaskingLayer)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.
You can select background color, camera roll, video roll with long tap.
 
Example ViewController
```ruby
import UIKit
import MaskingLayer

class ViewController: UIViewController {

    var mO = MaskingLayerViewModel(minSegment: 15)

    override func viewDidLoad() {
        super.viewDidLoad()

        let maskGestureView = MaskGestureView(mO: mO)
        maskGestureView.frame = view.frame
        mO.frameResize(images: UIImage(named: "IMG_4011")!)

        view.addSubview(maskGestureView)
        view.addSubview(mO.imageView)
        view.layer.addSublayer(mO.maskLayer.clipLayer)

        mO.maskPathSet()

        maskGestureView.observe(self, mO: mO)
    }
}

```


## Version 0.4.2
You can generate a GIF image by pressing the leftmost image.


## Gif
![](https://github.com/daisukenagata/MaskingLayer/blob/master/gif%20or%20image/MovieImage.gif?raw=true)
![](https://github.com/daisukenagata/MaskingLayer/blob/master/gif%20or%20image/MovieGif.gif?raw=true)



## Version 0.5  Version 0.5.1
Os12 portrait camera with iphoneX or higher, masking images where people are reflections
![](https://github.com/daisukenagata/MaskingLayer/blob/master/gif%20or%20image/MovieMatte.gif?raw=true)
![](https://github.com/daisukenagata/MaskingLayer/blob/master/gif%20or%20image/IMG_0073.TRIM.gif?raw=true)
## Version 0.6.4
Press BackImage with a long tap and decide the background, then select portrait camera image
<img src= "https://github.com/daisukenagata/MaskingLayer/blob/master/gif%20or%20image/5453.jpg?raw=true" width="330" height="500">

## Version 0.6.5
Added a compositing function that can be saved to the terminal.



## Version 0.8 ~

The left is the latest version. Perform a smooth crop.
![](https://user-images.githubusercontent.com/16457165/63633553-2ed26080-c685-11e9-8c91-17e3eb36dc3f.gif)


## Installation

MaskingLayer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MaskingLayer'
```

## Author

daisukenagata, dbank0208@gmail.com

## License

MaskingLayer is available under the MIT license. See the LICENSE file for more info.


