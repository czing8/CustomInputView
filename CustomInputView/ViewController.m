//
//  ViewController.m
//  CustomInputView
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "ViewController.h"
#import "InputView.h"

@interface ViewController () <InputViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    InputView *inputView = [[InputView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - 44, 320, 44)];
    
    inputView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    
    inputView.delegate = self;
    inputView.clearInputWhenSend = YES;
    inputView.resignFirstResponderWhenSend = YES;
    
    [self.view addSubview:inputView];

}


- (void) inputView:(InputView *)inputView sendBtnPress:(UIButton *)button inputString:(NSString *)inputString
{
    NSLog(@"%@", inputString);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
