//
//  AppModel.h
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppModel : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableArray *data;
    NSMutableDictionary *imageDownloadBuffer;
}
-(id)init;
-(NSInteger) getCount;
-(NSDictionary*) dictionaryAtIndex:(NSInteger)integer;
-(void) sort;
- (void) deleteAtIndex:(NSInteger)integer;
@end
