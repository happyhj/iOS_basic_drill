//
//  BoardBannerVC.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/30/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "BoardBannerVC.h"

@interface BoardBannerVC ()

@end

@implementation BoardBannerVC
{
    NSString * boardNameStr;
}
- (void) initViewWithAttribute:(NSDictionary*) data {
    boardNameStr = [data objectForKey:@"boardName"];
    NSLog(@"%@",[data objectForKey:@"boardName"]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.boardNameLabel setText:boardNameStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
