//
//  ScrollViewController.m
//  WhereIsMyBucks
//
//  Created by Nick Chigir on 1/5/16.
//  Copyright © 2016 Nick Chigir. All rights reserved.
//

#import "ScrollViewController.h"
#import "TranDetailViewController.h"
#import "DetailListViewController.h"
#import "NewTranViewController.h"
#import "AppDelegate.h"

#define PAGE_NUM 3
@interface ScrollViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic) BOOL pageControlUsed;
@property (nonatomic) NSMutableArray * pages;

@property (nonatomic) Transaction *tran;


@end

@implementation ScrollViewController

#pragma mark - scroll view + page controller

- (IBAction)pageChanged:(UIPageControl *)sender {
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * sender.currentPage;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    self.pageControlUsed = YES;
    
}

- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    self.pageControl.currentPage = page;
    // Update the page control
    // self.pageControl.currentPage = page;
    
    // Work out which pages we want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pages.count; i++) {
        [self purgePage:i];
    }
}

- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    CGRect frame = self.scrollView.bounds;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0.0f;
    // Load an individual page, first seeing if we've already loaded it
    UIViewController *pageView = [self.pages objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        
        NSArray<NSString *> *controllerName = @[@"mainTransaction",@"detailTransaction",@"tranList"];
        
        NSLog(@" nibname : %@", self.nibName);
        HBTransactionController *newPageController = [self.storyboard instantiateViewControllerWithIdentifier:controllerName[page]];
        //[[ConentViewController alloc] initWithNibName:(self.nibName) bundle:self.nibBundle];
        newPageController.transaction = self.tran;
        newPageController.scrollDelegate =self;
        UIView *newView =newPageController.view;
        newView.frame = frame;
        [self.scrollView addSubview:newView];
        [self.pages replaceObjectAtIndex:page withObject:newPageController];
    }else
    {//reconfigure frame in case of device rotating
        UIView *pageView =[(UIViewController *)self.pages[page] view];
        pageView.frame = frame;
    }
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pages.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    /*   // Remove a page from the scroll view and reset the container array
     UIView *pageView = [self.pageViews objectAtIndex:page];
     if ((NSNull*)pageView != [NSNull null]) {
     [pageView removeFromSuperview];
     [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
     }
     */
}

-(void)viewDidLayoutSubviews{
    [ super viewDidLayoutSubviews];
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pages.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
    [self loadVisiblePages];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages which are now on screen
    if (!self.pageControlUsed) {
        [self loadVisiblePages];
    }
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControlUsed = NO;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.pageControlUsed = NO;
}

-(void) jumpToNextPage{
    NSInteger oldPageNumber = self.pageControl.currentPage;
    if(oldPageNumber+1 <PAGE_NUM){
        self.pageControl.currentPage++;
        [self pageChanged :self.pageControl];
    }
   
}

#pragma mark - viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // initiate scroll view, reserve place for pages;
    self.pages = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < PAGE_NUM; ++i) {
        [self.pages addObject:[NSNull null]];
    }
    self.scrollView.delegate = self;
    self.pageControlUsed = NO;
    // create a new Transaction object for use in subviews
    [self createTransaction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}



-(void)createTransaction{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    //  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:context];
    Transaction *newTran = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
    
    self.tran = newTran;
    
}
#pragma mark - actions

- (IBAction)addTransaction:(id)sender {
       NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    
    //TODO: add verification code here
    
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    //close this view
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancel:(id)sender {
       NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication]delegate]  managedObjectContext];
    [context rollback];
    //close this view
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
