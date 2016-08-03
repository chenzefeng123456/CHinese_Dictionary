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
#import "DescribeViewController.h"
#import "UIViewController+ShowLabel.h"
@interface ViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>
{
    UIImageView *imageView;
    NSArray *array;
    UISegmentedControl *segment;
    UIView *spellLetterView;
    UIView *radicalView;
    int index;
    UILabel *lable;
    UIView *recentView;
    UITextField *textField1;
    NSString *recentText;
    UIButton *button;
    NSArray *arr;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationSetUI];
    [self setUIView];
    
    array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self isSpellCheck];
    
}
- (void)navigationSetUI{
    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    UIImage *image = [UIImage imageNamed:@"beijing"];
    imageView.image = image;
    [self.view addSubview:imageView];
    self.navigationController.navigationBar.barTintColor = COLOR(136, 40, 40);
       self.title = @"汉语字典";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = dic;

    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style: UIBarButtonItemStylePlain target:self action:@selector(enterMoreAction)];
    self.navigationItem.rightBarButtonItem = bar;
    self.navigationController.delegate = self;
}
#pragma mark UI界面
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
    
    textField1 = [[UITextField alloc] initWithFrame:CGRectMake(30, 140, 350, 45)];
    textField1.placeholder = @"请输入...";
    textField1.delegate = self;
    textField1.layer.borderWidth = 0.4;
    textField1.layer.cornerRadius = 20;
    textField1.leftView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
    textField1.leftViewMode = UITextFieldViewModeAlways;
    textField1.font = [UIFont systemFontOfSize:26];
    textField1.layer.backgroundColor = [UIColor whiteColor].CGColor;
    textField1.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:textField1];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [textField1 resignFirstResponder];
}

#pragma mark TextField搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    const char *text = [textField.text UTF8String];
    if (textField.text.length >= 2||strlen(text) == 1||textField.text.length < 1) {
        [self showLabel:@"请输入单个文字"];
    }else{
        DescribeViewController *des = [[DescribeViewController alloc] initWithNibName:@"DescribeViewController" bundle:[NSBundle mainBundle]];
         des.string = textField.text;
        [self addDefault:textField.text];
        textField.text = @"";
        //[self recentAction];

        [self.navigationController pushViewController:des animated:YES];
        

    }
       return YES;
}
- (void)viewWillAppear:(BOOL)animated{
   [self recentAction];
}
#pragma mark 最近搜索
- (void)addDefault:(NSString *)string{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *muTu = [NSMutableArray arrayWithArray:[user valueForKey:@"user132"]];
    if (!muTu) {
        [user setObject:[NSArray array] forKey:@"user132"];
    }
    [muTu insertObject:string atIndex:0];
    if (muTu.count == 6) {
        [muTu removeLastObject];
    }
    
    [user setObject:muTu forKey:@"user132"];
    [user synchronize];
    
}

- (void)recentAction{
    
    for (UIView *view in recentView.subviews) {
        [view removeFromSuperview];
    }
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSArray *arr2 = [user arrayForKey:@"user132"];
    float width = recentView.frame.size.height;
    float gap = (recentView.frame.size.width - button.frame.size.width* 5)/4;
    for (int i = 0; i < arr2.count; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i *(gap+width),0, width, width);
        [button setTitle:arr2[i] forState:UIControlStateNormal];
        [recentView addSubview:button];
      
        [button setTitleColor:COLOR(140, 57, 22) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(recentSpellAction:) forControlEvents: UIControlEventTouchUpInside];
       
    }
}

- (void)recentSpellAction:(UIButton *)sender{
    NSLog(@"我被点击了");
}

//拼音或部首
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
    PingYingViewController *pingYing = [PingYingViewController new];
    pingYing.index = sender.tag;
    [self.navigationController pushViewController:pingYing animated:YES];
    
}

//点击部首发生的事件
- (void)touchRadicalCheck:(UIButton *)sender{
    BushouViewController *bushou = [BushouViewController new];
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
