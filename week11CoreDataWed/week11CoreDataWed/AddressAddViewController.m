//
//  AddressAddViewController.m
//  week11CoreDataWed
//
//  Created by 최원영 on 2017. 5. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "AddressAddViewController.h"
#import "DataManager.h"

@interface AddressAddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (weak, nonatomic) IBOutlet UITextField *gradeTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddressAddViewController{
    DataManager *dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataManager = [DataManager getDataManager];
//    _addBtn.enabled = NO;
 
}

- (void)didReceiveMemoryWarning { [super didReceiveMemoryWarning]; }




- (IBAction)addBtnTouched:(UIButton *)sender {
    [dataManager insertNewStudentWithId:_idTextField.text withName:_nameTextField.text withGender:_genderSwitch.enabled withGrade:[_gradeTextField.text integerValue]];
}

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(![_nameTextField.text isEqualToString:@""] &&
//       ![_idTextField.text isEqualToString:@""] &&
//       ![_gradeTextField.text isEqualToString:@""]){
//        _addBtn.enabled = YES;
//    }
//}
//
//- text

@end
