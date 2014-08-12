//
//  ViewController.h
//  ScrollView
//
//  Created by KIM HEE JAE on 8/7/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) NSMutableArray *imageCacheArray;

@property (strong, nonatomic) NSNumber *imageCount;
@property (strong, nonatomic) NSNumber *visibleImageCount;
@property (strong, nonatomic) NSNumber *scrollContentHeight;
@property (strong, nonatomic) NSNumber *imageHeight;
- (int) isVisibleImageAtOffset:(int) offset;
@end
