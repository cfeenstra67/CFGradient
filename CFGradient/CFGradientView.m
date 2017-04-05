//
//  CFGradientView.m
//  Pods
//
//  Created by Cam Feenstra on 4/5/17.
//
//

#import "CFGradientView.h"

@interface CFGradientView(){
    
}

@end

@implementation CFGradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)init{
    self=[super init];
    
    return self;
}

-(id)initWithType:(GradientType)type{
    self=[self init];
    self.gradientType=type;
    return self;
}

-(id)initWithFrame:(CGRect)frame type:(GradientType)type{
    self=[super initWithFrame:frame];
    self.gradientType=type;
    return self;
}

+(Class)layerClass{
    return [CFGradientLayer class];
}


//Getters & Setters

-(CGPoint)startPoint{
    return [(CFGradientLayer*)self.layer startPoint];
}

-(void)setStartPoint:(CGPoint)startPoint{
    [(CFGradientLayer*)self.layer setStartPoint:startPoint];
}

-(CGPoint)endPoint{
    return [(CFGradientLayer*)self.layer endPoint];
}

-(void)setEndPoint:(CGPoint)endPoint{
    [(CFGradientLayer*)self.layer setEndPoint:endPoint];
}

-(CGFloat)curveConstant{
    return [(CFGradientLayer*)self.layer curveConstant];
}

-(void)setCurveConstant:(CGFloat)curveConstant{
    [(CFGradientLayer*)self.layer setCurveConstant:curveConstant];
}

-(CGFloat)radius{
    return [(CFGradientLayer*)self.layer radius];
}

-(void)setRadius:(CGFloat)radius{
    [(CFGradientLayer*)self.layer setRadius:radius];
}

-(UIColor*)startColor{
    return [UIColor colorWithCGColor:[(CFGradientLayer*)self.layer startColor]];
}

-(void)setStartColor:(UIColor *)startColor{
    [(CFGradientLayer*)self.layer setStartColor:startColor.CGColor];
}

-(UIColor*)endColor{
    return [UIColor colorWithCGColor:[(CFGradientLayer*)self.layer endColor]];
}

-(void)setEndColor:(UIColor *)endColor{
    [(CFGradientLayer*)self.layer setEndColor:endColor.CGColor];
}

-(GradientType)gradientType{
    return [(CFGradientLayer*)self.layer gradientType];
}

-(void)setGradientType:(GradientType)gradientType{
    [(CFGradientLayer*)self.layer setGradientType:gradientType];
}

@end
