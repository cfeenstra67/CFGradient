//
//  CFGradientLayer.h
//  Pods
//
//  Created by Cam Feenstra on 4/4/17.
//
//

#import <QuartzCore/QuartzCore.h>

typedef enum {
    AxialGradient,
    RadialGradient
}GradientType;

@interface CFGradientLayer : CALayer

-(id)initWithType:(GradientType)type;

+(CFGradientLayer*)layerWithType:(GradientType)type;

@property (nonatomic) GradientType gradientType;

@property (nonatomic) CGPoint startPoint;

@property (nonatomic) CGPoint endPoint;

@property (nonatomic) CGFloat radius;

@property (nonatomic) CGFloat curveConstant;

@property (nonatomic) CGColorRef startColor;

@property (nonatomic) CGColorRef endColor;

@end
