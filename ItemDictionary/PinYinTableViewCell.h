//
//  PinYinTableViewCell.h
//  ItemDictionary
//
//  Created by 3014 on 16/7/22.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@interface PinYinTableViewCell : UITableViewCell<IFlySpeechSynthesizerDelegate>
{
    
    IFlySpeechSynthesizer * _iFlySpeechSynthesizer;
}

@property (weak, nonatomic) IBOutlet UILabel *pinYinLabel;
@property (weak, nonatomic) IBOutlet UILabel *yindiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *bushouLabel;
@property (weak, nonatomic) IBOutlet UILabel *yindiaoTweLabel;

@property (weak, nonatomic) IBOutlet UILabel *bihuaLabel;

@end
