//
//  Customer.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "Customer.h"

@interface Customer ()

@end

@implementation Customer

#pragma mark - 10/23
- (NSNumber *)balance{
    return self.personObject[@"balance"];
}

-(void)setBalance:(NSNumber *)balance{
    self.personObject[@"balance"] = balance;
    [self.personObject saveInBackground];
}

-(void)deposit:(int)amount{
    
    int balance = [self.balance intValue];
    balance += amount ;
    
    self.balance = [NSNumber numberWithInt:balance];
}

-(void)withdraw:(int)amount{
    
    int balance = [self.balance intValue];
    balance -= amount;
    
    self.balance = [NSNumber numberWithInt:balance] ;
}

-(void)showBalance{
    
    NSLog(@"Balance: %i" ,[self.balance intValue]);
    
}

@end

