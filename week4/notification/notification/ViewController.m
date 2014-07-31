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
	// Do any additional setup after loading the view, typically from a nib.

    // Add this instance of TestClass as an observer of the TestNotification.
    // We tell the notification center to inform us of "TestNotification"
    // notifications using the receiveTestNotification: selector. By
    // specifying object:nil, we tell the notification center that we are not
    // interested in who posted the notification. If you provided an actual
    // object rather than nil, the notification center will only notify you
    // when the notification was posted by that particular object.
    
    [[NSNotificationCenter defaultCenter] addObserver:self // 알림을
                                             selector:@selector(receiveNotification:) // 알림을 받으면 실행할 메소드
                                                 name:@"rockScissorPaperNotification" // 알림의 이름
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
        NSLog (@"Successfully received the 묵찌빠 notification!");
        NSMutableString *handPicResource = [[notification.userInfo objectForKey:@"handString"] mutableCopy];
        [handPicResource  appendString:@".png"];
        NSLog(@"%@", [notification.userInfo objectForKey:@"handString"]);
        NSLog(@"%@", handPicResource);
        
        UIImage *handImage = [UIImage imageNamed: handPicResource];
        [_myHand setImage:handImage];
    }
}



@end
