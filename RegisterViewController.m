//
//  RegisterViewController.m
//  1021HW
//
//  Created by Cyrilshanway on 2014/10/24.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdCfmTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnPressed:(id)sender {
    
    //要用"點"
    PFUser *user  = [PFUser user];
    user.username = self.userNameTextField.text;
    user.password = self.pwdTextField.text;
    user.email    = self.emailTextField.text;
    
    // other fields can be set just like with PFObject
    //其他欄位放這
    //user[@"phone"] = self.phoneNumberTextField;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            // alert - successful
            [user saveInBackground];
            [self performSegueWithIdentifier:@"MainViewSegue" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            // errort alert
            NSLog(@"%@", errorString);

            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"OOPs"
                                        message:@"此帳號已註冊過"
                                        preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [alert dismissViewControllerAnimated:YES
                                                                                     completion:nil];
                                                       }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               [alert dismissViewControllerAnimated:YES
                                                                                         completion:nil];
                                                           }];
            
            
            [alert addAction:ok];
            [alert addAction:cancel];
            
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }];
}

@end
