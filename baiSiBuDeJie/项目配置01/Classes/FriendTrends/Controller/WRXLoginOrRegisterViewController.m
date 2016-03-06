//
//  WRXLoginOrRegisterViewController.m
//  项目配置01
//
//  Created by wang on 16/1/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "WRXLoginOrRegisterViewController.h"
#import <objc/runtime.h>

@interface WRXLoginOrRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginOrRegisterLeftMargin;
@end

@implementation WRXLoginOrRegisterViewController

- (IBAction)loginOrRegister:(UIButton *)sender {
    
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginOrRegisterLeftMargin.constant == 0) {
        sender.selected = YES;
        self.loginOrRegisterLeftMargin.constant = -self.view.width;
    }else{
        sender.selected = NO;
        self.loginOrRegisterLeftMargin.constant = 0;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //运行时
    /*
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self.phoneField class], &count);//只能获取当前类的成员变量，不能获取从父类继承过来的
    for (int i = 0; i < count; i++) {
        Ivar ivar = *(list + i);
        
        WRXLog(@"%s",ivar_getName(ivar));
        
    }
     */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
