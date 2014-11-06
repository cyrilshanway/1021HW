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
#import <Parse/Parse.h>

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UITextField *FisrtNameTextFild;

@property (weak, nonatomic) IBOutlet UITextField *LastNameTextFild;

@property (weak, nonatomic) IBOutlet UITextField *IDTextFild;

@property (strong, nonatomic )NSMutableArray *idNumArray;

@property (strong, nonatomic) NSMutableArray *customerArray;
@property (strong, nonatomic) NSMutableDictionary *customerDictionary;


@property Customer *currentCustomer ;


@property NSNumber *balance;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)AccountCreate:(id)sender {
    
    NSString *firstName = self.FisrtNameTextFild.text ;
    NSString *lastName  = self.LastNameTextFild.text ;
    NSString *IDName    = self.IDTextFild.text ;
    //把IBOutlet 拉的 textfield 欄位輸入的值給NSString宣告的新NSString
    
    
    //10/22
    // 抓出已經有值的帳號
    if (self.customerDictionary[IDName]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account exits"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        //return;
    } else {
        
        
        Customer *person=[[Customer alloc]init];
        // Customer 繼承 XYZPerson
        
        /* 不存local，改存Parse
        person.firstName=firstName;
        person.lastName=lastName;
        person.idNumber=IDName;
        // 去setting XYZPerson 裡的name and number，把textfield拉出來的字給XYZPerson
        */
         
#pragma mark - 10/23
        PFObject *customerObject = [PFObject objectWithClassName:@"Customer"];//calss name
        
       // NSMutableDictionary *customerObject =[@{} mutableCopy];
        customerObject[@"firstName"] = firstName;
        customerObject[@"lastName"]  = lastName;
        customerObject[@"IDName"]    = IDName;
       // customerObject[@"firstName"-->跑到XYZPerson.m的setter方法裡] = 上面(57行宣告的@"firstName")
        
        //存檔
        [customerObject saveInBackground];
        
#pragma mark - 10/23
        person.personObject = customerObject;
    //前面宣告.(.h宣告@property) = PFObject宣告
        
        
        [self.customerArray addObject:person];
        // add object，不單只有firstName,lastName,IDName,還有他 person customer 裡的 method，跟他繼承的東西 ？
      
#pragma mark - 10/22
        [self.idNumArray addObject:IDName];
        
        
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
        
        
        [self saveData];
    }
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
    //id vc = segue.destinationViewController;
    
    // 已先判斷是否同class
    //   父類isKindOfClass:[子類 class]
    if( [vc isKindOfClass:[DepositViewController class]]) {
    
        // 就不會當機
        DepositViewController* DV = segue.destinationViewController;
        //DepositViewController* DV = vc;
        
        DV.currentCustomer=self.currentCustomer;
        
        // 強制轉型成DepositViewController
        //((DepositViewController *)vc).currentCustomer = self.currentCustomer;
        
    } else if( [vc isKindOfClass:[WithdrawViewController class]] ||
               [vc isKindOfClass:[WithdrawViewController class]]) {
        
        WithdrawViewController* WV = segue.destinationViewController;
        
        WV.currentCustomer=self.currentCustomer;
        
    }else if( [vc isKindOfClass:[QueryViewController class]]) {
        
        QueryViewController* QV = segue.destinationViewController;
        
       //QV.currentCustomer=self.currentCustomer;
       //應該不需要做吧
        
        QV.customerDictionary = self.customerDictionary;
    }
}

#pragma mark - 10/22 lazy init-
- (NSMutableArray *)idNumArray{
    
    if (!_idNumArray)
        _idNumArray = [@[] mutableCopy];
    
    return _idNumArray;
    
}



#pragma mark - 10/22 load data

- (void)loadData{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSString *fullArchivedFilePath = [documentDirectory stringByAppendingPathComponent:@"data.xyz"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullArchivedFilePath]) {
        self.customerArray = [NSKeyedUnarchiver unarchiveObjectWithFile:fullArchivedFilePath];
    }
}

#pragma mark - 10/22 save data
- (void)saveData{
    if (!self.idNumArray || self.idNumArray.count == 0) {
        NSLog(@"nothing to save");
        return;
    }
    
    //write to file
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    NSString *documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:@"data.xyz"];
    
    BOOL success = [NSKeyedArchiver archiveRootObject:self.idNumArray toFile:documentDirectoryFilename];
    NSAssert(success, @"ArchiveRootObject failed");
}

// 每人都加1000
- (void)increaseBalance{
    int bonus = 1000;
    
    for (int i=0; i<self.customerArray.count; i++) {
        Customer *customer = self.customerArray[i];
        [customer deposit:bonus];
        
    }
    
    for (Customer *customer in self.customerArray) {
        [customer deposit:bonus];
    }
}

-(IBAction)backToMainViewController:(UIStoryboardSegue*) segue {
    
}
@end
