//
//  LogInViewController.m
//  1021HW
//
//  Created by Cyrilshanway on 2014/10/24.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 應該放在viewWillAppear
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        [self performSegueWithIdentifier:@"Show main view controller" sender:nil];
    } else {
        // show the signup or login screen
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 10/24
- (IBAction)loginBurronPressed:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"successful");
                                            
                                            // 直接跳到下一頁
                                            [self performSegueWithIdentifier:@"Show main view controller" sender:nil];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"failed");
                                        }
                                    }];
    
}

- (IBAction)registerBtnPressed:(id)sender {
    //要用"點"
    PFUser *user = [PFUser user];
    user.username = @"shyne";
    user.password = @"shyne";
    user.email    = @"email@example.com";
    
    // other fields can be set just like with PFObject
    //其他欄位放這
    user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            // alert - successful
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            // errort alert
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
