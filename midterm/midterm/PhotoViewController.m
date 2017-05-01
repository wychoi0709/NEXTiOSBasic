//
//  PhotoViewController.m
//  midterm
//
//  Created by 최원영 on 2017. 5. 1..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Photo";
    
    _nameLabel.text = [_aCell objectForKey:@"title"];
    _dateLabel.text = [_aCell objectForKey:@"date"];
    UIImage *backgroundImage = [UIImage imageNamed:[_aCell objectForKey:@"image"]];
    _backgroundImage.image = backgroundImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
