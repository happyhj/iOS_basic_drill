//
//  ViewController.m
//  notification
//
//  Created by KIM HEE JAE on 7/31/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self // 알림을
                                             selector:@selector(receiveNotification:) // 알림을 받으면 실행할 메소드
                                                 name:nil // 알림의 이름
                                               object:nil]; // 어디에서 알림을 발행했는지 쳐다보고 싶은 대상. 누가발행했든 상관없이 알고 싶으면 nil
    
    
    // 첫 이미지 세팅
    UIImage *image = [UIImage imageNamed: @"start.png"];
    [_myHand setImage:image];
    
    
    // 모델 인스턴스 만들기
    rockScissorPaper = [[RockScissorPaper alloc] init];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 쉐이크 제스춰 인식기에 렌더마이즈 메소드 실행을 연결한다.
    if (motion == UIEventSubtypeMotionShake)
    {
        [rockScissorPaper randomize];
    }
}


- (void) receiveNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"rockScissorPaperNotification"]) {
        NSLog (@"rockScissorPaperNotification notification received!");
        NSMutableString *handPicResource = [[notification.userInfo objectForKey:@"handString"] mutableCopy];
        [handPicResource  appendString:@".png"];
        UIImage *handImage = [UIImage imageNamed: handPicResource];
        [_myHand setImage:handImage];
    }
    else if ([[notification name] isEqualToString:@"needToSave"]) {
        NSLog(@"저장할 필요가 있다");
        [rockScissorPaper saveStatus];
    }
    else if ([[notification name] isEqualToString:@"needToLoad"]) {
        NSLog(@"로드할 필요가 있다");
        [rockScissorPaper loadStatus];
    }
}


@end
