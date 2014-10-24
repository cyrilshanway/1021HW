//
//  QueryViewController.h
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"

@interface QueryViewController : UIViewController


@property (strong, nonatomic) NSMutableDictionary *customerDictionary;

@property Customer *currentCustomer ;


@end
