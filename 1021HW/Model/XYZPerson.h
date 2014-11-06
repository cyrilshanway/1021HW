//
//  XYZPerson.h
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>NSString

@interface XYZPerson : NSObject

#pragma mark - 10/23
@property (nonatomic) PFObject *personObject;

@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *idNumber;


@end
