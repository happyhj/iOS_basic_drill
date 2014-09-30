//
//  SimpleThumbnailVC.h
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleThumbnailVC : UIViewController {
    
}
//@property (nonatomic, retain) UIView *simpleThumbnailView;
@property (nonatomic, strong) IBOutlet UILabel *subjectTitle;

- (IBAction) touchMeAction;
- (void) initViewWithAttribute:(NSDictionary*) data;
@end
