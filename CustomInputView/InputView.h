//
//  InputView.h
//  CustomInputView
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputView;
@protocol InputViewDelegate <NSObject>

- (void)inputView:(InputView *)inputView sendBtnPress:(UIButton *)button inputString:(NSString *)inputString;

@end


@interface InputView : UIView

@property (nonatomic, assign) id<InputViewDelegate> delegate;

@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) UITextField * inputTextField;

//点击btn时候 清空textfield  默认NO
@property (nonatomic, assign) BOOL clearInputWhenSend;
//点击btn时候 隐藏键盘  默认NO
@property (nonatomic, assign) BOOL resignFirstResponderWhenSend;


//初始frame
@property (nonatomic, assign) CGRect originalFrame;

//隐藏键盘
-(BOOL)resignFirstResponder;

@end
