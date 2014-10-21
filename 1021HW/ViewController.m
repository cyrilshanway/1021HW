//
//  ViewController.m
//  1021HW
//
//  Created by Joseph on 2014/10/21.
//  Copyright (c) 2014年 dosomethingq. All rights reserved.
//

#import "ViewController.h"
#import "Customer.h"
#import "DepositViewController.h"
#import "WithdrawViewController.h"
#import "QueryViewController.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *FisrtNameTextFild;

@property (weak, nonatomic) IBOutlet UITextField *LastNameTextFild;

@property (weak, nonatomic) IBOutlet UITextField *IDTextFild;



@property (strong, nonatomic) NSMutableArray *customerArray;
@property (strong, nonatomic) NSMutableDictionary *customerDictionary;


@property Customer *currentCustomer ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)AccountCreate:(id)sender {
    
    NSString *firstName = self.FisrtNameTextFild.text ;
    NSString *lastName = self.LastNameTextFild.text ;
    NSString *IDName = self.IDTextFild.text ;
    //把IBOutlet 拉的 textfield 欄位的字，給NSString
    
    
    Customer *person=[[Customer alloc]init];
    // Customer 繼承 XYZPerson
    
    
    person.firstName=firstName;
    person.lastName=lastName;
    person.idNumber=IDName;
    // 去setting XYZPerson 裡的name and number，把textfield拉出來的字給XYZPerson
    
    
    [self.customerArray addObject:person];
    // add object，不單只有firstName,lastName,IDName,還有他 person customer 裡的 method，跟他繼承的東西 ？
    
    
    /*
     self.FisrtNameTextFild.text = @"";
     self.LastNameTextFild.text = @"";
     self.IDTextFild.text = @"";
     */
    //可以把TextFiled hide ， 當button按下去那一個瞬間
    
    
    //[self.customerDictionary setValue:person forKey:IDName]; 兩種寫法
    self.customerDictionary[IDName]=person;
    
    
    NSLog(@"Account created %@ %@" , person.firstName , person.lastName);
    
    [person showBalance];
    
    self.currentCustomer =person;
    //把person object(裡面有customer class , method)給currentCustomer,之後再把self.currentCustomer給BalanceViewController用，這樣BalanceViewController就可以用person 的 object (customer class , method)
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations,Your Account Created"
                                                    message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
    [alert show];
    
    
}



-(NSMutableDictionary*) customerDictionary {
    if(!_customerDictionary)
        _customerDictionary = [[NSMutableDictionary alloc]init];
    return _customerDictionary;
    
}


-(NSMutableArray*) customerArray{
    
    if(!_customerArray)
        _customerArray = [[NSMutableArray alloc]init];
    
    return _customerArray;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    BalanceViewController* destinationVC = segue.destinationViewController ;
//    
//    // pass info : current customer to BalanceViewController
//    destinationVC.currentCustomer=self.currentCustomer;
//    //BalanceViewController即可用 person's object
 
    
    UIViewController *vc = segue.destinationViewController;
    
    if( [vc isKindOfClass:[DepositViewController class]]) {
    
        
        DepositViewController* DV = segue.destinationViewController;
        
        DV.currentCustomer=self.currentCustomer;
        
    }
    
    else if( [vc isKindOfClass:[WithdrawViewController class]]) {
    
    
        
        
        WithdrawViewController* WV = segue.destinationViewController;
        
        WV.currentCustomer=self.currentCustomer;
        
    
    }
    
    
    else if( [vc isKindOfClass:[QueryViewController class]]) {
        
        
        
        
        QueryViewController* QV = segue.destinationViewController;
        
       //QV.currentCustomer=self.currentCustomer;
       //應該不需要做吧
        
        QV.customerDictionary = self.customerDictionary;
        
        
    }

    
    
    
    
}





@end
