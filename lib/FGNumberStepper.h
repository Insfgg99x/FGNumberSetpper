//
//  FGNumberStepper.h
//  FriendCircle
//
//  Created by xgf on 16/12/1.
//  Copyright © 2016年 HuaZhongShiXun. All rights reserved.
//

#import <UIKit/UIKit.h>

//////////////================/////////////
//           ||              ||          //
//           ||              ||          //
//     -     ||     99       ||    +     //
//           ||              ||          //
//           ||              ||          //
/////////////================//////////////

@class FGNumberStepper;

typedef void (^FGNumberChangedBlock)(FGNumberStepper *s, NSInteger number);

/**
 number stepper
 */
@interface FGNumberStepper : UIView
/**
 current numberic value
 */
@property(nonatomic,assign)NSInteger number;
/**
 default is YES
 */
@property(nonatomic,assign)BOOL      canInput;
/**
 supported negative number by setting to YES, Default is NO
 */
@property(nonatomic,assign)BOOL     negativeSupported;
/**
 Font, default is 14
 */
@property(nonatomic,strong)UIFont   *font;
/**
 number did change callback
 */
@property(nonatomic,copy)void (^numberChangedBlock)(FGNumberStepper *s, NSInteger number);
/**
 default size is 100x25 can be update by .frame

 @param number   current number
 @param minimual min number
 @param change   value changed callback
 @return FGNumberStepper
 */
+(instancetype)stepperWithNumber:(NSInteger)number minmualNumber:(NSInteger)minimual changeAction:(FGNumberChangedBlock)change;
/**
 default size is 100x25 can be update by .frame
 
 @return FGNumberStepper
 */
-(instancetype)initWithNumber:(NSInteger)number minmualNumber:(NSInteger)minimual changeAction:(FGNumberChangedBlock)change;

@end
