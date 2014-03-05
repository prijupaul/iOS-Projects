//
//  IntegraViewBrochureViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 11/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraViewBrochureViewController.h"
#import "IntegraBrochuresViewController.h"
#import "MBProgressHUD.h"

@interface IntegraViewBrochureViewController ()

@end

@implementation IntegraViewBrochureViewController

@synthesize fullPath;
@synthesize contentsName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *strURLPath = [self trimString: fullPath];
    NSURL *url = [NSURL fileURLWithPath:strURLPath];

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView clearsContextBeforeDrawing];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:requestObj];
    
    
}

-(NSString*) trimString:(NSString *)theString {
    if (theString != [NSNull null])
        theString = [theString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return theString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBackPressed:(id)sender {
    
    IntegraBrochuresViewController* brochure =  [self.storyboard instantiateViewControllerWithIdentifier:@"brochuresViewController"];
    brochure.contentSelected = contentsName;
    
    [self presentViewController:brochure animated:YES completion:nil];
    
}


@end
