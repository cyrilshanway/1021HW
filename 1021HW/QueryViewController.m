//
//  QueryViewController.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "QueryViewController.h"
//#import "ViewController.h"

@interface QueryViewController ()


@property (weak, nonatomic) IBOutlet UITextField *idTextField;



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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)queryIDPressed:(id)sender {
    
    
    
    
    
    NSString *idTextField = self.idTextField.text;
    self.currentCustomer= [self.customerDictionary objectForKey:idTextField];
    // key給objectForKey會得到一個 object , 一個 Person's object，customerDictionary 先lazy init後，再指向他，之後再讓currentCustomer給指
    
    
    
    NSString *name = [NSString stringWithFormat:@"%@ %@",self.currentCustomer.firstName, self.currentCustomer.lastName];
    
    NSString *balance = [NSString stringWithFormat:@"Balance is %i", self.currentCustomer.balance];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:name message:balance delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    
    [alert show];
    
    
    
    
    
}





@end
