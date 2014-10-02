//
//  SimpleThumbnailVC.m
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "SimpleThumbnailVC.h"
//#import <QuartzCore/QuartzCore.h>

@interface SimpleThumbnailVC ()
@end

@implementation SimpleThumbnailVC
{
    NSDictionary * articleData;
    
    NSString * subjectStr;
}
- (IBAction) touchMeAction
{
    NSLog(@"Touched!");
    [self.view setBackgroundColor:[UIColor colorWithRed:.9 green:.1 blue:.9 alpha:1]];
}

- (void) initViewWithAttribute:(NSDictionary*) data {
    articleData = data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.subjectTitle setText:[[articleData objectForKey:@"meta"] objectForKey:@"article_title"]];
    
    NSMutableString * contentStr = [[NSMutableString alloc]init];
    for(NSString * line in [articleData  objectForKey:@"article_text"]) {
        [contentStr appendString:line];
        [contentStr appendString:@"\n"];
    }
    [self.content setText:contentStr];

    //textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.content.numberOfLines = 0;
    
 //   self.view.layer.cornerRadius = 5;
 //   self.view.layer.masksToBounds = YES;

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
