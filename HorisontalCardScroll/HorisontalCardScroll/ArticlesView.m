//
//  ArticlesView.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ArticlesView.h"
#import "SimpleThumbnailVC.h"

@implementation ArticlesView
{
    NSMutableArray *subViews; // 이것도 유지하면 독이다. 속에것
    NSMutableArray *cardContainerCacheArray;
    NSArray *model;
    
    int currentBoardIndex;
    
    int defaultNumOfCards;
    float cardWidth;
    float cardHeight;
    float foldAnimationTimeDiff;
}

- (void) setModelReference:(NSArray*) modelRef
{
    model = modelRef;
    
    // 카드 컨테이너 캐시 초기화 : 크기는 화면 폭 해당하는 카드 수 + 2로
//    self->cardContainerCacheArray  = [NSMutableArray arrayWithCapacity:[[modelRef[currentBoardIndex] objectForKey:@"articles"] intValue]];
/*
    for ( int i=0 ;i<[self.imageCount intValue];i++) {
        [self.imageCacheArray addObject:[NSNull null]];
    }
 */
}
- (void) renderArticlesInBoardAtIndex:(int) boardIndex
{
    currentBoardIndex = boardIndex;
    NSArray* articles = [[model objectAtIndex:currentBoardIndex] objectForKey:@"articles"];

    defaultNumOfCards = [articles count];
    cardWidth = 180.0;
    cardHeight = 260.0;
    
    foldAnimationTimeDiff = .3;
    
    [self setContentSize:CGSizeMake(cardWidth * defaultNumOfCards, cardHeight)];
    
    subViews = [[NSMutableArray alloc] init];
    // 서브뷰 컨트롤러의 인스턴스들을 필요한 갯수 만큼 생성한다.
    for (int i = 0; i < defaultNumOfCards; i++) {
        SimpleThumbnailVC *simpleThumbnailVC = [[SimpleThumbnailVC alloc] initWithNibName:@"SimpleThumbnailVC" bundle:nil];
        [simpleThumbnailVC initViewWithAttribute:articles[i]];
        [subViews addObject:simpleThumbnailVC];
    }
    
    // 서브뷰를 스크롤 뷰 안에 추가한 후에 서브뷰의 프레임을 설정한다.
    SimpleThumbnailVC *simpleThumbnailVC = nil;
    for (int i = 0; i < defaultNumOfCards ; i++) {
        simpleThumbnailVC = (SimpleThumbnailVC*)[subViews objectAtIndex:i];
        UIView * cardContainerView = [[UIView alloc] init];
        CGRect cardViewFrame = CGRectMake(i*cardWidth,0, cardWidth, cardHeight);
        [cardContainerView setFrame:cardViewFrame];
        [cardContainerView setBackgroundColor:[UIColor colorWithWhite:.05*i+0.5 alpha:.8]];
        [self addSubview:cardContainerView];
        
        [simpleThumbnailVC.view setFrame:CGRectMake(0,0, cardWidth, cardHeight)];
        [cardContainerView addSubview:simpleThumbnailVC.view];
    }
}


/*
- (void) stuffSubviewsWithAttributes:(NSArray*)data
{
    
    defaultNumOfCards = [data count];
    cardWidth = 180.0;
    cardHeight = 260.0;
    

    foldAnimationTimeDiff = .5;
    
    [self setContentSize:CGSizeMake(cardWidth * defaultNumOfCards, cardHeight)];

    subViews = [[NSMutableArray alloc] init];
    // 서브뷰 컨트롤러의 인스턴스들을 필요한 갯수 만큼 생성한다.
    for (int i = 0; i < defaultNumOfCards; i++) {
        SimpleThumbnailVC *simpleThumbnailVC = [[SimpleThumbnailVC alloc] initWithNibName:@"SimpleThumbnailVC" bundle:nil];
        [simpleThumbnailVC initViewWithAttribute:data[i]];
        [subViews addObject:simpleThumbnailVC];
    }

    // 서브뷰를 스크롤 뷰 안에 추가한 후에 서브뷰의 프레임을 설정한다.
    SimpleThumbnailVC *simpleThumbnailVC = nil;
    for (int i = 0; i < defaultNumOfCards ; i++) {
        simpleThumbnailVC = (SimpleThumbnailVC*)[subViews objectAtIndex:i];
        UIView * cardContainerView = [[UIView alloc] init];
        CGRect cardViewFrame = CGRectMake(i*cardWidth,0, cardWidth, cardHeight);
        [cardContainerView setFrame:cardViewFrame];
        [cardContainerView setBackgroundColor:[UIColor colorWithWhite:.05*i+0.5 alpha:.8]];
        [self addSubview:cardContainerView];
        
        [simpleThumbnailVC.view setFrame:CGRectMake(0,0, cardWidth, cardHeight)];
        [cardContainerView addSubview:simpleThumbnailVC.view];

    }
}
*/


