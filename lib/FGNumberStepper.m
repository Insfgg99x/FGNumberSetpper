//
//  FGNumberStepper.m
//  FriendCircle
//
//  Created by xgf on 16/12/1.
//  Copyright © 2016年 HuaZhongShiXun. All rights reserved.
//

#import "FGNumberStepper.h"

@interface FGNumberStepper()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *numField;

@end

@implementation FGNumberStepper {
    NSInteger _number;
    NSInteger _minmual;
}
+ (instancetype)stepperWithNumber:(NSInteger)number minmualNumber:(NSInteger)minimual changeAction:(FGNumberChangedBlock)change {
    return [[[self class] alloc] initWithNumber:number minmualNumber:minimual changeAction:change];
}
- (instancetype)initWithNumber:(NSInteger)number minmualNumber:(NSInteger)minimual changeAction:(FGNumberChangedBlock)change {
    if(self=[super initWithFrame:CGRectMake(0, 0, 100, 25)]) {
        _canInput = YES;
        _number=number;
        _numberChangedBlock=[change copy];
        _negativeSupported=NO;
        _minmual=minimual;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:_numField];
    }
    return self;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if(CGRectEqualToRect(frame, CGRectZero)) {
        return;
    }
    [self createUI];
}
- (void)createUI {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _numField=[[UITextField alloc] initWithFrame:self.bounds];
    _numField.text=@(_minmual).stringValue;
    _numField.textAlignment=NSTextAlignmentCenter;
    _numField.font=[UIFont systemFontOfSize:14];
    _numField.adjustsFontSizeToFitWidth=YES;
    _numField.keyboardType=UIKeyboardTypeNumberPad;
    [self addSubview:_numField];
    
    self.layer.borderWidth=0.5;
    self.layer.borderColor=[[UIColor colorWithWhite:0.8 alpha:1.0] CGColor];
    
    UIButton *leftBtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    [leftBtn setTitle:@"-" forState:UIControlStateNormal];
    leftBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [leftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    leftBtn.backgroundColor=[UIColor colorWithWhite:0.92 alpha:1.0];
    [leftBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn=[[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height)];
    [rightBtn setTitle:@"+" forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont boldSystemFontOfSize:18];
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor=[UIColor colorWithWhite:0.90 alpha:1.0];
    [rightBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _numField.leftView=leftBtn;
    _numField.rightView=rightBtn;
    _numField.leftViewMode=UITextFieldViewModeAlways;
    _numField.rightViewMode=UITextFieldViewModeAlways;
    _numField.font=[UIFont systemFontOfSize:14];
    _numField.delegate=self;
    UIBarButtonItem *doenItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(endInputAction)];
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *tool=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    tool.items=@[spaceItem,doenItem];
    _numField.inputAccessoryView=tool;
}
- (void)setFont:(UIFont *)font {
    _font = font;
    _numField.font = font;
}
- (void)endInputAction {
    [_numField resignFirstResponder];
}
- (void)changeAction:(UIButton *)sender {
    if([sender.currentTitle isEqualToString:@"-"]) {
        if(_number==_minmual){
            if(_negativeSupported) {
                _number--;
            } else {
                _number=_minmual;
                return;
            }
        } else {
            _number--;
        }
    } else {
        _number++;
    }
    _numField.text=@(_number).stringValue;
    if(self.numberChangedBlock) {
        self.numberChangedBlock(self, _number);
    }
}
- (void)textDidChange:(NSNotification *)sender {
    if(sender.object!=_numField){
        return;
    }
    _number=[_numField.text integerValue];
    if(_number<_minmual) {
        _number=_minmual;
    }
    if(self.numberChangedBlock){
        self.numberChangedBlock(self, _number);
    }
}
- (NSInteger)number {
    return _numField.text.integerValue;
}
- (void)setNumber:(NSInteger)number {
    _number=number;
    _numField.text=@(number).stringValue;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@""]) {
        return YES;
    }
    if(range.location==0) {
        return [@"123456789 " containsString:string];
    }
    return [@"0123456789 " containsString:string];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if(self.numberChangedBlock){
        self.numberChangedBlock(self, _number);
    }
    return _canInput;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _number=[_numField.text integerValue];
    if(_number<_minmual) {
        _number=_minmual;
    }
    if(self.numberChangedBlock){
        self.numberChangedBlock(self, _number);
    }
    return YES;
}

@end
