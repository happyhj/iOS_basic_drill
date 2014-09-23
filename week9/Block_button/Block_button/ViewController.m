//
//  ViewController.m
//  Block_button
//
//  Created by KIM HEE JAE on 9/4/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"
#define ARC4RANDOM_MAX      0x100000000

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // completion을 통해 애니메이션이 끝나는 시점을 통해 +@를 할 수 있습니다.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTouchedHandler:(id)sender {
    [UIView animateWithDuration:0.3
                     animations:^{
                         CGRect screenRect = [[UIScreen mainScreen] bounds];
                         CGFloat screenWidth = screenRect.size.width;
                         CGFloat screenHeight = screenRect.size.height;
                         
                         UIButton *button = (UIButton *)sender;

                         NSLog(@"%@",button);
                         CGPoint randomPosition =[self getRandomCGPointInScreen];
                         double width = [self getRandomBetween:250 and:600];
                         double height = [self getRandomBetween:250 and:600];
                         
                         [button setFrame:CGRectMake(randomPosition.x*((screenWidth-width)/screenWidth),randomPosition.y*((screenHeight-height)/screenHeight), width, height)];
                         [button setBackgroundColor:[self getRandomColor]];
                         NSArray * greetings = @[@"Hello",@"안녕하세요",@"Aloha",@"¡Hola!",@"今日は",@"Ciao!",@"สวัสดี",@"Здравствуйте!",@"Selamat pagi",@"Guten Tag"];
                         
                         [button setTitle:[greetings objectAtIndex:(int)([greetings count]*[self getRandomDouble])] forState:UIControlStateNormal];
                         
                         button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40+[self getRandomDouble]*20];
                         [button setTitleColor:[UIColor colorWithRed:[self getRandomDouble] green:[self getRandomDouble] blue:[self getRandomDouble] alpha:1] forState:UIControlStateNormal];

                     }             // 애니메이션 투명도 0.0으로 만들기
                     completion:^(BOOL finished){
                         sleep(.3);
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              CGRect screenRect = [[UIScreen mainScreen] bounds];
                                              CGFloat screenWidth = screenRect.size.width;
                                              CGFloat screenHeight = screenRect.size.height;
                                              
                                              UIButton *button = (UIButton *)sender;
                                              
                                              NSLog(@"%@",button);
                                              CGPoint randomPosition =[self getRandomCGPointInScreen];
                                              double width = [self getRandomBetween:250 and:600];
                                              double height = [self getRandomBetween:250 and:600];
                                              
                                              [button setFrame:CGRectMake(randomPosition.x*((screenWidth-width)/screenWidth),randomPosition.y*((screenHeight-height)/screenHeight), width, height)];
                                              [button setBackgroundColor:[self getRandomColor]];
                                              NSArray * greetings = @[@"Hello",@"안녕하세요",@"Aloha",@"¡Hola!",@"今日は",@"Ciao!",@"สวัสดี",@"Здравствуйте!",@"Selamat pagi",@"Guten Tag"];
                                              
                                              [button setTitle:[greetings objectAtIndex:(int)([greetings count]*[self getRandomDouble])] forState:UIControlStateNormal];
                                              
                                              button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40+[self getRandomDouble]*20];
                                              [button setTitleColor:[UIColor colorWithRed:[self getRandomDouble] green:[self getRandomDouble] blue:[self getRandomDouble] alpha:1] forState:UIControlStateNormal];
                                              
                                          }             // 애니메이션 투명도 0.0으로 만들기
                                          completion:^(BOOL finished){
                                              
                                          }];
                     }];
}


- (double) getRandomDouble {
    return (double)arc4random()/ARC4RANDOM_MAX;
}

- (double) getRandomBetween:(int)num1 and:(int)num2 {
    double seed = (double)arc4random()/ARC4RANDOM_MAX;
    seed *= (num2-num1);
    seed += num1;
    return seed;
}
- (UIColor*) getRandomColor {
    return [UIColor colorWithRed:[self getRandomDouble] green:[self getRandomDouble] blue:[self getRandomDouble] alpha:[self getRandomDouble]];

}
- (CGPoint) getRandomCGPointInScreen {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGPoint point = CGPointMake([self getRandomDouble]*screenWidth, [self getRandomDouble]*screenHeight);
    return point;
}


@end
