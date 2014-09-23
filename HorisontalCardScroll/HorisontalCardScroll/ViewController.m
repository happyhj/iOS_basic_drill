//
//  ViewController.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"
#define ARC4RANDOM_MAX      0x100000000

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 스크롤뷰의 Viewport는 스토리보드에서 지정했음.
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    float scrollWidth = self.scrollView.bounds.size.width;
    float scrollHeight = self.scrollView.bounds.size.height;

     CGRect frameRect = _scrollView.frame;
//     frameRect.origin.y = screenHeight - scrollHeight;
    frameRect.origin.y = 100;

    _scrollView.frame = frameRect;

     
    int defaultNumOfCards = 10;
    float cardWidth = 160.0;
//    [scrollView setFrame:CGRectMake(0,200, screenWidth, cardHeight)];
    


    // 스크롤뷰 내부 컨텐츠부분의 크기를 설정.
    //
    // todo: 가변적으로 될 수 있게 만들어야 함
    [self.scrollView setContentSize:CGSizeMake(cardWidth * defaultNumOfCards, scrollHeight)];
    
    // 이제 카드 subView 를 추가한다.
    for(int i=0;i<defaultNumOfCards;i++){
        UIView *cardView = [[UIView alloc]init];
        CGRect cardViewFrame = CGRectMake(i*cardWidth,0, cardWidth , scrollHeight);
        [cardView setFrame:cardViewFrame];
        [cardView setBackgroundColor:[self getRandomColor]];
        [self.scrollView addSubview:cardView];
    }

}
- (IBAction)zoomScroll:(id)sender {
    UIScrollView * scroll = (UIScrollView *)[sender view];
//    NSLog(@"%@",scroll);
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect screenRect = [[UIScreen mainScreen] bounds];
                         CGFloat screenWidth = screenRect.size.width;
                         CGFloat screenHeight = screenRect.size.height;
                         
                         //UIScrollView *scroll = (UIScrollView *)sender;
                         // 스크롤의 뷰 포트를 화면 크기로 키우고.
                         float statusHeight = 20;
                         float cardHeight = screenHeight-statusHeight;
                         
                         [scroll setFrame:CGRectMake(0,statusHeight, screenWidth, cardHeight)];
                         // 각 카드의 크기도 화면 크기로 키우고.
                         NSArray* subViews = [scroll subviews];
                         for(int i=0,cardNum=[subViews count];i<cardNum;i++){
                             UIView * subView = [subViews objectAtIndex:i];
                              CGRect newCardViewFrame = CGRectMake(i*screenWidth,0, screenWidth , cardHeight);
                              [subView setFrame:newCardViewFrame];
                         }
                         // 스크롤의 콘텐츠 크기를 카드의 합으로 키우고
                         [scroll setContentSize:CGSizeMake(screenWidth * [subViews count], cardHeight)];
                        
                         // Pagenation yes로 바꾼다.
                         [scroll setPagingEnabled:YES];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor*) getRandomColor {
    return [UIColor colorWithRed:[self getRandomDouble] green:[self getRandomDouble] blue:[self getRandomDouble] alpha:[self getRandomDouble]];
}

- (double) getRandomDouble {
    return (double)arc4random()/ARC4RANDOM_MAX;
}

@end
