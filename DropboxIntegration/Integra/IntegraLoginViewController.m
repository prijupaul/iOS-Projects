//
//  IntegraLoginViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 21/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraLoginViewController.h"
#import "AlertDialogUtils.h"
#import "IntegraHomeViewController.h"

@implementation IntegraLoginViewController

@synthesize textfieldEmail;
@synthesize textfieldName;
@synthesize textfieldPhone;
@synthesize loginButton;

-(void)viewDidLoad{
    self.navigationItem.hidesBackButton = YES;
    
    // add image
    NSString *imageFile = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], @"logo"];
    UIImage *img = [UIImage imageWithContentsOfFile:imageFile];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    self.navigationItem.titleView = imgView;
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    loginButton.backgroundColor = [UIColor brownColor];
    loginButton.layer.borderWidth = 1.0;
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 5.0;
   
    
}
- (IBAction)buttonLogin:(id)sender {
    
   /* if ( ([[textfieldPhone text]length] ==0) ||
        ([[textfieldName text] length] ==0 ) ||
        ( [[textfieldEmail text] length] == 0)
        ) {
        
        [UIAlertView showErrorWithMessage:@"Fields cannot be empty! Please fill at the fields"
                                  handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                      
                                      NSLog(@"Error dismissed");
                                  }];
        return;
    } */
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
    IntegraHomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
    [self.navigationController pushViewController: homeVC animated:NO];
    
}

@end
