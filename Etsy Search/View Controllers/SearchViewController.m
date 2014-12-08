//
//  SearchViewController.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 12/7/2014.
//  Copyright (c) 2014 Jay Whitsitt. All rights reserved.
//

#import "SearchViewController.h"

#import "EtsyClient.h"

@interface SearchViewController () <EtsyClientDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Etsy Search";
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
    // start the search
    
    // when results are returned, show the new nib
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EtsyClientDelegate methods

- (void)etsyResultsReturned:(EtsyClient *)etsyClient
{
    
}

- (void)errorGettingEtsyResults:(EtsyClient *)etsyClient
{
    
}

@end
