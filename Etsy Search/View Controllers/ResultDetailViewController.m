//
//  ResultDetailViewController.m
//  Etsy Search
//
//  Created by Jay Whitsitt on 2/15/15.
//  Copyright (c) 2015 Jay Whitsitt. All rights reserved.
//

#import "ResultDetailViewController.h"

@interface ResultDetailViewController ()

@property (nonatomic, strong) EtsyListing *listing;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *listingImage;
@property (weak, nonatomic) IBOutlet UILabel *listingTitle;
@property (weak, nonatomic) IBOutlet UILabel *listingPrice;
@property (weak, nonatomic) IBOutlet UILabel *listingDescription;

@end

@implementation ResultDetailViewController

- (ResultDetailViewController *)initWithEtsyListing:(EtsyListing *)etsyListing
{
    self = [super init];
    
    if (self) {
        //TODO: make this copy-able
        self.listing = etsyListing;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Listing";
    
    if (!self.listing) {
        // this shouldn't happen - there should be some defensive coding here
        return;
    }
    
    self.listingImage.image = self.listing.mainImage;
    self.listingTitle.text = self.listing.title;
    self.listingPrice.text = [NSString stringWithFormat:@"$%@", self.listing.price]; //TODO: support multiple currencies using number formatter
    self.listingDescription.text = self.listing.resultDescription;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)viewOnEtsy:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.listing.url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
