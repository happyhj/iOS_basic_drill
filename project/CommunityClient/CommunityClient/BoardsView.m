//
//  BoardsView.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/29/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "BoardsView.h"
#import "BoardBannerVC.h"

@implementation BoardsView
{
    int defaultNumOfCards;
    float cardWidth;
    float cardHeight;
    float foldAnimationTimeDiff;
}

- (void) stuffSubviewsWithAttributes:(NSArray*)data
{
    defaultNumOfCards = [data count];
    
    cardWidth = [self.superview bounds].size.width;
    cardHeight = [self.superview bounds].size.height;
    NSLog(@"%f",cardWidth);
    
    foldAnimationTimeDiff = .5;

    [self setContentSize:CGSizeMake(cardWidth * defaultNumOfCards, cardHeight)];
    
    subViews = [[NSMutableArray alloc] init];
    // 서브뷰 컨트롤러의 인스턴스들을 필요한 갯수 만큼 생성한다.
    for (int i = 0; i < defaultNumOfCards; i++) {
        BoardBannerVC *boardBannerVC = [[BoardBannerVC alloc] initWithNibName:@"BoardBannerVC" bundle:nil];
        [boardBannerVC initViewWithAttribute:data[i]];
        [subViews addObject:boardBannerVC];
    }
    
    // 서브뷰를 스크롤 뷰 안에 추가한 후에 서브뷰의 프레임을 설정한다.
    BoardBannerVC *boardBannerVC = nil;
    for (int i = 0; i < defaultNumOfCards ; i++) {
        boardBannerVC = (BoardBannerVC*)[subViews objectAtIndex:i];
        UIView * cardContainerView = [[UIView alloc] init];
        CGRect cardViewFrame = CGRectMake(i*cardWidth,0, cardWidth, cardHeight);
        [cardContainerView setFrame:cardViewFrame];
        [cardContainerView setBackgroundColor:[UIColor colorWithWhite:.05*i+0.5 alpha:.8]];
        [self addSubview:cardContainerView];
        
        [boardBannerVC.view setFrame:CGRectMake(0,0, cardWidth, cardHeight)];
        [cardContainerView addSubview:boardBannerVC.view];
    }


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
