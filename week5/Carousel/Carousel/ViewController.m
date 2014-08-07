//
//  ViewController.m
//  Carousel
//
//  Created by KIM HEE JAE on 8/5/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize animals, descriptions;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //set up carousel data
        self.wrap = NO;
        
        self.animals = [NSMutableArray arrayWithObjects:@"Bear.png",
                        @"Zebra.png",
                        @"Tiger.png",
                        @"Goat.png",
                        @"Birds.png",
                        @"Giraffe.png",
                        @"Chimp.png",
                        nil];
        
        self.descriptions = [NSMutableArray arrayWithObjects:@"Bears Eat: Honey",
                             @"Zebras Eat: Grass",
                             @"Tigers Eat: Meat",
                             @"Goats Eat: Weeds",
                             @"Birds Eat: Seeds",
                             @"Giraffes Eat: Trees",
                             @"Chimps Eat: Bananas",
                             nil];
    }
    
    return self;
}

#pragma - mark iCarousel Delegate

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.animals count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    // limit the number of item views loaded concurrently (for performance)
    return 7;
}

- (UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    // create a numbered view
    view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[animals objectAtIndex:index]]];
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    // usually this should be slightly wider than the item views
    return 240;
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return self.wrap;
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    [self.label setText:[NSString stringWithFormat:@"%@", [descriptions objectAtIndex:carousel.currentItemIndex]]];
}

@end
