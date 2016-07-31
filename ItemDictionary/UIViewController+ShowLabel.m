//
//  UIViewController+ShowLabel.m
//  ItemDictionary
//
//  Created by Macx on 16/7/31.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "UIViewController+ShowLabel.h"

@implementation UIViewController (ShowLabel)
- (void)showLabel:(NSString *)name{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-88, SCREENHIGHT/2-44,88*2,88)];
    label.text = name;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = COLOR(242, 242, 242);
    label.textColor = [UIColor blackColor];
    label.layer.cornerRadius = 0.5;
    [self.view addSubview:label];
    // [view addSubview:label];;
    [UIView animateWithDuration:1.5 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];

}
@end
