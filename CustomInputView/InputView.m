//
//  InputView.m
//  CustomInputView
//
//  Created by Vols on 14-7-14.
//  Copyright (c) 2014年 vols. All rights reserved.
//

#import "InputView.h"
#import "AppDelegate.h"

@implementation InputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.frame = CGRectMake(0, CGRectGetMinY(frame), kSCREEN_WIDTH, 44);
        
        [self addSubview:self.sendButton];
        [self addSubview:self.inputTextField];
        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.frame = CGRectMake(kSCREEN_WIDTH - 40, 7, 28, 28);
        [_sendButton setBackgroundImage:[UIImage imageNamed:@"expression"] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendButton;
}

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.frame = CGRectMake(10, 10, kSCREEN_WIDTH - 60, 24);
        _inputTextField.backgroundColor = [UIColor whiteColor];
    }
    return _inputTextField;
}


- (void)sendAction:(UIButton *)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputView:sendBtnPress:inputString:)]) {
        [self.delegate inputView:self sendBtnPress:button inputString:_inputTextField.text];
    }
    
    if (self.clearInputWhenSend) {
        self.inputTextField.text = @"";
    }

    if (self.resignFirstResponderWhenSend) {
        [self resignFirstResponder];
    }
}





#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{

    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)] >= keyboardRect.origin.y) {
        
        //没有偏移 就说明键盘没出来，使用动画
        if (self.frame.origin.y == self.originalFrame.origin.y) {
            
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.transform = CGAffineTransformMakeTranslation(0, kSCREEN_HEIGHT - keyboardRect.size.height - CGRectGetMaxY(self.originalFrame));
                             } completion:nil];
        }
        else{
            self.transform = CGAffineTransformMakeTranslation(0, kSCREEN_HEIGHT - keyboardRect.size.height - CGRectGetMaxY(self.originalFrame));
        }
    }
    
}



- (void)keyboardWillHide:(NSNotification*)notification{
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:nil];

}


#pragma  mark - ConvertPoint
//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint point = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return point.y;
}


-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint point = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return point.y;
}


-(BOOL)resignFirstResponder
{
    [self.inputTextField resignFirstResponder];
    return [super resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
