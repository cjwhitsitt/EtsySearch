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
        EtsyListing *listing = [etsyListing copy];
        
        self.listingImage.image = listing.mainImage;
        self.listingTitle.text = listing.title;
        self.listingPrice.text = listing.price;
        self.listingDescription.text = listing.description;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
