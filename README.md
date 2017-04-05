# CFGradient

[![CI Status](http://img.shields.io/travis/cfeenstra67/CFGradient.svg?style=flat)](https://travis-ci.org/cfeenstra67/CFGradient)
[![Version](https://img.shields.io/cocoapods/v/CFGradient.svg?style=flat)](http://cocoapods.org/pods/CFGradient)
[![License](https://img.shields.io/cocoapods/l/CFGradient.svg?style=flat)](http://cocoapods.org/pods/CFGradient)
[![Platform](https://img.shields.io/cocoapods/p/CFGradient.svg?style=flat)](http://cocoapods.org/pods/CFGradient)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Example of animating curveConstant on a CFGradientView:

![image](https://cloud.githubusercontent.com/assets/24579331/24692032/f588f184-19a4-11e7-992d-ed431b21b1c0.gif)

CFGradientLayer Properties (All Animatable):

gradientType- either AxialGradient or RadialGradient.  Exactly what it sounds like

startColor- CGColorRef used at the beginning of the gradient.  If radial, this is at the center of the layer, and if axial it is at the startPoint of the layer

endColor- CGColorRef, opposite of startColor

startPoint- CGPoint that is used as the relative start point for the gradient if the gradient type is axial.  Values for x and y should be between 0 and 1.

endPoint- CGPoint, opposite of startPoint

radius- CGFloat used as the relative radius if the gradient type is radial.  Value should be between 0 and 1.

curveConstant- CGFloat used to define the gradient curve.  Value should be between 0 and 1.


## Requirements

iOS 8.0

## Installation

CFGradient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CFGradient"
```

## Author

cfeenstra67, cameron.l.feenstra@gmail.com

## License

CFGradient is available under the MIT license. See the LICENSE file for more info.
