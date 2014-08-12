//
//  ViewController.h
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppModel.h"
#import "PhotoViewController.h"

@interface AlbumViewController : UITableViewController
{
    AppModel *appModel;
    char* initalData;
}

@end
