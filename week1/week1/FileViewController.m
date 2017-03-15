//
//  FileViewController.m
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "FileViewController.h"
#import "NXFileMatcher.h"

@interface FileViewController ()

@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UITextField *pathTextField;
@property (weak, nonatomic) IBOutlet UITextField *extensionTextField;
@property NXFileMatcher *aFileMatcher;

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _aFileMatcher = [[NXFileMatcher alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  버튼 터치 메소드
 */

/* 뒤로가기 버튼 터치 */
- (IBAction)backBtnTouched:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/* 뒤지기 버튼 터치 */
- (IBAction)searchingBtnTouched:(UIButton *)sender {
    [_aFileMatcher displayAllFilesAtPath:_pathTextField.text];
}

/* 특정 확장자를 가진 파일 검색 터치 */
- (IBAction)searchingByExtensionBtnTouched:(UIButton *)sender {
    [_aFileMatcher displayAllFilesAtPath:_pathTextField.text filterByExtension:_extensionTextField.text];
}

@end
