//
//  IntegraAppDelegate.h
//  Integra
//
//  Created by Priju Jacob Paul on 21/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "IntegraBrochuresViewController.h"

@interface IntegraAppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *relinkUserId;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,retain) IBOutlet IntegraBrochuresViewController* brochureViewController;

@end
