//
//  AboutViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [self setUIView];
    
  
}
- (void)setUIView{
    UIImageView *imageviewBack = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageviewBack.image = [UIImage imageNamed:@"beijing"];
    [self.view addSubview:imageviewBack];
    UIBarButtonItem *magnifier = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"magnifier"] style:UIBarButtonItemStylePlain target:self action:@selector(magnifierAction)];
    self.navigationItem.rightBarButtonItem =magnifier;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = back;
    
    UIImageView *zImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80, self.view.frame.size.width-25, 55)];
    zImageView.image = [UIImage imageNamed:@"z"];
    [self.view addSubview:zImageView];
    
    UILabel *wirelessLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 200, 100)];
    wirelessLabel.text = @"指掌无线";
    wirelessLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:wirelessLabel];
  
    UILabel *dicLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-100, SCREENHIGHT/2-230, 100, 44)];
    dicLabel.font = [UIFont systemFontOfSize:22];
    dicLabel.text = @"汉语字典";
    [self.view addSubview:dicLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH/2-50,SCREENHIGHT/2-180, SCREENWIDTH/2-80, SCREENHIGHT/2-200)];
    imageView.image = [UIImage imageNamed:@"zidian"];
    [self.view addSubview:imageView];
    
    UILabel *introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 310, SCREENWIDTH-40, 300)];
    introductionLabel.numberOfLines = 0;
    introductionLabel.text = @"      汉语是世界上最精密的语言之一,语义丰富,耐人寻味,本词典篇幅简短,内容丰富,既求融科学性,知识性,实用性,规范性于一体,又注意突出时代特色.";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:introductionLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:18];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [introductionLabel.text length])];
    introductionLabel.attributedText = attributedString;
   // [introductionLabel sizeToFit];

    introductionLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:introductionLabel];
    
    UIImageView *kuangImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 535,  SCREENWIDTH-55, 150)];
    kuangImage.image = [UIImage imageNamed:@"kuang"];
    [self.view addSubview:kuangImage];
    kuangImage.userInteractionEnabled = YES;
    UILabel *netLabel = [UILabel new];
    netLabel.font = [UIFont systemFontOfSize:19];
    netLabel.text = @"官方网站:www.zhizhang.com";
    netLabel.frame = CGRectMake(20, 25, 300, 30);
  
    [kuangImage addSubview:netLabel];
    UILabel *weiBoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 300, 30)];
    weiBoLabel.font = [UIFont systemFontOfSize:19];
    weiBoLabel.text = @"官方微博:e.weibo.com";
   
    [kuangImage addSubview:weiBoLabel];
    UILabel *weixinLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 300, 30)];
    weixinLabel.text = @"微信公共账号:指掌无线";
    weixinLabel.font = [UIFont systemFontOfSize:19];
       [kuangImage addSubview:weixinLabel];
    
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)magnifierAction{
    
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
