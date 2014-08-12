//
//  ViewController.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 모델의 데이터가 초기화 되었는지 지켜보도록 Observer로 등록
    [[NSNotificationCenter defaultCenter] addObserver:self // 알림을 내가 받을 것이다.
                                             selector:@selector(receiveNotification:) // 알림을 받으면 실행할 메소드
                                                 name:nil // 알림의 이름, 일단 어떤알림이든 다 받은 다음 내가원하는것인지 보고 처리
                                               object:nil]; // 어디에서 알림을 발행했는지 쳐다보고 싶은 대상. 누가발행했든 상관없이 알고 싶으면 nil

    
    //  모델초기화할 데이터를 JSON string으로 마련
    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";

    // 모델 인스턴스 만들고 데이터 초기화
    appModel = [[AppModel alloc] initWithUTF8String:data];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveNotification:(NSNotification *) notification
{

    if ([[notification name] isEqualToString:@"modelInitializedNotification"]) {
        NSLog (@"modelInitialized Notification received!");
        // 여기서 테이블 뷰를 리로드 해야함 
    }

}




@end
