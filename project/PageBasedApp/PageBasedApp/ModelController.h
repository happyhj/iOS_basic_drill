//
//  ModelController.h
//  PageBasedApp
//
//  Created by KIM HEE JAE on 8/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
