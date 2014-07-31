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

    // 모델 인스턴스 만들기
    rockScissorPaper = [[RockScissorPaper alloc] init];
    // 옵저버 등록
    [rockScissorPaper addObserver:self
                             forKeyPath:@"handString"
                                options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                                context:NULL];

    // 첫 이미지 세팅
    UIImage *image = [UIImage imageNamed: @"start.png"];
    [_myHand setImage:image];
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

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"handString"]) {
        NSString *newHand = [change objectForKey:@"new"];
        NSLog(@"%@", newHand);
        NSMutableString *handPicResource = [newHand mutableCopy];
        [handPicResource  appendString:@".png"];        
        UIImage *handImage = [UIImage imageNamed: handPicResource];
        [_myHand setImage:handImage];
    }
}

@end
