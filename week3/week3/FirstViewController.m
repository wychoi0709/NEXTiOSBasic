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

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        NSLog(@"앨범이 있으니, 있다고 설정하고 알람을 띄움");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        NSLog(@"앨범이 없음(오류)");
    }
}

/**
 *  앨범,카메라 피커에서 카메라 선택했을 때 
 */
- (void)doAfterCameraChoice{
    NSLog(@"doAfterCameraChoice");
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        NSLog(@"카메라가 있으니 카메라를 띄움");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        NSLog(@"카메라가 없음");
    }
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
