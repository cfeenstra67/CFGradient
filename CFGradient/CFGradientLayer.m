//
//  CFGradientLayer.m
//  Pods
//
//  Created by Cam Feenstra on 4/4/17.
//
//

#import "CFGradientLayer.h"

@interface CFGradientLayer(){
    CGFloat (^d)(CGPoint,CGPoint);
    CGPoint (^full)(CGPoint);
    CGFloat (^f_c)(CGFloat x, NSInteger range, CGFloat c);
    CGFloat (^f)(CGFloat x, NSInteger range);
    CGFloat (^translate)(CGFloat);
    BOOL (^pEq)(CGPoint,CGPoint);
    
    GradientType type;
}

+(NSArray<NSString*>*)propertyKeys;

@property (readonly) NSArray *colors;

@property (readonly) NSInteger colorCount;

@end

@implementation CFGradientLayer

@dynamic startPoint;
@dynamic endPoint;
@dynamic radius;
@dynamic curveConstant;
@dynamic startColor;
@dynamic endColor;

-(id)init{
    self=[super init];
    __weak typeof(self) weakSelf=self;
    d=^CGFloat(CGPoint a, CGPoint b){
        return (float)sqrt(pow(a.x-b.x, 2)+pow(a.y-b.y, 2));
    };
    full=^CGPoint(CGPoint x){
        return CGPointMake(weakSelf.frame.size.width*x.x, weakSelf.frame.size.height*x.y);
    };
    pEq=^BOOL(CGPoint a, CGPoint b){
        return a.x==b.x&&a.y==b.y;
    };
    translate=^CGFloat(CGFloat x){
        return 1.0f/(1.0f-x);
    };
    __weak typeof(translate) weakT=translate;
    f_c=^CGFloat(CGFloat x, NSInteger range, CGFloat c){
        return 1-powf(x/(float)range,weakT(c));
    };
    __weak typeof(f_c) weakF=f_c;
    f=^CGFloat(CGFloat x, NSInteger range){
        return weakF(x,range,weakSelf.curveConstant);
    };
    
    type=AxialGradient;
    return self;
}

-(NSArray*)colors{
    return [self colorsWithCount:self.colorCount startColor:self.startColor endColor:self.endColor function:f];
}

-(NSArray*)colorsWithCount:(NSInteger)count startColor:(CGColorRef)start endColor:(CGColorRef)endColor function:(CGFloat(^)(CGFloat,NSInteger))func{
    NSMutableArray *a=[[NSMutableArray alloc] init];
    NSInteger components=CGColorGetNumberOfComponents(self.startColor);
    CGColorSpaceRef space=CGColorGetColorSpace(self.startColor);
    CGFloat *startComps=CGColorGetComponents(self.startColor);
    CGFloat *endComps=CGColorGetComponents(self.endColor);
    CGFloat compDifferences[components];
    for(int i=0; i<components; i++){
        compDifferences[i]=endComps[i]-startComps[i];
    }
    for(NSInteger i=0; i<count; i++){
        CGFloat *colorComps=startComps;
        for(int i=0; i<components; i++){
            colorComps[i]+=compDifferences[i]*func(i,count);
        }
        [a addObject:(id)CFBridgingRelease(CGColorCreate(space, colorComps))];
    }
    return a;
}

-(NSInteger)colorCount{
    switch(self.gradientType){
        case AxialGradient:
            return floorf(d(full(self.startPoint),full(self.endPoint)));
        case RadialGradient:
            return self.radius*MIN(self.frame.size.width,self.frame.size.height);
    }
}

-(id)initWithType:(GradientType)typ{
    self=[self init];
    type=typ;
    return self;
}

+(CFGradientLayer*)layerWithType:(GradientType)typ{
    return [[CFGradientLayer alloc] initWithType:typ];
}

-(GradientType)gradientType{
    return type;
}

+(NSArray<NSString*>*)propertyKeys{
    NSMutableArray *a=[[NSMutableArray alloc] init];
    [a addObject:@"startPoint"];
    [a addObject:@"endPoint"];
    [a addObject:@"radius"];
    [a addObject:@"curveConstant"];
    [a addObject:@"startColor"];
    [a addObject:@"endColor"];
    return a;
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
        return animation;
    }
    return [super actionForKey:event];
}

-(void)drawInContext:(CGContextRef)ctx{
    NSArray *colors=self.colors;
    CGFloat locations[colors.count];
    NSInteger components=CGColorGetNumberOfComponents((CGColorRef)colors.firstObject);
    CGFloat comps[colors.count*components];
    NSInteger index=0;
    for(NSInteger i=0; i<colors.count; i++){
        CGFloat *theseComps=CGColorGetComponents((CGColorRef)colors[i]);
        
        locations[i]=(float)i/(float)colors.count;
        for(NSInteger j=0; j<components; j++){
            comps[index]=theseComps[i];
            index++;
        }
    }
    CGGradientRef gradient=CGGradientCreateWithColorComponents(CGColorGetColorSpace((CGColorRef)colors.firstObject), comps, locations, colors.count);
    switch(self.gradientType){
        case AxialGradient:
            CGContextDrawLinearGradient(ctx, gradient, self.startPoint, self.endPoint, kCGGradientDrawsAfterEndLocation);
            break;
        case RadialGradient:
            CGContextDrawRadialGradient(ctx, gradient, [self centerOfRect:self.bounds], 0, [self centerOfRect:self.bounds], self.radius, nil);
            break;
    }
    CGGradientRelease(gradient);
}

-(CGPoint)centerOfRect:(CGRect)rect{
    return CGPointMake(rect.origin.x+rect.size.width/2, rect.origin.y+rect.size.height/2);
}

-(void)axialDrawInContext:(CGContextRef)ctx{
    
}

-(void)radialDrawInContext:(CGContextRef)ctx{
    
}

-(CGColorRef)backgroundColor{
    return self.startColor;
}

-(void)setBackgroundColor:(CGColorRef)backgroundColor{
    self.startColor=backgroundColor;
}

@end
