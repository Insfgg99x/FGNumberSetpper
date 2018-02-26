//
//  ViewController.m
//  FGNumberStepper
//
//  Created by xgf on 2018/2/26.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "FGNumberStepper.h"

@interface ViewController ()

@property(nonatomic,strong)UILabel *moneyLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenw = [UIScreen mainScreen].bounds.size.width;
    UILabel *tipLb = [[UILabel alloc] initWithFrame:CGRectMake(screenw/2 - 50, 100, 100, 30)];
    tipLb.text = @"请选择购买数量:";
    tipLb.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:tipLb];
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(screenw/2 - 50, 140, 100, 100)];
    imv.image = [UIImage imageNamed:@"hotstrip"];
    [self.view addSubview:imv];
    
    UILabel *nameLb = [[UILabel alloc] initWithFrame:CGRectMake(screenw/2-50, 250, 100, 20)];
    nameLb.text = @"辣皮 3元";
    nameLb.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:nameLb];
    
    __weak typeof(self) wkself = self;
    FGNumberStepper *setpper = [[FGNumberStepper alloc] initWithNumber:1 minmualNumber:1 changeAction:^(FGNumberStepper *s, NSInteger number) {
        CGFloat price = 3.0;
        CGFloat total = price * number;
        wkself.moneyLb.text = [NSString stringWithFormat:@"共%.1f元",total];
    }];
    setpper.canInput = YES;
    setpper.frame = CGRectMake(screenw/2-50, 280, 100, 30);
    [self.view addSubview:setpper];
    
    _moneyLb = [[UILabel alloc] initWithFrame:CGRectMake(screenw/2-50, 330, 100, 20)];
    _moneyLb.textColor = [UIColor redColor];
    _moneyLb.text = @"共3.0元";
    [self.view addSubview:_moneyLb];
}

@end
