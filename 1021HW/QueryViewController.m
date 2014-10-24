//
//  QueryViewController.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "QueryViewController.h"
//#import "ViewController.h"
#import "Customer.h"

@interface QueryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *idTextField;

@property (strong,nonatomic) NSMutableArray *customerArray;


@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSMutableDictionary *) customerDictionary{
//    if(!_customerDictionary)
//        _customerDictionary = [[NSMutableDictionary alloc] init];
//    
//    return _customerDictionary;
//    
//}
//有需要做嗎 ？

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *) customerArray {
    
    //    if(!_customerArray)
    //        _customerArray = [[NSMutableArray alloc] init];
    
#pragma mark - 10/22新教寫法
    if (!_customerArray) {
        _customerArray = [@[]mutableCopy];
    }
    
    return _customerArray;
}


- (IBAction)queryIDPressed:(id)sender {
    
    //NSString *idTextField = self.idTextField.text;
   // self.currentCustomer  = self.customerDictionary[idTextField];
    // key給objectForKey會得到一個 object , 一個 Person's object，customerDictionary 先lazy init後 ?，再指向他，之後再讓currentCustomer給指
    
    /*
    NSString *name = [NSString stringWithFormat:@"%@ %@",self.currentCustomer.firstName, self.currentCustomer.lastName];
    
    NSString *balance = [NSString stringWithFormat:@"Balance is %i", [self.currentCustomer.balance intValue]];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:name
                                message:balance //[NSString stringWithFormat:@"%@",IDName]
                                preferredStyle:(UIAlertControllerStyleAlert)];
    
    // 想像成button
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
    
    // 用ViewController,不用segue就要用這個方法 completion:顯示完要做什麼
    [self presentViewController:alert animated:YES completion:nil];
    */
    
#pragma mark --10/23 parse-query-test
    PFQuery *query = [PFQuery queryWithClassName:@"Customer"];
    [query whereKey:@"IDName" equalTo:self.idTextField.text];//@"IDNumber" /self.idTextField.text
    //[query whereKey:@"IDNumber" equalTo:self.idTextField.text];
    //[query findObjectsInBackgroundWithBlock:^(NSArray *objects , NSError *error) {
    //
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *objects , NSError *error) {
        if (objects) {
            // The find succeeded.
            NSLog(@"successful");
            NSLog(@"%@", objects);
            // Do something with the found objects
            NSString *name = [NSString stringWithFormat:@"%@ %@",objects[@"firstName"],objects[@"lastName"] ];
            
            NSString *balance = [NSString stringWithFormat:@"Balance is %@", objects[@"balance"]];
            
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:name
                                        message:balance //[NSString stringWithFormat:@"%@",IDName]
                                        preferredStyle:(UIAlertControllerStyleAlert)];
            
            // 想像成button
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [alert dismissViewControllerAnimated:YES
                                                                                     completion:nil
                                                                                     //如要按完ok再顯示code寫在這裡
                                                            ];
                                                           
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
            
        } else {
            
            UIAlertController *alert = [UIAlertController
                                        alertControllerWithTitle:@"OOPS"
                                        message:@"nothing to find"
                                        preferredStyle:(UIAlertControllerStyleAlert)];
            
            // 想像成button
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
