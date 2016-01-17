//
//  CategoryListViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/17/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "CategoryListViewController.h"
#import "AppDelegate.h"

@interface CategoryListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray<Cathegory *> *fetchResult;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation CategoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // return self.cashFlowList.count;
    return self.fetchResult.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    return [self populateData:cell forRow:indexPath.row];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    [self updateSelectedIndex:indexPath.row];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
  
    cell.accessoryType = UITableViewCellAccessoryNone;
}
#pragma mark - Core data maintenance

-(void)loadData{
    self.managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cathegory" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:50];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cathegoryName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    

    NSError *error = nil;
    self.fetchResult = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (error != nil) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error while fetching cathegory %@, %@", error, [error userInfo]);
        abort();
    }
    

}

-(UITableViewCell *) populateData: (UITableViewCell *)cell forRow: (NSInteger) row{
    if (row<self.fetchResult.count) {
        cell.textLabel.text =self.fetchResult[row].cathegoryName; //@"Category";
        cell.detailTextLabel.text =self.fetchResult[row].cathegoryDescription;//@"description";
        cell.imageView.image =[UIImage imageNamed:@"1"];
    }
  
    
    return cell;
}

-(void)updateSelectedIndex: (NSInteger) index{
    
    CashFlow *detail=  self.transaction.toCashFlow[self.detailIndex];
    detail.linkToCathegory = self.fetchResult[index];
    NSString *title =self.fetchResult[index].cathegoryName;
    [self.categoryButton setTitle:title forState:UIControlStateNormal];
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
