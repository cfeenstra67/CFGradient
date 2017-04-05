//
//  CFGradientView.h
//  Pods
//
//  Created by Cam Feenstra on 4/5/17.
//
//

#import <UIKit/UIKit.h>
#import "CFGradientLayer.h"

@interface CFGradientView : UIView

-(id)initWithFrame:(CGRect)frame type:(GradientType)type;

-(id)initWithType:(GradientType)type;

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint endPoint;

@property (nonatomic) CGFloat curveConstant;

@property (nonatomic) CGFloat radius;

@property (nonatomic) UIColor *startColor;

@property (nonatomic) UIColor *endColor;

@property (nonatomic) GradientType gradientType;

@end
