//
//  ViewController.m
//  MidtermTableView
//
//  Created by KIM HEE JAE on 8/12/14.
//  Copyright (c) 2014 ___NHNNEXT___. All rights reserved.
//

#import "AlbumViewController.h"
#import "PhotoViewController.h"

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

    
    //  모델초기화할 데이터를 JSON string으로 마련
    initalData = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20140116\"},\ {\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20140505\"},\ {\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20131212\"},\ {\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20130301\"},\ {\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20140101\"},\ {\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20130707\"},\ {\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20130815\"},\ {\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20131231\"},\ {\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20140102\"}]";

    // 모델 인스턴스 만들고 데이터 초기화
    appModel = [[AppModel alloc] initWithUTF8String:initalData];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

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
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *element = [appModel dictionaryAtIndex:indexPath.row];
    cell.textLabel.text = [element objectForKey:@"title"];
    cell.detailTextLabel.text = [element objectForKey:@"date"];

    return cell;
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
    [self.tableView reloadData];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // 쉐이크 제스춰 인식기에 렌더마이즈 메소드 실행을 연결한다.
    if (motion == UIEventSubtypeMotionShake)
    {
        // 모델 인스턴스 새로 만들고 데이터 초기화
        appModel = [[AppModel alloc] initWithUTF8String:initalData];
        [self.tableView reloadData];
    }
}

@end
