//
//  SUBeginViewController.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "SUBeginViewController.h"

@interface SUBeginViewController ()

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *simpleButton;

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *middleButton;

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *hardButton;

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *restartButton;

/**
 <#Description#>
 */
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation SUBeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidLayoutSubviews {
    [self backButtonLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view init
- (void)backButtonLayout{
    //为返回按钮增加圆角边框
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, self.backButton.bounds.size.width, self.backButton.bounds.size.height);
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, self.backButton.bounds.size.width, self.backButton.bounds.size.height);
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.backButton.bounds.size.width, self.backButton.bounds.size.height) cornerRadius:3.0f];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [self.backButton.layer insertSublayer:borderLayer atIndex:0];
    [self.backButton.layer setMask:maskLayer];
}

#pragma mark - buttonClick

- (IBAction)simpleButtonClick:(UIButton *)sender {
    //随机中间单元格数组，然后经过行列变换获得完整数独
    //挖空35-50
}

- (IBAction)middleButtonClick:(UIButton *)sender {
    //随机左上，中间，右下三个单元格数组，使用回溯法生成完整数独
    //挖空40-55
}

- (IBAction)hardButtonClick:(UIButton *)sender {
    //随机第一行数组，剩余使用回溯法生成完整数独
    //挖空45-60
}

- (IBAction)continueButtonClick:(UIButton *)sender {
    //读取记录的局面
}

- (IBAction)restartButtonClick:(UIButton *)sender {
    //读取记录的局面，并重置到初始状态
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
