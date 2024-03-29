//
//  AlertDialogUtils.h
//  Integra
//
//  Created by Priju Jacob Paul on 22/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 * Completion handler invoked when user taps a button.
 *
 * @param alertView The alert view being shown.
 * @param buttonIndex The index of the button tapped.
 */
typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex);

/**
 * Category of `UIAlertView` that offers a completion handler to listen to interaction. This avoids the need of the implementation of the delegate pattern.
 *
 * @warning Completion handler: Invoked when user taps a button.
 *
 * typedef void(^UIAlertViewHandler)(UIAlertView *alertView, NSInteger buttonIndex);
 *
 * - *alertView* The alert view being shown.
 * - *buttonIndex* The index of the button tapped.
 */
@interface UIAlertView (Blocks)

/**
 * Shows the receiver alert with the given handler.
 *
 * @param handler The handler that will be invoked in user interaction.
 */
- (void)showWithHandler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with a title, a message and a button to dimiss.
 *
 * @param title The title of the alert.
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
              handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with an "Error" title, a message and a button to dimiss.
 *
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showErrorWithMessage:(NSString *)message
                     handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show an alert with a "Warning" title, a message and a button to dimiss.
 *
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showWarningWithMessage:(NSString *)message
                       handler:(UIAlertViewHandler)handler;

/**
 * Utility selector to show a confirmation dialog with a title, a message and two buttons to accept or cancel.
 *
 * @param title The title of the alert.
 * @param message The message to show in the alert.
 * @param handler The handler that will be invoked in user interaction.
 */
+ (void)showConfirmationDialogWithTitle:(NSString *)title
                                message:(NSString *)message
                                handler:(UIAlertViewHandler)handler;

@end
