//
//  CategoryTableViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/19/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "CategoryTableViewController.h"
#import "Cathegory.h"
#import "Cathegory+CoreDataProperties.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#define DUMMY_NAME @""
#define DUMMY_DESC @""
@interface CategoryTableViewController ()
@property (nonatomic) NSMutableArray<Cathegory *> *fetchResult;
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSIndexPath *currentRow;
@property (nonatomic) BOOL shouldSave;

@end

@implementation CategoryTableViewController

- (void)edit:(UIButton *)sender {
    // NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:self.fetchResult.count inSection:0];
    
    self.tableView.editing = !self.tableView.editing;
    //deprecated )
    /*   if (self.tableView.editing) {
     
     [self.tableView insertRowsAtIndexPaths:@[lastRowIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
     } else {
     [self.tableView deleteRowsAtIndexPaths:@[lastRowIndex] withRowAnimation:UITableViewRowAnimationFade];
     }
     */
}
- (IBAction)addNew:(id)sender {
    /*Cathegory *objToUpdate = self.fetchResult[self.currentRow.row];
     objToUpdate.cathegoryName = self.cathegoryName.text;
     objToUpdate.cathegoryDescription = self.cathegoryDesc.text;
     */
    // if (self.currentRow != nil  && self.currentRow.row== (self.fetchResult.count-1)){
    // add new dummy row
    [self.fetchResult addObject:[self createDummyCathegory]];
    NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:self.fetchResult.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[lastRowIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSLog(@"new dummy row added");
    // }
    
    
    // [self.tableView reloadData];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UITouch *t in touches) {
        if (![t.view isKindOfClass: self.tableView.class]){
            self.tableView.editing =NO;
        }
        
    }
}

- (IBAction)toEditMode:(id)sender {
    self.tableView.editing = YES;
    NSLog(@"Editing begin");
}

- (IBAction)saveOrCancel:(UIButton *)sender {
    if ([(UIButton *)sender tag]==1){
        //save changes
        self.shouldSave =YES;
        
    }
    else {
        self.shouldSave =NO;
        [self.managedObjectContext reset];
        NSLog(@"changes were reseted");
    }
    
    //close this view
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    /*NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
     aFetchedResultsController.delegate = self;
     self.fetchedResultsController = aFetchedResultsController;
     */
    NSError *error = nil;
    self.fetchResult = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (error != nil) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error while fetching cathegory %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveOrCancel:)];
    save.tag = 1;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(saveOrCancel:)];
    self.navigationItem.leftBarButtonItem = cancel;
    self.navigationItem.rightBarButtonItems = @[save,self.editButtonItem];
    
    // [self.fetchResult addObject:[self createDummyCathegory]];
    
    
    //self.tableView.dataSource = self;
    //self.tableView.delegate =self;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    if (self.shouldSave) {
        NSLog(@"Save changes");
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
    }
    
    NSLog(@"Disappeared!");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rowCount =self.fetchResult.count+1;
    // rowCount+=self.tableView.editing?1:0;
    // NSLog(@"number of rows: %i", rowCount);
    // NSLog(@"Editing mode: %i", self.tableView.editing?1:0);
    return rowCount;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName =@"CathegoryCell";
    if (indexPath.row == self.fetchResult.count) {
        //this means we are in editing mode, add "add new" button cell
        cellName =@"newCategory";
    }
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

-(void) configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *) indexPath {
    
    if (indexPath.row < self.fetchResult.count) {
        Cathegory *content = self.fetchResult[indexPath.row];
        UITextField *nameField = [cell viewWithTag:2];
        UITextField *descField = [cell viewWithTag:3];
        nameField.text = content.cathegoryName;
        descField.text = content.cathegoryDescription;
        nameField.delegate = self;
        descField.delegate = self;
    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Delete cell");
        [self deleteCathegoryAtRow: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

#pragma mark table delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*  if(indexPath.row == (self.fetchResult.count - 1)){
     self.cathegoryName.text = @"";
     self.cathegoryDesc.text = @"";
     
     
     } else {
     self.cathegoryName.text = self.fetchResult[indexPath.row].cathegoryName;
     self.cathegoryDesc.text = self.fetchResult[indexPath.row].cathegoryDescription;
     }
     */
    self.currentRow = indexPath;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == self.fetchResult.count){
        return NO;
    }else {
        Cathegory *cat = self.fetchResult[indexPath.row];
        
        if (cat.toCashFlow.count ==0) {
            return YES;
        } else {
            return NO;
        }
        
        
        //     return YES;
    }
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    NSLog(@"Edit begin!");
    
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED{
    NSLog(@"Edit end!");
    
}

#pragma mark private methods

- (Cathegory *) createDummyCathegory {
    Cathegory *cathegory = [NSEntityDescription insertNewObjectForEntityForName:@"Cathegory" inManagedObjectContext:self.managedObjectContext];
    cathegory.cathegoryName = DUMMY_NAME;
    cathegory.cathegoryDescription = DUMMY_DESC;
    return cathegory;
    // [self.fetchResult addObject:cathegory];
    //[self.tableView reloadData];
    
}

- (void) deleteCathegoryAtRow:(NSInteger) row{
    Cathegory *objToDelete =self.fetchResult[row];
    
    [self.managedObjectContext deleteObject:objToDelete];
    [self.fetchResult removeObjectAtIndex:row];
    
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
    
    Cathegory *cat = self.fetchResult[textFieldIndexPath.row];
    
    if(textField.tag ==2){
        cat.cathegoryName = textField.text;
    }else{
        cat.cathegoryDescription = textField.text;
    }
    
    NSLog(@"DidEndEditing");
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"WillEndEditing!");
    return YES;
}




//--================








/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
