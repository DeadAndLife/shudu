//
//  ViewController.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/6.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "SUUser.h"
#import "SUBeginViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *beginGameButton;

@property (weak, nonatomic) IBOutlet UIButton *recordNoteButton;

@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@property (weak, nonatomic) IBOutlet UIButton *aboutButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self userInit];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userInit {
    
    SUUser *defaultUser = [SUUser defaultUser];
    
    NSLog(@"%@", defaultUser);
}

- (IBAction)beginButtonClick:(UIButton *)sender {
    SUBeginViewController *beginVC = [[SUBeginViewController alloc] init];
    beginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:beginVC animated:YES completion:^{
        
    }];
}

- (IBAction)recordButtonClick:(UIButton *)sender {
    
}

- (IBAction)settingButtonClick:(UIButton *)sender {
    
}

- (IBAction)aboutButtonClick:(UIButton *)sender {
    
}


@end
