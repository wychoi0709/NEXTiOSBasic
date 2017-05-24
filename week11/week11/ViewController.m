//
//  ViewController.m
//  week11
//
//  Created by 최원영 on 2017. 5. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"
#import "SQLiteManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *songTable;

@end

@implementation ViewController{
    SQLiteManager *sQLiteManager;
    NSArray *contentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _songTable.delegate = self;
    _songTable.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterGetSelectedData:) name:@"afterSelectTable" object:nil];

    //sQLiteManager를 init하면 데이터를 정리해서 노티를 쏴줌
    sQLiteManager = [[SQLiteManager alloc] init];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)afterGetSelectedData:(NSNotification*)noti{
    contentArray = [[noti userInfo] objectForKey:@"userInfo"];
    
    NSLog(@"contentArray: %@", contentArray);
    [_songTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *subtitleCell = [_songTable dequeueReusableCellWithIdentifier:@"contentCell"];
    
    subtitleCell.textLabel.text = [contentArray[indexPath.row] objectForKey:@"title"];
    subtitleCell.detailTextLabel.text = [contentArray[indexPath.row] objectForKey:@"category"];
    
    return subtitleCell;
}

@end
