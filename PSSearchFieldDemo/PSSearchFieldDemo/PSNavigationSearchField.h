//
//  PSNavigationSearchField.h
//  PSSearchFieldDemo
//
//  Created by 冯广勇 on 2017/9/16.
//  Copyright © 2017年 shuima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSNavigationSearchField : UIView

@property(nonatomic, weak) id<UITextFieldDelegate>textFieldDelegate;
@property(nonatomic, strong) NSAttributedString *attributedPlaceholder;
@property(nonatomic, strong) NSString *placeholder;

@property(nonatomic, strong) NSString *text;

/** 需要不同样式可以直接调整 */
@property(nonatomic, strong) UITextField *searchTextField;

// 导航栏title
@property(nonatomic, copy) NSString *naviTitle;

@property(nonatomic, strong) UIColor *tintColor;

+(instancetype)navigationSearchField;

@end
