//
//  NewTranViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 11/27/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import "NewTranViewController.h"
#import "Transaction.h"
#import "AppDelegate.h"
#import "KeysGenerator.h"

@interface NewTranViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AmountText;
@property (weak, nonatomic) IBOutlet UIDatePicker *TranDate;

@end

@implementation NewTranViewController
- (IBAction)SaveOrCancel:(id)sender {
    if ([(UIButton *)sender tag]==1){
        //save changes
        /*  NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
      //  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:context];
         Transaction *newTran = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
         */
        self.transaction.tranDate = [self.TranDate.date timeIntervalSince1970];
        self.transaction.tranAmount = [NSDecimalNumber decimalNumberWithString:  self.AmountText.text];
        
        self.transaction.id = [KeysGenerator getNewTranId];
        
        //send notification
        [[NSNotificationCenter defaultCenter] postNotificationName:AMOUNT_UPDATED_NOTIFICATION object:nil];
        if (self.scrollDelegate){
            [self.scrollDelegate jumpToNextPage];
         }
       // int32_t n32 = n.intValue;
        
     
       
        
         // If appropriate, configure the new managed object.
         // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
       //  [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
        
         //[NSDate date].ti
         // Save the context.
      /*   NSError *error = nil;
         if (![context save:&error]) {
         // Replace this implementation with code to handle the error appropriately.
         // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
         abort();
         }
       */
         
        
    }
    //close this view
   // [self dismissViewControllerAnimated:YES completion:nil];
}

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

@end
