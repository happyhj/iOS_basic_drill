//
//  ArticleCard.h
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCard : UIView
@property (weak, nonatomic) IBOutlet UILabel *author_name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *author_image;

@property (weak, nonatomic) IBOutlet UILabel *text_content;
@property (weak, nonatomic) IBOutlet UIImageView *image_content;
- (void) setArticleCard:(NSDictionary*)articleItem;
@end
