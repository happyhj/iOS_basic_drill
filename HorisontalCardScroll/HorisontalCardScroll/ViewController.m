//
//  ViewController.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"
#import "ArticlesView.h"
#import "BoardsView.h"


@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet ArticlesView * articlesView;
@property (weak, nonatomic) IBOutlet BoardsView * boardsView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *data =
        @[
          @{
            @"boardName": @"새로운소식",
            @"articles":
                @[
                    @{
                        @"title": @"WSJ: 블랙베리 패스포트 리뷰 (한글번역)"
                    },
                    @{
                        @"title": @"CloudFare, 200만 사이트들에게 무료로 SSL 지원 추가"
                    },
                    @{
                        @"title": @"GoPro, Hero4 라인업 출시"
                    },
                    @{
                        @"title": @"애플과 콜레트, 9월 30일 체험관 티저"
                    },
                    @{
                        @"title": @"삼성, 기어 S의 2.4\" 버전 테스트 중"
                    },
                    @{
                        @"title": @"LG전자, 프리미엄폰 전략 재설정…삼성과 정면승부"
                    },
                    @{
                        @"title": @"팬택 \"日 M2M 10社 협상 마무리…연 수십만대 공급\""
                    }
                ]
            },
          @{
              @"boardName": @"모두의공원",
              @"articles":
                  @[
                      @{
                          @"title": @"gsmarena.. 아이폰6 배터리..jpg"
                          },
                      @{
                          @"title": @"박정희와 김일성"
                          },
                      @{
                          @"title": @"네이버뮤직 UR BEATS는 잘 안팔리네요 ㅎ"
                          },
                      @{
                          @"title": @"여자친구가 연락이 없어요.."
                          },
                      @{
                          @"title": @"군대갈때 집에 아무 이야기 안하고 가신분 있으신가요"
                          },
                      @{
                          @"title": @"아질게성 글을 쓰고있는 당신에게."
                          },
                      @{
                          @"title": @"회사 이름짓기 귀찮음류.jpg"
                          }
                      ]
              }
          ];
//    [_articlesView renderViewWithBoard:board];
   
    [_articlesView setModelReference:data];
  [_articlesView renderArticlesInBoardAtIndex:0];

  //  [_boardsView stuffSubviewsWithAttributes:data];
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
