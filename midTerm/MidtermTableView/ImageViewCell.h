//
//  ImageViewCell.h
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;

@end
