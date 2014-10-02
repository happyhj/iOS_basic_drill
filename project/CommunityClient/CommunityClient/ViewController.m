//
//  ViewController.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/2/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "Communities.h"
#import "Board.h"

#import "ViewController.h"

#import "ArticlesView.h"
#import "BoardsView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet ArticlesView * articlesView;
@property (weak, nonatomic) IBOutlet BoardsView * boardsView;
@end

@implementation ViewController
{
    Communities * communities;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    communities = [[Communities alloc]init];
    [communities prepareForEveryFirstPageArticles];
    
    NSLog(@"이제 뷰를 건드리자");
    Board* board = [[communities communityAtIndex:0] boardAtIndex:0];
    //    [_articlesView renderViewWithBoard:board];
    //[_articlesView renderViewWithBoard:board];
    [_articlesView renderViewWithBoard:board];
    // 첫번째
    return;
}
- (IBAction)toggleArticleView:(id)sender {
    UIScrollView * scroll = (ArticlesView *)[sender view];
    CGPoint tapPoint = [sender locationInView:scroll];
    [_articlesView toggleViewWithTapPositionX:tapPoint.x];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
