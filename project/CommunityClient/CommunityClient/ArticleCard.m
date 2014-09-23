//
//  ArticleCard.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ArticleCard.h"

@implementation ArticleCard

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setArticleCard:(NSDictionary*)articleItem
{
    if([articleItem objectForKey:@"article_text"] != nil)
        self.text_content.text = [articleItem objectForKey:@"article_text"];
    if([[articleItem objectForKey:@"meta"] objectForKey:@"author_image"] != nil) {
        // url 을 통해 이미지를 확보해서 할당 하기
        NSURL * imageURL = [NSURL URLWithString:[[articleItem objectForKey:@"meta"] objectForKey:@"author_image"]];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        self.author_image.image = image;
    }
    if([[articleItem objectForKey:@"meta"] objectForKey:@"author_name"] != nil)
        self.text_content.text = [[articleItem objectForKey:@"meta"] objectForKey:@"author_name"];
    
    self.title.text = [[articleItem objectForKey:@"meta"] objectForKey:@"article_title"];
    
    // 사진 세팅
    if([articleItem objectForKey:@"article_img"] != nil && [[articleItem objectForKey:@"article_img"] count] > 0) {
        // 첫번째 사진 의 url을 통해 확보한 이미지를  할당하기
        //
        NSURL * imageURL = [NSURL URLWithString:[[articleItem objectForKey:@"article_img"] objectAtIndex:0]];
        NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage * image = [UIImage imageWithData:imageData];
        self.image_content.image = image;
    }
}

@end
