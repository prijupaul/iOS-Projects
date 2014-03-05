//
//  IntegraHomeViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 22/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraHomeViewController.h"

@interface IntegraHomeViewController ()

@end

@implementation IntegraHomeViewController

@synthesize integraHome;
@synthesize integraSales;
@synthesize integraSupport;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // add image
    NSString *imageFile = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], @"logo"];
    UIImage *img = [UIImage imageWithContentsOfFile:imageFile];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    self.navigationItem.titleView = imgView;
    
    
    
    [integraSupport setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    integraSupport.backgroundColor = [UIColor brownColor];
    integraSupport.layer.borderWidth = 1.0;
    integraSupport.layer.masksToBounds = YES;
    integraSupport.layer.cornerRadius = 5.0;
   
    
    [integraSales setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    integraSales.backgroundColor = [UIColor brownColor];
    integraSales.layer.borderWidth = 1.0;
    integraSales.layer.masksToBounds = YES;
    integraSales.layer.cornerRadius = 5.0;
   
    
    [integraHome setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    integraHome.backgroundColor = [UIColor brownColor];
    integraHome.layer.borderWidth = 1.0;
    integraHome.layer.masksToBounds = YES;
    integraHome.layer.cornerRadius = 5.0;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
