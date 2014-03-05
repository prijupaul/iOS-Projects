//
//  IntegraLoginViewController.h
//  Integra
//
//  Created by Priju Jacob Paul on 21/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegraLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfieldName;
@property (weak, nonatomic) IBOutlet UITextField *textfieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textfieldPhone;
- (IBAction)buttonLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
