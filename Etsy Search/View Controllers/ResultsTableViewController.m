//
//  ResultsTableViewController.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "ResultsTableViewController.h"

#import "ResultTableViewCell.h"
#import "LoadingTableViewCell.h"

@interface ResultsTableViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) UIAlertView *openEtsyAlertView;

@property (nonatomic) BOOL loadingCellExists;
@property (nonatomic, getter=isMoreDataLoading) BOOL moreDataIsLoading;

@end

@implementation ResultsTableViewController

NSString * const kDefaultCellIdentifier = @"resultIdentifier";
NSString * const kLoadingCellIdentifier = @"loadingIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // take over delegate methods
    self.etsyClient.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:kDefaultCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoadingTableViewCell" bundle:nil] forCellReuseIdentifier:kLoadingCellIdentifier];
    
    self.title = @"Search Results";
    
    self.loadingCellExists = ([self.etsyClient.listings count] < self.etsyClient.totalListings);
}

- (LoadingTableViewCell *)loadingCell
{
    LoadingTableViewCell *loadingCell = nil;
    
    if (self.loadingCellExists) {
        NSInteger row = [self.etsyClient.listings count];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        loadingCell = (LoadingTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    }
    
    return loadingCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EtsyClientDelegate methods

- (void)etsyResultsReturned:(EtsyClient *)etsyClient
{
    BOOL loadingCellShouldExist = ([self.etsyClient.listings count] < self.etsyClient.totalListings);
    
    // what new rows should be added?
    NSInteger firstRowToInsert = [self.tableView numberOfRowsInSection:0] - 1; // update the loadingCell too
    NSInteger lastRowToInsert = [self.etsyClient.listings count] - 1;
    
    NSMutableArray *indexPathsMutableArray = [[NSMutableArray alloc] init];
    for (NSInteger i = firstRowToInsert; i <= lastRowToInsert; i++) {
        [indexPathsMutableArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    // reload the table to pull the new data
    [self.tableView beginUpdates];
    
    if (self.loadingCellExists && !loadingCellShouldExist) {
        NSArray *indexPathsToDelete = @[[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0]];
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [self.tableView insertRowsAtIndexPaths:indexPathsMutableArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    self.loadingCellExists = loadingCellShouldExist;
    
    // reset the loading cell
    self.moreDataIsLoading = NO;
    [self.loadingCell reset];
}

- (void)errorGettingEtsyResults:(EtsyClient *)etsyClient
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"It looks like something went wrong. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
}

- (void)noEtsyResults:(EtsyClient *)etsyClient
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"This search no longer returns results. Please try a different search."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
    
    // exit results since nothing was returned
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0)
        // don't add the loading cell if you've reached the end of the listings
        return MIN([self.etsyClient.listings count] + 1, self.etsyClient.totalListings);
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isLoadingCell = (indexPath.row >= [self.etsyClient.listings count]);
    
    NSString *cellIdentifier = nil;
    if (isLoadingCell)
        cellIdentifier = kLoadingCellIdentifier;
    else
        cellIdentifier = kDefaultCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (isLoadingCell) {
        // nothing to do here
        
    } else {
        EtsyListing *listing = self.etsyClient.listings[indexPath.row];
        
        cell.imageView.image = listing.mainImage;
        cell.textLabel.text = listing.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@", listing.price];
    }
    
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < [self.etsyClient.listings count]) {
        self.selectedIndexPath = indexPath;
        
        self.openEtsyAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"Do you want to view this product on Etsy.com"
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Take me to Etsy.com", nil];
        [self.openEtsyAlertView show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Scroll view delegate

// Since UITableView is a subclass of UIScrollView, this will be called if this class is the table view's delegate

// http://stackoverflow.com/questions/7684441/iphone-projects-needs-pull-up-to-refresh-feature
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.loadingCell) return;
    
    if (scrollView.isDragging) {
        CGFloat thresholdToRelease = self.loadingCell.frame.origin.y - scrollView.bounds.size.height;
        CGFloat thresholdToLoad = thresholdToRelease + self.loadingCell.frame.size.height;
        
        if (([scrollView contentOffset].y >= thresholdToRelease) && ([scrollView contentOffset].y < thresholdToLoad)) {
            [self.loadingCell reset];
        } else if ([scrollView contentOffset].y >= thresholdToLoad) {
            [self.loadingCell indicateThresholdReached];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.loadingCell) return;
    
    CGFloat thresholdToAction = [self.loadingCell frame].origin.y + [self.loadingCell frame].size.height - [scrollView bounds].size.height;
    
    if ([scrollView contentOffset].y >= thresholdToAction) {
        if (!self.isMoreDataLoading) {
            
            [self.loadingCell startLoading];
            
            /*
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, [self.loadingCell frame].size.height, 0)];
            [UIView commitAnimations];
             */
            
            /* do your things here */
            [self.etsyClient nextPage];
            
            self.moreDataIsLoading = YES;
        }
    }
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == self.openEtsyAlertView && buttonIndex > 0) {
        // open Etsy
        EtsyListing *listing = self.etsyClient.listings[self.selectedIndexPath.row];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:listing.url]];
    }
}

@end
