//
//  OpinionViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()<UITextViewDelegate>
{
    UIImageView *imageviewBack;
    UITextView *textView1 ;
    UILabel *sexLabel;
    UILabel *girlLabel ;
    UIImageView *yijianImageView;
    NSArray *array;
}
@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setUIView];
    array = @[@"男",@"女"];
}
- (void)setUIView{
    imageviewBack = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageviewBack.image = [UIImage imageNamed:@"beijing"];
    [self.view addSubview:imageviewBack];
    UIBarButtonItem *magnifier = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier"] style:UIBarButtonItemStylePlain target:self action:@selector(magnifierAction)];
    self.navigationItem.rightBarButtonItem =magnifier;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = back;
    textView1 = [[UITextView alloc] initWithFrame:CGRectMake(20, 88, SCREENWIDTH - 40, SCREENHIGHT-180)];
    textView1.text = @"请输入您的反馈意见...";
    textView1.textColor = [UIColor redColor];
    textView1.delegate = self;
    textView1.font = [UIFont systemFontOfSize:18];
    textView1.layer.contents = (id)[UIImage imageNamed:@"fankuikuang"].CGImage;
    [self.view addSubview:textView1];
    
    yijianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 655, 100, 35)];
    yijianImageView.userInteractionEnabled = YES;
    yijianImageView.image = [UIImage imageNamed:@"fankuianjian"];
    [self.view addSubview:yijianImageView];
    
    UIButton *selectButtton = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectButtton setImage:[UIImage imageNamed:@"downward"] forState:UIControlStateNormal];
    selectButtton.frame = CGRectMake(55, 1, 28, 40);
    [selectButtton addTarget:self action:@selector(selectButton1) forControlEvents:UIControlEventTouchUpInside];
    [yijianImageView addSubview:selectButtton];
    
    
    sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 20, 30)];
    sexLabel.text = @"男";
    //sexLabel.layer.contents = (id)[UIImage imageNamed:@"fankuianjian"];
    sexLabel.font = [UIFont systemFontOfSize:20];
    [yijianImageView addSubview:sexLabel];
    
    
    
    
}

- (void)selectButton1{
  
  
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = @"";
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textView1 resignFirstResponder];
}
- (void)magnifierAction{
    
}


- (void)backAction{
     [self.navigationController popViewControllerAnimated:YES];
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
