//
//  ArticlesView.h
//  HorisontalCardScroll
//
//  Created by KIM HEE JAE on 9/28/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticlesView : UIScrollView

- (void) setModelReference:(NSArray*) modelRef;
- (void) renderArticlesInBoardAtIndex:(int) boardIndex;

//- (void) stuffSubviewsWithAttributes:(NSArray*)data;
- (void) toggleViewWithTapPositionX:(float)positionX;

@end
