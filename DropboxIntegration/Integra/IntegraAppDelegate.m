//
//  IntegraAppDelegate.m
//  Integra
//
//  Created by Priju Jacob Paul on 21/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraAppDelegate.h"
#import "IntegraBrochuresViewController.h"
#import <UIKit/UIKit.h>

@interface IntegraAppDelegate() <DBSessionDelegate, DBNetworkRequestDelegate>


@end

@implementation IntegraAppDelegate

@synthesize brochureViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor brownColor]];
    
    NSString* appKey = @"9idn4eqptsst6qe";
    NSString* appSecret = @"zt5el8t2ogew9fs";
    NSString *root = kDBRootDropbox;
    
     DBSession* session = [[DBSession alloc]initWithAppKey:appKey appSecret:appSecret root:root];
    [DBSession setSharedSession:session];
    [DBRequest setNetworkRequestDelegate:self];
  //  [[DBSession sharedSession]unlinkAll];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation NS_AVAILABLE_IOS(4_2) {
    
    if ([[DBSession sharedSession] handleOpenURL:url]) {
		if ([[DBSession sharedSession] isLinked]) {
			UINavigationController* navigationController = ((UINavigationController*)self.window.rootViewController);
            IntegraBrochuresViewController* currentViewController = (IntegraBrochuresViewController*)navigationController.visibleViewController;
             [currentViewController showFolders];
		}
        
		return YES;
	}
	
	return NO;
    
}

#pragma mark -
#pragma mark DBSessionDelegate methods

- (void)sessionDidReceiveAuthorizationFailure:(DBSession*)session userId:(NSString *)userId {
	relinkUserId = userId;
	[[[UIAlertView alloc]
	   initWithTitle:@"Dropbox Session Ended" message:@"Do you want to relink?" delegate:self
	   cancelButtonTitle:@"Cancel" otherButtonTitles:@"Relink", nil]
	 show];
}


#pragma mark -
#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
	if (index != alertView.cancelButtonIndex) {
        
        UINavigationController* navigationController = ((UINavigationController*)self.window.rootViewController);
        IntegraBrochuresViewController* currentViewController = (IntegraBrochuresViewController*)navigationController.visibleViewController;

		[[DBSession sharedSession] linkUserId:relinkUserId fromController:currentViewController];
	}
	
	relinkUserId = nil;
}


#pragma mark -
#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
	outstandingRequests++;
	if (outstandingRequests == 1) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
}

- (void)networkRequestStopped {
	outstandingRequests--;
	if (outstandingRequests == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}
@end
