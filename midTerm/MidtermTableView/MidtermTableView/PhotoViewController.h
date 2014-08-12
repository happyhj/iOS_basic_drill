//
//  PhotoViewController.h
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController

@property (strong, nonatomic)          NSString *title;
@property (strong, nonatomic)          NSString *image;
@property (strong, nonatomic)          NSString *date;

@property (weak, nonatomic) IBOutlet UILabel *photoTitle;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *photoDate;
- (void)setDetailItem:(NSDictionary*)newDetailItem;
@end
