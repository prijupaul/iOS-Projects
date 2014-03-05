//
//  IntegraSplashScreenViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 21/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraSplashScreenViewController.h"
#import "IntegraLoginViewController.h"

@implementation IntegraSplashScreenViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
    
    IntegraLoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];

    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds* NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = @"flip";
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        // code to be executed on the main queue after delay
        [self.navigationController pushViewController: loginVC animated:NO];
    });
}
@end
