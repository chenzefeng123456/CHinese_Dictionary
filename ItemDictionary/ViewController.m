//
//  ViewController.m
//  ItemDictionary
//
//  Created by 3014 on 16/7/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "ViewController.h"
#import "MorePageViewController.h"
#import "PingYingViewController.h"
#import "BushouViewController.h"

@interface ViewController ()<UINavigationControllerDelegate>
{
    UIImageView *imageView;
    NSArray *array;
    UISegmentedControl *segment;
    UIView *spellLetterView;
    UIView *radicalView;
    int index;
    UILabel *lable;
    UIView *recentView;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationSetUI];
    [self setUIView];
    [self letterAction];
    array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self isSpellCheck];
    [self recentAction];
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSLog(@"%@",str);
  
}


- (void)navigationSetUI{
    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    UIImage *image = [UIImage imageNamed:@"beijing"];
    imageView.image = image;
    [self.view addSubview:imageView];
//    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, 20)];
//    statusView.backgroundColor = [UIColor blackColor];
//    [self.navigationController.navigationBar addSubview:statusView];
    
//    UIView *naView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-65, 44)];
//    naView.layer.contents = (id)[UIImage imageNamed:@"calligrapher"].CGImage;
//    [self.navigationController.navigationBar addSubview:naView];
//
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-63, 0,1, 44)];
//    imageV.image = [UIImage imageNamed:@"top"];
//    [self.navigationController.navigationBar addSubview:imageV];
//    UIImageView *imageR = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-65, 0,self.view.frame.size.width-63, 44)];
//    imageR.image = [UIImage imageNamed:@"enter"];
//    [self.navigationController.navigationBar addSubview:imageR];

    self.navigationController.navigationBar.barTintColor = COLOR(136, 40, 40);
       self.title = @"汉语字典";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;

    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style: UIBarButtonItemStylePlain target:self action:@selector(enterMoreAction)];
    self.navigationItem.rightBarButtonItem = bar;
    self.navigationController.delegate = self;
    
   
                                   

}
- (void)setUIView{
    segment = [[UISegmentedControl alloc] initWithItems:@[@"拼音检字",@"部首检字"]];
    segment.frame = CGRectMake(30, 80, 350, 44);
  
    segment.selectedSegmentIndex = 0;
    [segment setBackgroundImage:[UIImage imageNamed:@"fanyi"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageNamed:@"informatian2"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:25],NSForegroundColorAttributeName:[UIColor blackColor]};
    [segment setTitleTextAttributes:dic forState: UIControlStateSelected];
    [segment addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventValueChanged];
    segment.tintColor = [UIColor blackColor];
    [self.view addSubview:segment];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 140, 350, 45)];
    textField.placeholder = @"请输入...";
    textField.layer.borderWidth = 0.4;
    textField.layer.cornerRadius = 20;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:26];
    textField.layer.backgroundColor = [UIColor whiteColor].CGColor;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textField];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(34, 220, 150, 30)];
    lable.text = @"最近搜索:";
    lable.textColor =COLOR(90, 8, 0);
      lable.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:lable];
    
    UIImage *imageLine = [UIImage imageNamed:@"dividing-line"];
    UIImageView *imageViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(36, 260, 350, 1)];
    imageViewLine.image = imageLine;
    [self.view addSubview:imageViewLine];
    
    recentView = [[UIView alloc] initWithFrame:CGRectMake(28, 275, 360, 50)];
    recentView.backgroundColor = COLOR(212, 212, 212);
    [self.view addSubview:recentView];
    
    UILabel *searchSpellLetter = [[UILabel alloc] initWithFrame:CGRectMake(34, 345, 300, 30)];
    searchSpellLetter.textColor = COLOR(90, 8, 0);
    searchSpellLetter.text = @"按照拼音字母检索:";
    searchSpellLetter.font = [UIFont systemFontOfSize:25];
    [self.view addSubview:searchSpellLetter];
    
    
    UIImageView *imageViewLineSpellLetter = [[UIImageView alloc] initWithFrame:CGRectMake(28, 385, 350, 1)];
    imageViewLineSpellLetter.image = [UIImage imageNamed:@"dividing-line"];
    [self.view addSubview:imageViewLineSpellLetter];
    
    spellLetterView = [[UIView alloc] initWithFrame:CGRectMake(30,400, 340, 310)];
    spellLetterView.layer.cornerRadius = 8;
    spellLetterView.layer.shadowColor = [UIColor blackColor].CGColor;
    spellLetterView.backgroundColor = COLOR(212, 212, 212);
    [self.view addSubview:spellLetterView];
    
    radicalView = [[UIView alloc] initWithFrame:CGRectMake(30,400, 340, 310)];
    radicalView.layer.cornerRadius = 8;
    radicalView.layer.shadowColor = [UIColor blackColor].CGColor;
    radicalView.backgroundColor = COLOR(212, 212, 212);
    [self.view addSubview:radicalView];
    radicalView.hidden = YES;
    
    
    
    
    
}
- (void)recentAction{
    for (int i = 0; i < 8; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*40+20,8, 30, 30);
        button.backgroundColor = [UIColor cyanColor];
        [recentView addSubview:button];
        [button addTarget:self action:@selector(recentSpellAction:) forControlEvents: UIControlEventTouchUpInside];
    }
}

