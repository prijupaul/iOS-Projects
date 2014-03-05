//
//  IntegraViewBrochureViewController.h
//  Integra
//
//  Created by Priju Jacob Paul on 11/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IntegraViewBrochureViewController : UIViewController {
    
}
@property (strong, nonatomic) IBOutlet UIWebView *webView;
- (IBAction) onBackPressed:(id)sender;


@property(strong,nonatomic)NSString *fullPath;
@property(strong,nonatomic)NSString *contentsName;
@end
