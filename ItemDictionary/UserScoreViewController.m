//
//  UserScoreViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "UserScoreViewController.h"

@interface UserScoreViewController ()

@end

@implementation UserScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"应用打分";
    [self setUIView];
}
- (void)setUIView{
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageviewBack.image = [UIImage imageNamed:@"beijing"];
    [self.view addSubview:imageviewBack];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
