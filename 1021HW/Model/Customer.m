//
//  Customer.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "Customer.h"


@interface Customer ()


@property int balance ;
// int balance default is 0 , not nil , 因為他不是個 pointer , pointer一開始就會指到 nil

@end






@implementation Customer


-(void)deposit:(int)amount{
    self.balance += amount ;
    
    
}



-(void)withdraw:(int)amount{
    
    
    self.balance -= amount ;
}



-(void)showBalance{
    
    NSLog(@"Balance: %i" ,self.balance);
    
}



@end

