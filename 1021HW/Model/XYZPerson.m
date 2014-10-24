//
//  XYZPerson.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "XYZPerson.h"

@interface XYZPerson  ()

@end


@implementation XYZPerson

- (NSString *)firstName{
    return self.personObject[@"firstName"]; //NSDictionary
}

- (void)setFirstName:(NSString *)firstName{
    self.personObject[@"firstname"] = firstName;
    [self.personObject saveInBackground];
}

- (NSString *)lastName{
    return self.personObject[@"lastName"];
}

-(void)setLastName:(NSString *)lastName{
    self.personObject[@"lastname"] = lastName;
    [self.personObject saveInBackground];
}

-(NSString *)idNumber{
    return self.personObject[@"IDNumber"];
}

-(void)setIdNumber:(NSString *)idNumber{
    self.personObject[@"IDNumber"] = idNumber;
    [self.personObject saveInBackground];
}
//現在雖然setter&getter自己寫，但因為不用去memory抓記憶體，所以不用再宣告iVar(沒有出警告或驚嘆號)
@end
