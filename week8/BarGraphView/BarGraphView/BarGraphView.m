//
//  BarGraphView.m
//  BarGraphView
//
//  Created by KIM HEE JAE on 8/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "BarGraphView.h"

@implementation BarGraphView

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
    float width = [self bounds].size.width;
    float height = [self bounds].size.height;
    
    int initialYPoz = 20;
    int gap = 60;
    float lineWidth = 30;
    
    UIColor *lineColor = [UIColor colorWithRed:.2 green:.2 blue:.9 alpha:.9];
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    // 데이터 하나씩 막대그래프를 그린다.
    for (NSDictionary* datum in data) {
        [self drawSingleDataAtYPosition:initialYPoz withData:datum withLineWidth:lineWidth withColor:lineColor];
        initialYPoz += gap;
    }
    
    // 가이드를 그린다.
    int startXpoz = 90 * width/200;
    int endXpoz = 190 * width/200;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(startXpoz, 10);
    
    [path moveToPoint:startPoint];
    CGPoint nextPoint =  CGPointMake(startXpoz, gap * ([data count])+10);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:1];
    [[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:.7]set];
    //[[UIColor blackColor] set];
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 0.0, nil);

    [path stroke];
}


- (void) drawSingleDataAtYPosition:(int) Ypos withData:(NSDictionary*) data_ withLineWidth:(float)lineWidth withColor:(UIColor*)lineColor
{
    float width = [self bounds].size.width;
    float height = [self bounds].size.height;
    
    int value= [[data_ objectForKey:@"value"] integerValue];
    NSString *title = [data_ objectForKey:@"title"];
    int fontSize = 30;

    CGContextRef context = UIGraphicsGetCurrentContext();

    // 타이틀을 쓴다
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentRight];
    NSDictionary *attr = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:0 blue:0 alpha:.8],
                           NSParagraphStyleAttributeName:style,
                           NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:fontSize]};
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 0.0), 0.8, nil);
    [title drawInRect:CGRectMake(10 * width/200 ,Ypos, 70 * width/200, 40) withAttributes:attr];
    // 값을 그린다
    int startXpoz = 90 * width/200;
    int endXpoz = 190 * width/200;
    int maxValue = [self getMaxValue];
    int resultXpoz = startXpoz + ((float)value/(float)maxValue) * (endXpoz-startXpoz);
    CGPoint point = CGPointMake(startXpoz,Ypos+fontSize/2.0 + 4);

    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetShadowWithColor(context, CGSizeMake(3, 1), 3.0, [[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:.3] CGColor]);
 
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = point;
    
    [path moveToPoint:startPoint];
    CGPoint nextPoint =  CGPointMake(resultXpoz,Ypos+fontSize/2.0 + 4);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:lineWidth];
    [lineColor set];
    [path stroke];
    
}
- (void) setData:(NSArray*) data_ {
    data = data_;
    
    // 업데이트가 될 때 마다 새로그린다.
    [self setNeedsDisplay];
}
- (int) getMaxValue {
    int max = 0;
    for (NSDictionary *datum in data) {
        int value = [[datum objectForKey:@"value"] integerValue];
 //       NSLog(@"%d",value);
        if(max < value) {
            max = value;
        }
    }
    return max;
}

@end
