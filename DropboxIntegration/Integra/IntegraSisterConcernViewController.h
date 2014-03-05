//
//  IntegraSisterConcernViewController.h
//  Integra
//
//  Created by Priju Jacob Paul on 23/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegraSisterConcernViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    NSArray* tableData;
    
}

- (void) showActionSheet:(id)sender;

@end
