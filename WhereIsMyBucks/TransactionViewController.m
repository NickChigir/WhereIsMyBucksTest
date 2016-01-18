//
//  TransactionViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/16/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "TransactionViewController.h"
#import "AppDelegate.h"
#import "Cathegory.h"
#import "CategoryListViewController.h"

#define DETAIL_SECTION 1
#define MAIN_SECTION 0

@interface TransactionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger detailCount;
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic)  UITextField *totalAmountField;
@property (weak, nonatomic)  UIDatePicker *datePicker;

@end

@implementation TransactionViewController
- (IBAction)addDetail:(UIButton *)sender {
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    //UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    //- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self tableView: self.tableView commitEditingStyle:UITableViewCellEditingStyleInsert forRowAtIndexPath:cellIndexPath];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.editing = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveOrCancel:)];
    doneButton.tag =1;
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(saveOrCancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.title =@"New Transaction";
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view maintence
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return self.cashFlowList.count;
    if (section == MAIN_SECTION){
        return 2;
    }
    else {
        return self.detailCount;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellName;
    switch (indexPath.section) {
        case MAIN_SECTION:
            switch (indexPath.row) {
                case 0:
                    cellName =@"amountCell";
                    break;
                case 1:
                    cellName =@"dateCell";
                    
                default:
                    break;
            }
            break;
        case DETAIL_SECTION:
            cellName =  indexPath.row == self.detailCount-1 ? @"addNewCell":@"detailCell";
            break;
        default:
            cellName = @"detailCell";
            break;
    }
    //cellName    =   @"amountCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
  //  if ([cellName isEqualToString:@"detailCell"]){
  //  cell.imageView.image = [UIImage imageNamed:@"1"];
  //  }
    
       return [self configureCell:cell withName:cellName atIndexPath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row==1) {
        return 204;
    } else {
        return UITableViewAutomaticDimension;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Delete cell");
        [self deleteDetailAtRow: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else {
         NSLog(@"Insert cell");
        [self insertDetailAtRow: indexPath.row];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.section == MAIN_SECTION){
        return NO;
    }
    
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==DETAIL_SECTION && indexPath.row ==(self.detailCount-1)) {
        return UITableViewCellEditingStyleInsert;//    UITableViewCellEditingStyleNone,
       // UITableViewCellEditingStyleDelete,
      //  UITableViewCellEditingStyleInsert
    } else {
        return indexPath.section == MAIN_SECTION ?UITableViewCellEditingStyleNone:UITableViewCellEditingStyleDelete;
        
    }
}
#pragma mark - actions
-(void) saveOrCancel:(id)sender{
    
    UIBarButtonItem *item = (UIBarButtonItem *)sender;
    
    NSLog(@"sender %@", sender);
    
    if (item.tag ==1){
        [self saveChanges];
        
    }else{
        [self.managedObjectContext rollback];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - model
-(Transaction *)transaction{
    if (_transaction==nil) {

        _transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:self.managedObjectContext];
    }
    return _transaction;
}
-(void) loadData {
    // load data from Core object
   
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
     self.detailCount =self.transaction.toCashFlow.count+  1;
    
    
    //  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:context];
    
}

-(void) deleteDetailAtRow:(NSInteger) row {
    self.detailCount --;
    
    //  NSIndexSet * rowToDelete = [NSIndexSet indexSetWithIndex:row];

    
    CashFlow *detail = self.transaction.toCashFlow[row];
    detail.linkToTransaction =nil;
    [self.managedObjectContext deleteObject:detail];

}
-(void) insertDetailAtRow:(NSInteger) row{
    self.detailCount++;
    
    CashFlow *newDetail =[NSEntityDescription insertNewObjectForEntityForName:@"CashFlow" inManagedObjectContext:self.managedObjectContext];
   // newDetail.amount = [NSDecimalNumber decimalNumberWithString: self.amountField.text];
   // NSInteger catIndex = [self.cathegoryPicker selectedRowInComponent:0];
   // newDetail.linkToCathegory =[self.pickerDataSource getCathegoryAtIndex:catIndex];
    newDetail.linkToTransaction =self.transaction;
    
    NSLog(@"cashFlow list %@", self.transaction.toCashFlow);
   // NSOrderedSet *s =self.transaction.toCashFlow;
   // NSLog(@"%i", s.count);

    
}

-(UITableViewCell *) configureCell:(UITableViewCell *)cell withName:(NSString *)name atIndexPath: (NSIndexPath *)indexPath{
    //set actual data for cell
    if (indexPath.section == DETAIL_SECTION && [name isEqualToString:@"detailCell"]) {
        
        
        UIButton *categoryButton =[cell viewWithTag:1];
        UITextField *amount =[cell viewWithTag:2];
        Cathegory *category =self.transaction.toCashFlow[indexPath.row]
        .linkToCathegory;

       // categoryButton.titleLabel.text =category.cathegoryName;//UIControlStateNormal
        if (category ==nil) {
            [categoryButton setTitle:@"Unknown category" forState:UIControlStateNormal];
        }else{
        [categoryButton setTitle:category.cathegoryName forState:UIControlStateNormal];
        }
        
        amount.text = self.transaction.toCashFlow[indexPath.row].amount.description;
        amount.delegate = self;
        
    }else if ([name isEqualToString:@"amountCell"]){
        self.totalAmountField = (UITextField *)[cell viewWithTag:1];
        
        if (self.transaction.tranAmount!=nil && self.transaction.tranAmount.doubleValue != 0.0) {
            self.totalAmountField.text =self.transaction.tranAmount.description;
        }
        
    }
    else if ([name isEqualToString:@"dateCell"]){
        self.datePicker = (UIDatePicker *)[cell viewWithTag:1];
        if (self.transaction.tranDate>0) {
             self.datePicker.date =[[NSDate alloc] initWithTimeIntervalSince1970:self.transaction.tranDate];
        }
      

        
            
    }
    
    return cell;
}

-(void) saveChanges{
    self.transaction.tranAmount = [NSDecimalNumber decimalNumberWithString: self.totalAmountField.text];
    self.transaction.tranDate = self.datePicker.date.timeIntervalSince1970;
    
    //TODO: add verification code here
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    
}
#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"categoryList"]) {
        CategoryListViewController *destination =segue.destinationViewController;
        destination.transaction =self.transaction;
      
        destination.categoryButton = sender;
        UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
        NSLog(@"cell %@",[[sender superview] superview].class);
        
        //UITableView *table = (UITableView *)[cell superview];
        
        
        NSIndexPath *detailIndexPath = [self.tableView indexPathForCell:cell];
          destination.detailIndex = detailIndexPath.row;
    }
    
    
}


#pragma mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    UITableViewCell *cell = (UITableViewCell *)[[textField superview] superview];
    //UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *textFieldIndexPath = [self.tableView indexPathForCell:cell];
    if (textFieldIndexPath.section==DETAIL_SECTION) {
        
        CashFlow *detail = self.transaction.toCashFlow[textFieldIndexPath.row];
        
        detail.amount = [NSDecimalNumber decimalNumberWithString:textField.text];
        
        
    }
}


@end
