//
//  ViewController.h
//  basic_POP
//
//  Created by KIM HEE JAE on 7/29/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    BOOL _isInFullscreen;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (void)performFullScreenAnimation;

@end
