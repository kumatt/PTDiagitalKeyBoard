//
//  ViewController.m
//  PTDigitalKeyBoardDemo
//
//  Created by Mac on 2018/8/18.
//  Copyright © 2018年 Shenzhen LvPai Culture Communication Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "PublicDigitalKeyBoardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield_diagital;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect screenBound = UIScreen.mainScreen.bounds;
    screenBound.size.height = 200;
    
    PublicDigitalKeyBoardView *digitalKeyBoardView = [[PublicDigitalKeyBoardView alloc]initWithFrame:screenBound];
    digitalKeyBoardView.backgroundColor = [UIColor colorWithRed:255/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    self.textfield_diagital.inputView = digitalKeyBoardView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
