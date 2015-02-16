//
//  SearchViewController.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "SearchViewController.h"

#import "EtsyClient.h"
#import "ResultsTableViewController.h"

@interface SearchViewController () <EtsyClientDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Etsy Search";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (IBAction)keywordsChanged:(UITextField *)sender
{
    NSString *searchString = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([searchString isEqualToString:@""]) {
        self.searchButton.enabled = NO;
    } else {
        self.searchButton.enabled = YES;
    }
}

- (IBAction)search
{
    NSString *searchString = [self.searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([searchString isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Looks like you didn't enter anything in the search field. Please enter your query and tap the Search button again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    // block user interaction
    [self.view endEditing:YES];
    [self pauseInteraction:YES];
    
    // start the search
    EtsyClient *etsyClient = [[EtsyClient alloc] init];
    etsyClient.delegate = self;
    
    [etsyClient getResultsForKeywords:searchString];
    
    // when results are returned, show the new nib
}

- (void)pauseInteraction:(BOOL)paused
{
    self.searchField.enabled = !paused;
    self.searchButton.enabled = !paused;
    
    if (paused)
        [self.activityIndicator startAnimating];
    else
        [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EtsyClientDelegate methods

- (void)etsyResultsReturned:(EtsyClient *)etsyClient
{
    // give the client to the new results nib
    ResultsTableViewController *resultsTableViewController = [[ResultsTableViewController alloc] init];
    resultsTableViewController.etsyClient = etsyClient;
    
    // present the nib
    [self.navigationController pushViewController:resultsTableViewController animated:YES];
    
    [self pauseInteraction:NO];
    
}

- (void)errorGettingEtsyResults:(EtsyClient *)etsyClient
{
    // tell the user
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"It looks like something went wrong. Please try again."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
    [self pauseInteraction:NO];
}

- (void)noEtsyResults:(EtsyClient *)etsyClient
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"That search didn't return any active listings. Try different keywords."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
    [self pauseInteraction:NO];
}

@end
