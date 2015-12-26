//
//  CathegoryViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 12/22/15.
//  Copyright © 2015 Nick Chigir. All rights reserved.
//

#import "CathegoryViewController.h"
#import "Cathegory.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#define DUMMY_NAME @"<type name>"
#define DUMMY_DESC @"<description>"
@interface CathegoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *cathegoryName;
@property (weak, nonatomic) IBOutlet UITextField *cathegoryDesc;

@property (nonatomic) NSMutableArray<Cathegory *> *fetchResult;
@property (weak,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSIndexPath *currentRow;

@end

@implementation CathegoryViewController
- (IBAction)addNew:(id)sender {
    Cathegory *objToUpdate = self.fetchResult[self.currentRow.row];
    objToUpdate.cathegoryName = self.cathegoryName.text;
    objToUpdate.cathegoryDescription = self.cathegoryDesc.text;
    if (self.currentRow != nil  && self.currentRow.row== (self.fetchResult.count-1)){
        // add new dummy row
            [self.fetchResult addObject:[self createDummyCathegory]];
        NSLog(@"new dummy row aded");
    }
        
    
    [self.tableView reloadData];
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
        
        //delete dummy object
        Cathegory *dummyObject = self.fetchResult.lastObject;
        [self.managedObjectContext deleteObject:dummyObject];
        //save changes
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
    }
    else {
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
    
    [self.fetchResult addObject:[self createDummyCathegory]];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate =self;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CathegoryCell" forIndexPath:indexPath];
    Cathegory *content = self.fetchResult[indexPath.row];
    cell.textLabel.text = content.cathegoryName;
    cell.detailTextLabel.text = content.cathegoryDescription;
    return cell;
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
    if(indexPath.row == (self.fetchResult.count - 1)){
        self.cathegoryName.text = @"";
        self.cathegoryDesc.text = @"";
        
        
    } else {
        self.cathegoryName.text = self.fetchResult[indexPath.row].cathegoryName;
        self.cathegoryDesc.text = self.fetchResult[indexPath.row].cathegoryDescription;
      }
  self.currentRow = indexPath;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if (indexPath.row == self.fetchResult.count -1){
        return NO;
    }
        
    return YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
