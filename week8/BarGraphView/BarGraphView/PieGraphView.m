//
//  PieGraphView.m
//  BarGraphView
//
//  Created by KIM HEE JAE on 8/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "PieGraphView.h"

#define ARC4RANDOM_MAX      0x100000000

//RGB color macro with alpha

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@implementation PieGraphView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawLabelFromData:(NSDictionary*)datum withStartAngle:(float)startAngle withColor:(UIColor*)color
{
    float angle = [self getAngleValue:datum];
    float xPoz, yPoz;
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake((bounds.size.width/2.0), (bounds.size.height/2.0));
    
    NSString *title = [datum objectForKey:@"title"];
    int fontSize = 7;
    // 타이틀을 쓴다
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentLeft];
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor blackColor],
                           NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman" size:fontSize]};
    
    float deltaX = sinf((2*startAngle + angle)/2)*56 - [title sizeWithAttributes:attr].width/2;
    float deltaY = cosf((2*startAngle + angle)/2)*56 + [title sizeWithAttributes:attr].height/2;

    deltaY *= -1;
    xPoz = center.x+deltaX;
    yPoz = center.y+deltaY;
    [title drawInRect:CGRectMake(xPoz, yPoz, 42, 40) withAttributes:attr];
}



- (void)drawArcFromData:(NSDictionary*)datum withStartAngle:(float)startAngle withColor:(UIColor*)color
{
    float angle = [self getAngleValue:datum];
    float realStartAngle = startAngle-M_PI/2;
    float realEndAngle = realStartAngle + angle;
    CGRect bounds = self.bounds;
    CGPoint center = CGPointMake((bounds.size.width/2.0), (bounds.size.height/2.0));

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addArcWithCenter:center radius:80 startAngle:realStartAngle endAngle:realEndAngle clockwise:YES];
    [color setFill];
    [path fill];
}

- (UIColor*) getPieUIColorAtIndex:(int)i {
    NSArray *colors = @[UIColorFromRGB(0xEF306A), UIColorFromRGB(0x4F88C6), UIColorFromRGB(0x48BCBC), UIColorFromRGB(0xD1E176), UIColorFromRGB(0xFDB73B)];
    return [colors objectAtIndex:i%5];
}

- (double) getRandomDouble {
    return (double)arc4random()/ARC4RANDOM_MAX;
}



- (float) getAngleValue:(NSDictionary*)datum {
    NSLog(@"%@",datum);
    int total = [self getTotalValue];
    return ((float)[[datum objectForKey:@"percentage"] integerValue]/(float)total)*M_PI*2;
}



-(int) getTotalValue {
    int total = 0;
    for (NSDictionary *datum in data) {
        int value = [[datum objectForKey:@"percentage"] integerValue];
        total += value;
    }
    return total;
}

- (void)drawRect:(CGRect)rect
{
    float angle = 0;
    int i = 0;
    for (NSDictionary *datum in data) {
        [self drawArcFromData:[data objectAtIndex:i] withStartAngle:angle withColor:[self getPieUIColorAtIndex:i]];
        angle += [self getAngleValue:datum];
        i++;
    }
    
    angle = 0;
    i = 0;
    for (NSDictionary *datum in data) {
        [self drawLabelFromData:[data objectAtIndex:i] withStartAngle:angle withColor:[self getPieUIColorAtIndex:i]];
        angle += [self getAngleValue:datum];
        i++;
    }
}

- (void) setData:(NSArray*) data_ {
    data = data_;
    // 업데이트가 될 때 마다 새로그린다.
    [self setNeedsDisplay];
}

- (int) getMaxValue {
    int max = 0;
    for (NSDictionary *datum in data) {
        int value = [[datum objectForKey:@"percentage"] integerValue];
        if(max < value) {
            max = value;
        }
    }
    return max;
}

@end

