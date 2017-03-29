//
//  FirstViewController.m
//  week3
//
//  Created by 최원영 on 2017. 3. 29..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property UIImagePickerController * picker;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  피커 버튼 터치했을 경우
 */
- (IBAction)pickerBtnTouched:(UIButton *)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"사진 선택"
                                                                   message:@"사진을 선택해주세요."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* albumAction = [UIAlertAction actionWithTitle:@"앨범" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [self doAfterAlbumChoice];
                                                        }];
    [alert addAction:albumAction];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertAction* cameraAction = [UIAlertAction actionWithTitle:@"카메라" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [self doAfterCameraChoice];
                                                             }];
        [alert addAction:cameraAction];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

/**
 * 앨범,카메라 피커에서 앨범 선택했을 때
 */
- (void)doAfterAlbumChoice{
    NSLog(@"doAfterAlbumChoice");
    
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _picker.allowsEditing = YES;
    
    [self presentViewController:_picker animated:YES completion:nil];

}

/**
 *  앨범,카메라 피커에서 카메라 선택했을 때
 */
- (void)doAfterCameraChoice{
    NSLog(@"doAfterCameraChoice");
    
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _picker.allowsEditing = YES;
    
    [self presentViewController:_picker animated:YES completion:nil];
}

/**
 *  이미지 선택이 완료된 이후 실행
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //이미지를 넣고, 피커를 날린다.
    self.imageView.image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
