//
//  ViewController.m
//  basic_POP
//
//  Created by KIM HEE JAE on 7/29/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"
#import <POP/POP.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(tapGesturePerformed:)];
    pgr.delegate = self;
    [_imageView addGestureRecognizer:pgr];    
}
- (IBAction)tapGesturePerformed:(id)sender {
    NSLog(@"%@",sender);
 //   if (sender.view == UIImageView)
    {
    [self performFullScreenAnimation];
    _isInFullscreen = !_isInFullscreen;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)performFullScreenAnimation
{
    [self.widthConstraint pop_removeAllAnimations];
    [self.heightConstraint pop_removeAllAnimations];
    
    POPSpringAnimation *heightAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    heightAnimation.springBounciness = 10;
    
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayoutConstraintConstant];
    animation.springBounciness = 10;
    
    if (!_isInFullscreen)
    {
        animation.toValue = @(600.);
        heightAnimation.toValue = @(570);
    }
    else
    {
        animation.toValue = @(126.);
        heightAnimation.toValue = @(223.);
    }
    
    [self.heightConstraint pop_addAnimation:heightAnimation forKey:@"fullscreen"];
    [self.widthConstraint pop_addAnimation:animation forKey:@"fullscreen"];
    
}

@end
