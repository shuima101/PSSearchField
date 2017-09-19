//
//  UIView+PSFrame.h
//  PSFrameDemo
//
//  Created by 冯广勇 on 2017/9/17.
//  Copyright © 2017年 shuima. All rights reserved.
//

#import <UIKit/UIKit.h>


#define screenWidth UIScreen.mainScreen.bounds.size.width
#define screenHeight UIScreen.mainScreen.bounds.size.height

/* 设计尺寸适配 */
#define kDesignScreenWidth 750
#define kWidthScale (screenWidth/kDesignScreenWidth)

#define PS_INLINE inline

@interface UIView (PSFrame)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/** 将宽高按照"屏幕尺寸"与"设计尺寸"的宽度比缩放 */
CGSize CGSizePSMake(CGFloat width, CGFloat height);
/** 将宽高按照"屏幕尺寸"与"设计尺寸"的宽度比缩放 */
CGRect CGRectPSMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

@end
