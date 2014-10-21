//
//  Customer.h
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "XYZPerson.h"

@interface Customer : XYZPerson


-(void)deposit: (int) amount ;
-(void)withdraw: (int) amount ;
-(void)showBalance;



@property int balance ;
// int balance default is 0 , not nil , 因為他不是個 pointer , pointer一開始就會指到 nil

@end
