//
//  WithdrawViewController.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "WithdrawViewController.h"

@interface WithdrawViewController ()


@property (weak, nonatomic) IBOutlet UITextField *withdrawAmountTextField;

@end

@implementation WithdrawViewController

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


- (IBAction)withdrawButtonPressed:(id)sender {
    
    int amount =[self.withdrawAmountTextField.text  intValue];  // intValue 把字串變整數
    
    //Customer * currentCustomer= self.customerDictionary[self.IDTextFild.text];
    
    
    [self.currentCustomer withdraw:amount];
    
    [self.currentCustomer showBalance];
    
    NSString *amountString  = [NSString stringWithFormat:@"Withdraw : %@", self.withdrawAmountTextField.text];
    NSString *balanceString = [NSString stringWithFormat:@"Your Balance Amount : %i", [self.currentCustomer.balance intValue]];
    
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:amountString message:balanceString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
//    [alert show];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:amountString
                                message:balanceString
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





@end
