# FGNumberStepper 简单易用的选择数量控件

![](resources/1.png)

## Usage 

```
	__weak typeof(self) wkself = self;
    FGNumberStepper *setpper = [[FGNumberStepper alloc] initWithNumber:1 minmualNumber:1 changeAction:^(FGNumberStepper *s, NSInteger number) {
        CGFloat price = 3.0;
        CGFloat total = price * number;
        wkself.moneyLb.text = [NSString stringWithFormat:@"共%.1f元",total];
    }];
    setpper.canInput = YES;
    setpper.frame = CGRectMake(screenw/2-50, 280, 100, 30);
    [self.view addSubview:setpper];
```

## Installtion

```
pod "FGNumberStepper"
```
