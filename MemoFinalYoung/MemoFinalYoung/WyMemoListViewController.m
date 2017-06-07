//
//  WyMemoListViewController.m
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "WyMemoListViewController.h"
#import "WyMemoCollectionViewCell.h"
#import "WyDetailViewController.h"
#import "MemoManager.h"
#import "Memo.h"
#import <Realm.h>

@interface WyMemoListViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *memoCollectionView;
@property RLMArray<Memo*>* memoArray;

@end

@implementation WyMemoListViewController{
    MemoManager *memoManager;
    NSInteger rowNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCustomObserver];
    
    _memoCollectionView.delegate = self;
    _memoCollectionView.dataSource = self;
    
    memoManager = [MemoManager getMemoManagerObject];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }


//옵저버 추가요
- (void)addCustomObserver{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(afterGetMemoList:) name:@"sendMemoResult" object:nil];
}


//메모 리스트를 받고 메모를 갱신한다.
- (void)afterGetMemoList:(NSNotification*)noti{
    _memoArray = [[noti userInfo] objectForKey:@"memoResult"];
    
    [_memoCollectionView reloadData];
}


//indexPath에 맞는 Cell이 뭐니?
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WyMemoCollectionViewCell *aCell = [_memoCollectionView dequeueReusableCellWithReuseIdentifier:@"wyMemoCollectionViewCell" forIndexPath:indexPath];
    
    rowNum = indexPath.row;
    
    aCell.timeLabel.text = [_memoArray objectAtIndex:indexPath.row].time;
    aCell.contentLabel.text = [_memoArray objectAtIndex:indexPath.row].content;
    [aCell.deleteBtn addTarget:self action:@selector(deleteAMemo:) forControlEvents:UIControlEventTouchUpInside];
    
    return aCell;
}


//총 몇 개의 섹션이니?
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


//각 세션에 아이템 몇 개니?
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _memoArray.count;
}


//셀 크기 조정
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float cellWidth =  self.view.frame.size.width / 2.4;
    float cellHeight = 150.0f;
    
    cellWidth += 20;
    cellHeight += 20;
    
    return CGSizeMake(cellWidth, cellHeight);
}


//셀 선택
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WyDetailViewController *wyDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wyDetailViewController"];
    
    wyDetailViewController.aMemo = [_memoArray objectAtIndex:indexPath.row];
    [self presentViewController:wyDetailViewController animated:YES completion:nil];
}


//모두 삭제 선택
- (IBAction)deleteAllMemo:(UIButton *)sender {
    NSLog(@"모두 삭제 버튼 터치");
    [memoManager deleteAllMemo];
}


//하나의 메모 삭제
- (IBAction)deleteAMemo:(UIButton *)sender {
    NSLog(@"하나 삭제 버튼 터치");
    [memoManager deleteMemo:[_memoArray objectAtIndex:rowNum]];
}

@end
