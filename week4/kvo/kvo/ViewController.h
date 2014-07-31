//
//  ViewController.h
//  notification
//
//  Created by KIM HEE JAE on 7/31/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RockScissorPaper.h"

@interface ViewController : UIViewController
{
    RockScissorPaper *rockScissorPaper;
}
@property (weak, nonatomic) IBOutlet UIImageView *myHand;
@end
