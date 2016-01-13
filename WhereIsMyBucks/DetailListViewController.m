//
//  DetailListViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "DetailListViewController.h"
#import "Cathegory.h"
#import "AppDelegate.h"
@interface DetailListViewController ()

@end

@implementation DetailListViewController
- (IBAction)edit:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"Edit"]) {
       
       // self.editButton.titleLabel.text =@"Done";
        [self.editButton setTitle:@"Done" forState: self.editButton.state];
     //  [self ]
        
    } else {
        
        self.editButton.titleLabel.text =@"Edit";
    }
  self.tableView.editing =!self.tableView.editing;
}

-(NSOrderedSet<CashFlow *> *)cashFlowList{
    if(!_cashFlowList){
        _cashFlowList =self.transaction.toCashFlow;
        
    }
    return _cashFlowList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:DETAIL_ADDED_NOTIFICATION object:nil];
    self.tableView.dataSource = self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"List VIEW DISAPPIARED");
}
-(void) refreshList{
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cashFlowList.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CashFlow *content = self.cashFlowList[indexPath.row];
    cell.textLabel.text = content.linkToCathegory.cathegoryName;
    cell.detailTextLabel.text = [NSString  stringWithFormat:@"%.00f", content.amount.floatValue];
    return cell;
  
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Delete cell");
        [self deleteCellAtRow: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}


-(void) deleteCellAtRow: (NSInteger) row {
  //  NSIndexSet * rowToDelete = [NSIndexSet indexSetWithIndex:row];
     NSManagedObjectContext  *managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    
    CashFlow *detail = self.transaction.toCashFlow[row];
    detail.linkToTransaction =nil;
    [self sendDeleteNotificationWithAmount:detail.amount];
    [managedObjectContext deleteObject:detail];
    
   // [self.transaction removeToCashFlowAtIndexes:rowToDelete];
    
}

-(void) sendDeleteNotificationWithAmount: (NSDecimalNumber*) amount {
    NSDictionary *info = @{@"amount":amount};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_REMOVED_NOTIFICATION object:nil userInfo:info];
    
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
