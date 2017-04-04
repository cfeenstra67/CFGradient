//
//  CFPoint.h
//  Pods
//
//  Created by Cam Feenstra on 4/4/17.
//
//

#import <Quartzcore/Quartzcore.h>

@interface CFPoint : NSObject

-(id)initWithX:(CGFloat)x Y:(CGFloat)y;

+(CFPoint*)pointWithX:(CGFloat)x Y:(CGFloat)y;

-(id)initWithCGPoint:(CGPoint)point;

+(CFPoint*)pointWithCGPoint:(CGPoint)point;

-(id)initWithPoint:(CFPoint*)point;

+(CFPoint*)pointWithPoint:(CFPoint*)point;

@property (nonatomic) CGFloat x;

@property (nonatomic) CGFloat y;

@property (readonly) CGPoint CGPointValue;

@end
