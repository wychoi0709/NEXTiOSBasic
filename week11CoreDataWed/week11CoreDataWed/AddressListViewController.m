//
//  AddressListViewController.m
//  week11CoreDataWed
//
//  Created by 최원영 on 2017. 5. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "AddressListViewController.h"
#import "DataManager.h"
#import "Student+CoreDataClass.h"

@interface AddressListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *addressListTableView;


@end

@implementation AddressListViewController{
    NSArray <Student *> * studentArray;
    DataManager *dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataManager = [DataManager getDataManager];
    studentArray = [dataManager selectAllStudentList];
    
    _addressListTableView.delegate = self;
    _addressListTableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterFetcheData:) name:@"afterChangeContent" object:nil];
    
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }

- (void)afterFetcheData:(NSNotification*)noti{
    studentArray = [[noti userInfo] objectForKey:@"userInfo"];
    [_addressListTableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *addressCell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    
    addressCell.textLabel.text = studentArray[indexPath.row].name;
    addressCell.detailTextLabel.text = studentArray[indexPath.row].id;
    
    return addressCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return studentArray.count;
}



@end
