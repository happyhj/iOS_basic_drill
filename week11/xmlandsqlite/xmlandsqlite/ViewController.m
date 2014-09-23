//
//  ViewController.m
//  xmlandsqlite
//
//  Created by KIM HEE JAE on 9/18/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
@interface ViewController ()
{
    sqlite3 *_database;
    NSMutableArray* songs;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"top25"
                                                        ofType:@"db"];
    
    if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
    }
    NSMutableArray* song_list = [[NSMutableArray alloc]init];
    NSString *query = @"SELECT id, title, category, image FROM tbl_songs";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int unique_id = sqlite3_column_int(statement, 0);
            char *title = (char *) sqlite3_column_text(statement, 1);
            ;
            char *category = (char *) sqlite3_column_text(statement, 2);
            char *image = (char *) sqlite3_column_text(statement, 3);
            NSDictionary* label = @{
              @"title":[NSString stringWithUTF8String:title],
              @"category":[NSString stringWithUTF8String:category],
              @"image":[NSString stringWithUTF8String:image],
              @"id":[NSNumber numberWithInt:unique_id]
            };
            [song_list addObject:label];
        }
        sqlite3_finalize(statement);
    }
    
    songs = song_list;
    //NSLog(@"%@",song_list);
    rssPatcher* rss = [[rssPatcher alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"subtitleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[songs objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[songs objectAtIndex:indexPath.row] objectForKey:@"category"];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *image = [[songs objectAtIndex:indexPath.row] objectForKey:@"image"];

    NSURL *url = [NSURL URLWithString:image];
    
    if (![[UIApplication sharedApplication] openURL:url]) {
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    }

}



@end
