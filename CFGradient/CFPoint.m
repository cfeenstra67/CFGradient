//
//  CFPoint.m
//  Pods
//
//  Created by Cam Feenstra on 4/4/17.
//
//

#import "CFPoint.h"

@implementation CFPoint

-(id)init{
    self=[super init];
    self.x=0;
    self.y=0;
    return self;
}

-(id)initWithCGPoint:(CGPoint)point{
    self=[self init];
    self.x=point.x;
    self.y=point.y;
    return self;
}

-(CGPoint)CGPointValue{
    return CGPointMake(self.x, self.y);
}

-(id)initWithPoint:(CFPoint *)point{
    return [self initWithCGPoint:point.CGPointValue];
}

-(id)initWithX:(CGFloat)x Y:(CGFloat)y{
    return [self initWithCGPoint:CGPointMake(x, y)];
}

+(CFPoint*)pointWithX:(CGFloat)x Y:(CGFloat)y{
    return [[self alloc] initWithX:x Y:y];
}

+(CFPoint*)pointWithPoint:(CFPoint *)point{
    return [[self alloc] initWithPoint:point];
}

+(CFPoint*)pointWithCGPoint:(CGPoint)point{
    return [[self alloc] initWithCGPoint:point];
}

@end
