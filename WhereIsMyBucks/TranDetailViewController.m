//
//  TranDetailViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "TranDetailViewController.h"
#import "AppDelegate.h"
#import "CategoryPickerDataSource.h"
@interface TranDetailViewController ()
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic)   CategoryPickerDataSource * pickerDataSource;
@property (nonatomic) double currentBalance;
@property (nonatomic) double originalBalance;

@end

@implementation TranDetailViewController
- (IBAction)addDetail:(UIButton *)sender {
    
    CashFlow *newDetail =[NSEntityDescription insertNewObjectForEntityForName:@"CashFlow" inManagedObjectContext:self.managedObjectContext];;
    newDetail.amount = [NSDecimalNumber decimalNumberWithString: self.amountField.text];
    NSInteger catIndex = [self.cathegoryPicker selectedRowInComponent:0];
    newDetail.linkToCathegory =[self.pickerDataSource getCathegoryAtIndex:catIndex];
    newDetail.linkToTransaction =self.transaction;
    
    NSLog(@"cashFlow list %@", self.transaction.toCashFlow);
    NSOrderedSet *s =self.transaction.toCashFlow;
    NSLog(@"%i", s.count);
    [self updateBalanceWithAmount:-1.0*newDetail.amount.doubleValue];
    //[self.transaction addToCashFlowObject:newDetail];
    [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_ADDED_NOTIFICATION object:nil];
    
    [self reset:nil];
}

- (IBAction)reset:(id)sender {
    self.amountField.text =@"";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.currentBalance =0.0;
    self.originalBalance = 0.0;
    
     self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    
   self.pickerDataSource = [[CategoryPickerDataSource alloc] initWithContext:self.managedObjectContext];
    
    self.cathegoryPicker.dataSource = self.pickerDataSource;
    self.cathegoryPicker.delegate = self.pickerDataSource;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAmount) name:AMOUNT_UPDATED_NOTIFICATION object:nil];
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(decreaseAmount:) name:DETAIL_REMOVED_NOTIFICATION object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"DETAIL VIEW DISAPPIARED");
}
-(void)updateAmount{
   // self.balanceLabel.text = self.transaction.tranAmount.description;
    double diff = self.transaction.tranAmount.doubleValue - self.originalBalance;
    [self updateBalanceWithAmount:diff];
    self.originalBalance = self.transaction.tranAmount.doubleValue;
}

-(void) decreaseAmount: (NSNotification *)info{
    NSDecimalNumber *num = info.userInfo[@"amount"];
    [self updateBalanceWithAmount:num.doubleValue];
}
-(void) updateBalanceWithAmount: (double) amount{
    self.currentBalance +=amount;
    self.balanceLabel.text = [NSString stringWithFormat:@"Remain: %.00f",self.currentBalance];
    
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
