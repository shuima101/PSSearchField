//
//  PSNavigationSearchField.m
//  PSSearchFieldDemo
//
//  Created by 冯广勇 on 2017/9/16.
//  Copyright © 2017年 shuima. All rights reserved.
//

#import "PSNavigationSearchField.h"
#import "UIView+PSFrame.h"


@interface PSNavigationSearchField ()<UITextFieldDelegate>
{
    CGFloat _screenWidth;
    UILabel *_titleLb;
    UIButton *_cancelBtn;
    CGFloat _superViewX;
}


@end

@implementation PSNavigationSearchField

+(instancetype)navigationSearchField
{
    return [[self alloc] initWithFrame:CGRectMake(0., 0., screenWidth, 27.)];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _screenWidth = screenWidth;
        _tintColor = [UIColor whiteColor];
        // 布局
        [self setupSubviews];
    }
    return self;
}

-(void)setupSubviews
{
    self.backgroundColor = [UIColor clearColor];
    // 搜索框
    _searchTextField = [[UITextField alloc] init];
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.backgroundColor = [_tintColor colorWithAlphaComponent:0.3];
    _searchTextField.borderStyle = UITextBorderStyleNone;
    _searchTextField.layer.cornerRadius = 5.;
    _searchTextField.layer.cornerRadius = self.height/2.;
    _searchTextField.textAlignment = NSTextAlignmentLeft;//字体居中
    _searchTextField.font = [UIFont systemFontOfSize:14];
    _searchTextField.textColor = [_tintColor colorWithAlphaComponent:0.6];
    _searchTextField.keyboardType = UIKeyboardTypeNumberPad;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    [_searchTextField addTarget:self action:@selector(textFieldEditingBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [_searchTextField addTarget:self action:@selector(textFieldEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    if (_attributedPlaceholder) {
        _searchTextField.attributedPlaceholder = _attributedPlaceholder;
    }else if (_placeholder) {
        _searchTextField.placeholder = _placeholder;
    }
    if (_textFieldDelegate) {
        _searchTextField.delegate = _textFieldDelegate;
    }
    [self addSubview:_searchTextField];
    
    UIImageView *tfLeftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., self.height, self.height)];
    tfLeftImgView.contentMode = UIViewContentModeCenter;
    tfLeftImgView.image = [UIImage imageNamed:@"card_dealBill_search"];
    tfLeftImgView.backgroundColor = [UIColor clearColor];
    _searchTextField.leftView = tfLeftImgView;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // titleLabel
    _titleLb = [UILabel new];
    _titleLb.backgroundColor = [UIColor clearColor];
    _titleLb.font = [UIFont systemFontOfSize:16. weight:0.1];
    _titleLb.textColor = _tintColor;
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLb];
    
    // 取消按钮
    _cancelBtn = [UIButton buttonWithType:0];
    _cancelBtn.alpha = 0;
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:_tintColor forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.5];
    [_cancelBtn addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
}

// 确定frame之后调整输入框和titleLb
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_searchTextField.width == 0.) {// 只执行一次
        double systemVersion = UIDevice.currentDevice.systemVersion.doubleValue;
        _superViewX = systemVersion >= 11.0 ? self.superview.x : self.x;
        
        CGFloat tfWidth = self.height;
        _searchTextField.frame = CGRectMake(self.width-tfWidth-7.5, 0., tfWidth, tfWidth);
        _titleLb.frame = CGRectMake(0., 0., _screenWidth-2*_superViewX, self.height);
        _cancelBtn.frame = CGRectMake(self.width-50., 0., 50., self.height);
    }
}

-(void)searchFieldAnimation
{
    CGFloat width = 0.;
    CGFloat x = 0.;
    BOOL titleHidden = NO;
    if (_searchTextField.width == self.height) {
        if (_attributedPlaceholder) {
            _searchTextField.attributedPlaceholder = _attributedPlaceholder;
        }else if (_placeholder) {
            _searchTextField.placeholder = _placeholder;
        }
        width = _screenWidth-2.*_superViewX;
        x = 0.;
        titleHidden = YES;
    }else {
        _searchTextField.attributedPlaceholder = nil;
        _searchTextField.placeholder = nil;
        width = self.height;
        x = self.width-width-7.5;
        titleHidden = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _searchTextField.frame = CGRectMake(x, 0., width, self.height);
        if (titleHidden) {
            _titleLb.alpha = 0.;
        }else {
            _cancelBtn.alpha = 0.;
        }
    } completion:^(BOOL finished) {
        if (titleHidden) {
            _cancelBtn.alpha = 1.;
        }
        [UIView animateWithDuration:0.1 animations:^{
            if (!titleHidden) {
                _titleLb.alpha = 1.;
            }
        }];
    }];
}

-(void)cancelButtonAction:(UIButton *)btn
{
    _searchTextField.text = @"";
    [_searchTextField resignFirstResponder];
    [self searchFieldAnimation];
}

-(BOOL)resignFirstResponder
{
    return [self endEditing:[super resignFirstResponder]];
}

#pragma mark - 输入框
-(void)textFieldEditingBegin:(UITextField *)textField
{
    if (textField.width == self.height) {
        [self searchFieldAnimation];
    }
    if (_textFieldDelegate && [_textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_textFieldDelegate textFieldDidBeginEditing:textField];
    }
}
-(void)textFieldEditingEnd:(UITextField *)textField
{
    if (_textFieldDelegate && [_textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_textFieldDelegate textFieldDidEndEditing:textField];
    }
}

#pragma SET & GET

-(void)setText:(NSString *)text
{
    _searchTextField.text = text;
}

-(NSString *)text
{
    return _searchTextField.text;
}

-(void)setNaviTitle:(NSString *)naviTitle
{
    _naviTitle = naviTitle;
    _titleLb.text = naviTitle;
}

@end