- (void)recentSpellAction:(UIButton *)sender{
    
}
//字母检索
- (void)letterAction{
   
}


//拼音检字或部首
- (void)isSpellCheck{
    index = 0;
    int k = 1000;
        for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 5; j++) {
                  k++;
                  UIButton *spellButton = [UIButton buttonWithType:UIButtonTypeCustom];
                  spellButton.tag = k;
                  NSLog(@"%ld",spellButton.tag);
                  spellButton.frame = CGRectMake(j * 65 + 20,i * 55+10 , 50, 30);
                  [spellButton setTitle:[NSString stringWithFormat:@"%@",array[index]] forState:UIControlStateNormal];
                  [spellButton addTarget:self action:@selector(touchLetterCheck:) forControlEvents:UIControlEventTouchUpInside];

                  [spellButton setTitleColor:COLOR(140, 57, 22) forState:UIControlStateNormal];
                  spellButton.titleLabel.font = [UIFont systemFontOfSize:24];
                 
                  [spellLetterView addSubview:spellButton];
                                   if (index <= 16) {
                      UIButton *radicalButton= [UIButton buttonWithType:UIButtonTypeCustom];
                      radicalButton.tag = k;
                      radicalButton.frame = CGRectMake(j * 65 + 20,i * 55+10 , 50, 30);
                      [radicalButton addTarget:self action:@selector(touchRadicalCheck:) forControlEvents:UIControlEventTouchUpInside];
                      
                      [radicalButton setTitle:[NSString stringWithFormat:@"%d",index+1] forState:UIControlStateNormal];
                      [radicalButton setTitleColor:COLOR(140, 57, 22) forState:UIControlStateNormal];
                      radicalButton.titleLabel.font = [UIFont systemFontOfSize:24];
                      
                      [radicalView addSubview:radicalButton];
                  }
                 
                   index++;

            
            
        }
    }
    UIButton *zButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zButton setTitle:@"Z" forState:UIControlStateNormal];
    zButton.tag = 1026;
    zButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [zButton addTarget:self action:@selector(touchLetterCheck:) forControlEvents:UIControlEventTouchUpInside];
    zButton.frame = CGRectMake(20, 275, 50, 30);
    [zButton setTitleColor:COLOR(140, 57, 22) forState:UIControlStateNormal];
    [spellLetterView addSubview:zButton];

    
}
- (void)selectAction:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        spellLetterView.hidden = NO;
        radicalView.hidden = YES;
    }else if (sender.selectedSegmentIndex == 1){
        spellLetterView.hidden = YES;
        radicalView.hidden = NO;
    }
    
}
//点击字母发生的事件
- (void)touchLetterCheck:(UIButton *)sender{
//    NSLog(@"%@",sender.titleLabel.text);
    
    PingYingViewController *pingYing = [PingYingViewController new];
    pingYing.index = sender.tag;
    [self.navigationController pushViewController:pingYing animated:YES];
    
}

//点击部首发生的事件
- (void)touchRadicalCheck:(UIButton *)sender{
    BushouViewController *bushou = [BushouViewController new];
//    NSLog(@"tag = %ld",sender.tag);
//    NSLog(@"text = %@",sender.titleLabel.text);
    bushou.index = sender.tag;
    [self.navigationController pushViewController:bushou animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self) {
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }else{
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
}
- (void)enterMoreAction{
    MorePageViewController *more = [MorePageViewController new];
    [self.navigationController pushViewController:more animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
