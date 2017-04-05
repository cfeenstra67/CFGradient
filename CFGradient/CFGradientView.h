//
//  CFGradientView.h
//  Pods
//
//  Created by Cam Feenstra on 4/5/17.
//
//

#import <UIKit/UIKit.h>

@interface CFGradientView : UIView

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint endPoint;

@property (nonatomic) CGFloat curveConstant;

@property (nonatomic) CGFloat radius;

@property (nonatomic) UIColor *startColor;

@property (nonatomic) UIColor *endColor;

@end
