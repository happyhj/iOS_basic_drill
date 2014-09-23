//
//  myView.m
//  DrawRect
//
//  Created by KIM HEE JAE on 8/26/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "myView.h"
#define ARC4RANDOM_MAX      0x100000000

@implementation myView
{
    CGFloat startColor[3];
    CGFloat endColor[3];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint
    = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint
    = CGPointMake(CGRectGetMidX(self.bounds),
                  CGRectGetMaxY(self.bounds));
    
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);

    CGGradientRelease(gradient);
    
    // 도형 그리기
    [self drawRandomLine:10];
    [self drawRandomArc:10];
    
    NSString *signature = @"KIM HEE JAE";
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];

    NSDictionary *attr = @{NSForegroundColorAttributeName:[self getRandomUIColor],
                           NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman" size:40.0]};
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [signature drawInRect:CGRectMake(0,screenHeight-80, screenWidth, 40) withAttributes:attr];
}

- (void) drawRandomLine:(int)count {
    for( int i=0; i<count; i++ ) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = [self getRandomCGPointInScreen];
        [path moveToPoint:startPoint];
        CGPoint nextPoint = [self getRandomCGPointInScreen];
        [path addLineToPoint:nextPoint];
        [path setLineWidth:1.0];
        [path stroke];
    }
}
- (void) drawRandomArc:(int)count {

    for( int i=0; i<count; i++ ) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGPoint startPoint = [self getRandomCGPointInScreen];
        [path moveToPoint:startPoint];
        CGPoint nextPoint = [self getRandomCGPointInScreen];
        [path addArcWithCenter:nextPoint radius:[self getRandomDouble]*100 startAngle:0 endAngle:2*M_PI clockwise:YES];
        [path setLineWidth:1.0];
        [path stroke];
        
        [[self getPieUIColorAtIndex:i] setFill];
        [path fill];
    }

}

- (UIColor*) getPieUIColorAtIndex:(int)i {
    int colors = [0xEF306A, 0x4F88C6, 0x48BCBC, 0xD1E176, 0xFDB73B];
    return UIColorFromRGBWithAlpha(colors[i], 0.8);
}

- (double) getRandomDouble {
    return (double)arc4random()/ARC4RANDOM_MAX;
}

- (CGPoint) getRandomCGPointInScreen {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint point = CGPointMake([self getRandomDouble]*screenWidth, [self getRandomDouble]*screenHeight);
    return point;
}

- (CGGradientRef)gradient
{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    
    CGFloat components[8] = {
        [self getRandomDouble], [self getRandomDouble], [self getRandomDouble], 1.0,  // Start color
        [self getRandomDouble], [self getRandomDouble], [self getRandomDouble], 1.0
    }; // End color
    
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    return myGradient;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
}
@end