// 터치좌표를 통해 몇번째 카드가 탭이 되었는지 알려주기
- (int) getTouchedCardIndex:(float) tapPointX inView:(UIScrollView *) scrollView
{
    if(!scrollView.pagingEnabled)
    {
        int tapPointX_ = (int)tapPointX;
        return tapPointX_ / (int)cardWidth;
    } else {
        int tapPointX_ = (int)tapPointX;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        return tapPointX_ / (int)screenWidth;
    }
    
}
- (void) toggleViewWithTapPositionX:(float)positionX
{
    [self.layer removeAllAnimations];
    if(!self.pagingEnabled)
    {
        int cardIndex = [self getTouchedCardIndex:positionX inView:self];
        NSLog(@"%d 번째 카드 탭",cardIndex);
        [UIView animateWithDuration:foldAnimationTimeDiff
                         animations:^{
                             CGRect screenRect = [[UIScreen mainScreen] bounds];
                             CGFloat screenWidth = screenRect.size.width;
                             CGFloat screenHeight = screenRect.size.height;
                             
                             // 스크롤의 뷰 포트를 화면 크기로 키우고.
                             float statusHeight = 0;
                             float bigCardHeight = screenHeight-statusHeight;
                             [self setFrame:CGRectMake(0,statusHeight, screenWidth, bigCardHeight)];
                             
                             // 각 카드의 크기도 화면 크기로 키우고.
                             SimpleThumbnailVC *simpleThumbnailVC = nil;
                             for (int i = 0; i < defaultNumOfCards ; i++) {
                                 simpleThumbnailVC = (SimpleThumbnailVC*)[subViews objectAtIndex:i];
                                 CGRect newCardViewFrame = CGRectMake(i*screenWidth,0, screenWidth , bigCardHeight);
                                 [[simpleThumbnailVC.view superview] setFrame:newCardViewFrame];
                             }
                             
                             // 스크롤의 콘텐츠 크기를 카드의 합으로 키우고
                             [self setContentSize:CGSizeMake(screenWidth * [subViews count], bigCardHeight)];
                             
                             // Pagenation yes로 바꾼다.
                             [self setPagingEnabled:YES];
                             
                             // 선택된 카드로 스크롤 이동시키기
                             [self setContentOffset:CGPointMake(cardIndex*screenWidth, 0) animated:NO];
                         }
                         completion:^(BOOL finished){
                         }];
    }
    
    else if(self.pagingEnabled)
    {
        int cardIndex = [self getTouchedCardIndex:positionX inView:self];
        NSLog(@"%d 번째 카드 탭",cardIndex);
        [UIView animateWithDuration:foldAnimationTimeDiff
                         animations:^{
                             CGRect screenRect = [[UIScreen mainScreen] bounds];
                             CGFloat screenWidth = screenRect.size.width;
                             CGFloat screenHeight = screenRect.size.height;
                             
                             // Pagenation NO로 바꾼다.
                             [self setPagingEnabled:NO];

                             // 각 카드의 크기도 원래대로 줄이고
                             SimpleThumbnailVC *simpleThumbnailVC = nil;
                             for (int i = 0; i < defaultNumOfCards ; i++) {
                                 simpleThumbnailVC = (SimpleThumbnailVC*)[subViews objectAtIndex:i];
                                 NSLog(@"cardHeight : %f",cardHeight);
                                 CGRect newCardViewFrame = CGRectMake(i*cardWidth,0, cardWidth , cardHeight);
                                 [[simpleThumbnailVC.view superview] setFrame:newCardViewFrame];
                             }
                            
                             // 스크롤의 콘텐츠 크기를 카드의 합으로 줄이고
                             [self setContentSize:CGSizeMake(cardWidth * defaultNumOfCards, cardHeight)];
                             
                             // 스크롤의 뷰 포트를 화면 원래대로 되돌리고.
                             [self setFrame:CGRectMake(0,screenHeight-cardHeight, screenWidth, cardHeight)];
                             
                             // 선택된 카드로 스크롤 이동시키기
                             int outterCardCount;
                             BOOL isLeftSide = false;
                             outterCardCount = defaultNumOfCards - (cardIndex + 1);
                             if(outterCardCount > cardIndex) {
                                 // 좌측 끝임
                                 NSLog(@"좌측 끝임");
                                 outterCardCount = cardIndex;
                                 isLeftSide = true;
                             }
                             NSLog(@"%d",outterCardCount);
                             if((outterCardCount+0.5)*cardWidth > screenWidth/2) {
                                 NSLog(@"중앙으로 되돌리기");
                                 [self setContentOffset:CGPointMake(cardIndex*cardWidth - screenWidth/2 + cardWidth/2, 0) animated:NO];
                             }
                             else {
                                 NSLog(@"끝으로 되돌리기");
                                 if(isLeftSide) {
                                     [self setContentOffset:CGPointMake(0, 0) animated:NO];
                                 }
                                 else {
                                     [self setContentOffset:CGPointMake(cardWidth * defaultNumOfCards - screenWidth, 0) animated:NO];
                                 }
                             }
                             
                         }
                         completion:^(BOOL finished){
                         }];
        
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
