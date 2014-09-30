//
//  BoardBannerVC.h
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/30/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardBannerVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *boardNameLabel;
- (void) initViewWithAttribute:(NSDictionary*) data;
@end
