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

@end

@implementation ResultsTableViewController

NSString * const defaultCellIdentifier = @"resultIdentifier";
NSString * const loadingCellIdentifier = @"loadingIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // take over delegate methods
    self.etsyClient.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultTableViewCell" bundle:nil] forCellReuseIdentifier:defaultCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"LoadingTableViewCell" bundle:nil] forCellReuseIdentifier:loadingCellIdentifier];
    
    self.title = @"Search Results";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EtsyClientDelegate methods

- (void)etsyResultsReturned:(EtsyClient *)etsyClient
{
    // reload the table to pull the new data
    [self.tableView reloadData];
    
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
        cellIdentifier = loadingCellIdentifier;
    else
        cellIdentifier = defaultCellIdentifier;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (isLoadingCell) {
        // get the next batch
        [self.etsyClient nextPage];
        
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
