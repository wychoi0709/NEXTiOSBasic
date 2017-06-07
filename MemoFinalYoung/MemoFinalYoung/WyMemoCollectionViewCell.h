//
//  WyMemoCollectionViewCell.h
//  MemoFinalYoung
//
//  Created by 최원영 on 2017. 6. 7..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WyMemoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
