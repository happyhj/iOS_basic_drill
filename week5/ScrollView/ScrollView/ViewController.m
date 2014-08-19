//
//  ViewController.m
//  ScrollView
//
//  Created by KIM HEE JAE on 8/7/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.imageCount = @(22);
    self.imageHeight = @((int)self.scroll.frame.size.height);
    self.scrollContentHeight = @([self.imageCount intValue] * [self.imageHeight intValue]);
    self.visibleImageCount = @((int)self.scroll.frame.size.height/[self.imageHeight intValue] +1);
    
    self.imageCacheArray  = [NSMutableArray arrayWithCapacity:[self.imageCount intValue]];
    for ( int i=0 ;i<[self.imageCount intValue];i++) {
        [self.imageCacheArray addObject:[NSNull null]];
    }
    
    for ( int i=0 ;i<[self.imageCount intValue];i++) {
        if(i<[self.visibleImageCount intValue]){
            // [UIImage imageNamed 는 내부적으로 캐쉬를 하므로 많은 양의 이미지를 이용하는 앱일 경우 쓰지마라
            [self addImageSubViewAtIndex:i];
        } else {
            [self.imageCacheArray replaceObjectAtIndex:i withObject:[NSNull null]];
        }
    }
    
    [self.scroll setContentSize:CGSizeMake(self.scroll.frame.size.width,[self.imageHeight intValue]*[self.imageCount intValue])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [scrollView contentOffset].y
    NSLog(@"%@",self.imageCacheArray);
    int index = [self isVisibleImageAtOffset:[scrollView contentOffset].y];
    if(index <= 0) {
        return;
    }
    for (int i=0; i < [self.imageCount intValue] ; i++) {
        //// 결과로 나온 index 를 기준으로
        //// index, index+1, index+2, ~ index+(self.visibleImageCount-1) 까지의 원소를 확인하고 NSNULL이라면 해당하는 ImgageView로 replace
        id element = [self.imageCacheArray objectAtIndex:i];
        if( (i >= index-1) && (i <= index+[self.visibleImageCount intValue]+1)) {
            // 보여야 하는데 캐쉬에 안보이는걸로 되어있다.
            if(![element isKindOfClass:[UIImageView class]]) {
                [self addImageSubViewAtIndex:i];
            }
        } else { // 보이면 안되는데 캐쉬에 보이는 걸로 되어있따!
            // ImageView에서 Image를 메모리 해제하도록 한다.
            if([element isKindOfClass:[UIImageView class]]) {
                [element removeFromSuperview];
                //element = nil;
                [self.imageCacheArray replaceObjectAtIndex:i withObject:[NSNull null]];
            }
        }
    }
}

- (void) addImageSubViewAtIndex:(int) i
{
    NSMutableString *filename = [[NSString stringWithFormat:@"%02d",i+1] mutableCopy];
    NSLog(@"%@",[NSString stringWithFormat:@"%02d",i]);

    [filename appendString:@".jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filename ofType:nil]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect imageFrame = CGRectMake(0, [self.imageHeight intValue]*i, self.scroll.frame.size.width , [self.imageHeight floatValue]);
    [imageView setFrame:imageFrame];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    [self.imageCacheArray replaceObjectAtIndex:i withObject:imageView];
    [self.scroll addSubview:imageView];
}

- (int) isVisibleImageAtOffset:(int) offset
{
    int index;
    if (offset == -1) {
        index = -1;
    }
    else if (offset == 0) {
        index = 0;
    }
    else {
        index = offset /[self.imageHeight intValue]  ;
    }
    
    return index;
        
}

@end
