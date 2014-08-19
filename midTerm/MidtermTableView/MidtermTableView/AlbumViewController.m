//
//  ViewController.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "AlbumViewController.h"
#import "PhotoViewController.h"
#import "ImageViewCell.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 모델의 데이터가 초기화 되었는지 지켜보도록 Observer로 등록
    [[NSNotificationCenter defaultCenter] addObserver:self // 알림을 내가 받을 것이다.
                                             selector:@selector(receiveNotification:) // 알림을 받으면 실행할 메소드
                                                 name:nil // 알림의 이름, 일단 어떤알림이든 다 받은 다음 내가원하는것인지 보고 처리
                                               object:nil]; // 어디에서 알림을 발행했는지 쳐다보고 싶은 대상. 누가발행했든 상관없이 알고 싶으면 nil

    [self initModel];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

}

- (void) initModel{
    appModel = [[AppModel alloc] init];

    // 노티를 날리는 건 어쩔 수 없이 옵저버에게 달았다. 모델의 init 메소드에서 노티를 보내니 이상하더라요.
    // 초기화 되었다는 신호를 노티피케이션 센터에 날린다.
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"modelInitializedNotification"
     object:nil
     userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveNotification:(NSNotification *) notification
{

    if ([[notification name] isEqualToString:@"modelInitializedNotification"]) {
        NSLog (@"modelInitialized Notification received!");
        // 여기서 테이블 뷰를 리로드 해야함
        [self.tableView reloadData];
    }

}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [appModel getCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *imageTableIdentifier = @"Cell";
    
    ImageViewCell *cell = (ImageViewCell *)[tableView dequeueReusableCellWithIdentifier:imageTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *element = [appModel dictionaryAtIndex:indexPath.row];
    cell.cellTitle.text = [element objectForKey:@"title"];
    cell.cellDate.text = [element objectForKey:@"date"];

    
    UIImage *image = [self getUIImageFrom:element];

    [cell.cellImage setImage:image];
    [cell.cellImage setContentMode : UIViewContentModeScaleAspectFill];
    cell.cellImage.clipsToBounds = YES;
    return cell;
}

- (UIImage*) getUIImageFrom:(NSDictionary*) dict
{
    UIImage *image = [UIImage imageWithContentsOfFile:[dict objectForKey:@"image"]];
    if (image == NULL) {
        image = [UIImage imageNamed: [dict objectForKey:@"image"]];
    }
    return image;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [appModel deleteAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDate *object = _objects[indexPath.row];
        self.detailViewController.detailItem = object;
    }
}
*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PhotoViewController *photoController = segue.destinationViewController;
    NSDictionary *photo = [appModel dictionaryAtIndex:self.tableView.indexPathForSelectedRow.row];
    photoController.title = [photo objectForKey:@"title"];
    photoController.image = [photo objectForKey:@"image"];
    photoController.date = [photo objectForKey:@"date"];
}

- (IBAction)sort:(id)sender {
    // model을 sort하고 테이블 리로드하기
    [appModel sort];
    //[self.tableView reloadData];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 쉐이크 제스춰 인식기에 렌더마이즈 메소드 실행을 연결한다.
    if (motion == UIEventSubtypeMotionShake)
    {
        // 모델 인스턴스 새로 만들고 데이터 초기화
        [self initModel];
//        appModel = [[AppModel alloc] initWithUTF8String:initalData];
    }
}

@end
