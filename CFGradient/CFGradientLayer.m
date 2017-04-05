//
//  CFGradientLayer.m
//  Pods
//
//  Created by Cam Feenstra on 4/4/17.
//
//

#import "CFGradientLayer.h"
#import <UIKit/UIKit.h>

@interface CFGradientLayer(){
}

+(NSArray<NSString*>*)propertyKeys;

@property (readonly) NSInteger colorCount;

@end

@implementation CFGradientLayer

+(NSArray<NSString*>*)propertyKeys{
    NSMutableArray *a=[[NSMutableArray alloc] init];
    [a addObject:@"startPoint"];
    [a addObject:@"endPoint"];
    [a addObject:@"radius"];
    [a addObject:@"curveConstant"];
    [a addObject:@"startColor"];
    [a addObject:@"endColor"];
    [a addObject:@"gradientType"];
    return a;
}

@dynamic startPoint;
@dynamic endPoint;
@dynamic radius;
@dynamic curveConstant;
@dynamic startColor;
@dynamic endColor;
@dynamic gradientType;

-(id)initWithLayer:(id)layer{
    self=[super initWithLayer:layer];
    if([[layer class] isSubclassOfClass:self.class]){
        self.gradientType=[(CFGradientLayer*)layer gradientType];
    }
    return self;
}

-(id)init{
    self=[super init];
    self.startPoint=CGPointMake(.5, 0);
    self.endPoint=CGPointMake(.5, 1);
    self.radius=0;
    self.curveConstant=0.0f;
    self.startColor=[UIColor whiteColor].CGColor;
    self.endColor=[UIColor whiteColor].CGColor;
    self.gradientType=AxialGradient;
    
    [self setNeedsDisplay];
    return self;
}

-(id)initWithType:(GradientType)typ{
    self=[self init];
    self.gradientType=typ;
    return self;
}

+(CFGradientLayer*)layerWithType:(GradientType)typ{
    return [[CFGradientLayer alloc] initWithType:typ];
}

//Utility Methods

-(CGPoint)centerOfRect:(CGRect)rect{
    return CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
}

//End of Utility Methods

-(NSInteger)colorCount{
    return 20;
}

+(BOOL)needsDisplayForKey:(NSString *)key{
    if([[self propertyKeys] containsObject:key]){
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(id<CAAction>)actionForKey:(NSString *)event{
    if([[self.class propertyKeys] containsObject:event]){
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:event];
        animation.fromValue=[self.presentationLayer valueForKey:event];
        animation.duration=[CATransaction animationDuration];
        animation.timingFunction=[CATransaction animationTimingFunction];
        return animation;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx{
    CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient=CGGradientCreateWithColors(space, (__bridge CFArrayRef)[self colors], nil);
    switch(self.gradientType){
        case AxialGradient:
            CGContextDrawLinearGradient(ctx, gradient, CGPointMake(self.bounds.size.width*self.startPoint.x, self.bounds.size.height*self.startPoint.y), CGPointMake(self.bounds.size.width*self.endPoint.x, self.bounds.size.height*self.endPoint.y), kCGGradientDrawsBeforeStartLocation);
            break;
        case RadialGradient:
            CGContextDrawRadialGradient(ctx, gradient, [self centerOfRect:self.bounds], 0, [self centerOfRect:self.bounds], self.radius*MIN(self.frame.size.width,self.frame.size.height), kCGGradientDrawsAfterEndLocation);
            break;
    }
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
}

-(NSArray*)colors{
    CGFloat curveConst=MIN(.9999999, MAX(.000001, 1-self.curveConstant));
    CGFloat (^g)(CGFloat c)=^CGFloat(CGFloat c){
        return c>.5?2.0f*(1-c):1.0f/(2.0f*c);
    };
    CGFloat (^f)(CGFloat x)=^CGFloat(CGFloat x){
        return powf(x, g(curveConst));
    };
    
    UIColor *initialColor=[UIColor colorWithCGColor:self.startColor];
    UIColor *finalColor=[UIColor colorWithCGColor:self.endColor];
    CGFloat sr, sg, sb, sa, fr, fg, fb, fa;
    [initialColor getRed:&sr green:&sg blue:&sb alpha:&sa];
    [finalColor getRed:&fr green:&fg blue:&fb alpha:&fa];
    CGFloat dr=fr-sr, dg=fg-sg, db=fb-sb, da=fa-sa;
    
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    for(NSInteger i=0; i<self.colorCount; i++){
        CGFloat adjust=(float)i/(float)(self.colorCount-1);
        CGFloat scale=f(adjust);
        UIColor *thisColor=[UIColor colorWithRed:sr+scale*dr green:sg+scale*dg blue:sb+scale*db alpha:sa+scale*da];
        [arr addObject:(id)thisColor.CGColor];
    }
    return arr;
}

@end
