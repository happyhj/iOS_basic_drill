//
//  ViewController.h
//  Carousel
//
//  Created by KIM HEE JAE on 8/5/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) NSMutableArray *animals;
@property (strong, nonatomic) NSMutableArray *descriptions;

@property (nonatomic) BOOL wrap;

@property (weak, nonatomic) IBOutlet UIView *aCarousel;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
