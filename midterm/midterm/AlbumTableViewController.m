//
//  AlbumTableViewController.m
//  midterm
//
//  Created by 최원영 on 2017. 5. 1..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "ImageManager.h"
#import "AlbumTableViewCell.h"
#import "PhotoViewController.h"

@interface AlbumTableViewController ()

@property ImageManager *imageManager;
@property NSArray *imageArray;
@property (strong, nonatomic) IBOutlet UITableView *imageTableView;

@end

@implementation AlbumTableViewController{
    NSNotificationCenter *defaultNotiCenter;
    Boolean isSorted;
    NSMutableArray *sectionHeaderTextArray;
}
- (IBAction)reorderButtonTouched:(UIBarButtonItem *)sender {
    [_imageManager reorderByDate];
    
}

- (void)viewDidLoad {
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [super viewDidLoad];
    defaultNotiCenter = [NSNotificationCenter defaultCenter];
    sectionHeaderTextArray = [[NSMutableArray alloc] init];
    
    [self applyNotification];
    _imageManager = [[ImageManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  노티 등록하는 메소드
 */
- (void) applyNotification{
    NSLog(@"노티 등록 메소드 진입");
    [defaultNotiCenter addObserver:self selector:@selector(afterInitImageManager:) name:@"imageManagerObserver" object:nil];
    [defaultNotiCenter addObserver:self selector:@selector(afterSortedImageManager:) name:@"sortedImageManagerObserver" object:nil];
    
}


/**
 *  이미지 초기화 후 콜백 노티 메소드
 */
- (void) afterInitImageManager:(NSNotification*) noti{
    NSLog(@"이미지 초기화 이후 콜백 메소드 진입");
    
    isSorted = NO;
    
    _imageArray = [[noti userInfo] objectForKey:@"imageArray"];
    [_imageTableView reloadData];
    
    NSLog(@"imageArray in VC: %@", _imageArray);
}

- (void) afterSortedImageManager:(NSNotification*) noti{
    NSLog(@"이미지 sorting 이후 콜백 메소드 진입");
    
    isSorted = NO;
    
    _imageArray = [[noti userInfo] objectForKey:@"sortedImageArray"];
    [_imageTableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (isSorted) {
        NSInteger headerCount = 0;
        NSString *yearForCompare = [[_imageArray[0] objectForKey:@"date"] substringToIndex:3];
        [sectionHeaderTextArray addObject:yearForCompare];
        
        for( int i = 0; i < _imageArray.count; i++ ){
            NSString *year = [[_imageArray[i] objectForKey:@"date"] substringToIndex:3];
            if( ![year isEqualToString:yearForCompare] ) {
                headerCount++;
                [sectionHeaderTextArray addObject:year];
            }
        }
        return headerCount;
        
    } else {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if( isSorted ) {
        
    }
    return _imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"albumTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *aCell = _imageArray[indexPath.row];
    NSLog(@"aCell: %@", aCell);
    
    cell.nameLabel.text = [aCell objectForKey:@"title"];
    cell.dateLabel.text = [aCell objectForKey:@"date"];
    UIImage *backgroundImage = [UIImage imageNamed:[aCell objectForKey:@"image"]];
    cell.backgroundImage.image = backgroundImage;
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (isSorted) {
        return sectionHeaderTextArray[section];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *aCell = _imageArray[indexPath.row];
    
    PhotoViewController *photoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"photoViewController"];
    photoViewController.aCell = aCell;

    [self.navigationController pushViewController:photoViewController animated:YES];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( motion == UIEventSubtypeMotionShake ) {
        NSLog(@"흔들");
        [_imageManager init];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
@end
