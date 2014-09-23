//
//  ViewController.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "CommunityParsor.h"

#import "ViewController.h"

#import "ArticleCard.h"

@interface ViewController ()
{
    CommunityParsor *community_parsor;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    community_parsor = [[CommunityParsor alloc] init];
    NSLog(@"%@",[community_parsor getFirstArticleCard]);
    /*
    NSLog(@"!!");
    ArticleCard* articleCard = [[ArticleCard alloc] init];
    [articleCard setArticleCard:[community_parsor getFirstArticleCard]];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    float elementWidth = (float)self.scroll.frame.size.width;
    
    CGRect articleCardViewFrame = CGRectMake(elementWidth, 0, elementWidth, screenHeight);
    [articleCard setFrame:articleCardViewFrame];
    articleCard.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    //  스크롤 뷰의 내부크기를 설정한다.

    float scrollContentWidth = 2 * elementWidth;
    [self.scroll setContentSize:CGSizeMake(scrollContentWidth, screenHeight)];
    
    [self.scroll addSubview:articleCard];
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
