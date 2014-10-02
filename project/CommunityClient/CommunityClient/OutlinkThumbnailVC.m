//
//  OutlinkThumbnailVC.m
//  CommunityClient
//
//  Created by KIM HEE JAE on 9/30/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "OutlinkThumbnailVC.h"

@interface OutlinkThumbnailVC ()
{
    NSDictionary * articleData;
}
@property (weak, nonatomic) IBOutlet UIImageView *outlink_imageview;
@property (weak, nonatomic) IBOutlet UILabel *outlink_title;
//@property (weak, nonatomic) IBOutlet UILabel *outlink_description;

@end

@implementation OutlinkThumbnailVC
- (void) initViewWithAttribute:(NSDictionary*) data
{
    articleData = data;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.outlink_title setText:[[articleData objectForKey:@"meta"] objectForKey:@"article_title"]];
    NSURL *url = [NSURL URLWithString:[articleData objectForKey:@"article_img"][0]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    _outlink_imageview.image = img;
    
    //set contentMode to scale aspect to fit
//    _outlink_imageview.contentMode = UIViewContentModeScaleAspectFill;
    _outlink_imageview.contentMode = UIViewContentModeScaleAspectFit;

    _outlink_imageview.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
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
