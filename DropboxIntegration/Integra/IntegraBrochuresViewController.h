//
//  IntegraBrochuresViewController.h
//  Integra
//
//  Created by Priju Jacob Paul on 4/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DropboxSDK/DropboxSDK.h>
#import "MBProgressHUD.h"

@interface IntegraBrochuresViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@property(retain)NSMutableArray* fileDetails;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,readonly) DBRestClient* restClient;
@property(nonatomic,strong) NSString* contentSelected;

-(void)showFolders;
- (IBAction)onBack:(id)sender;
- (void) showMetadataProgressWithLabel:(id)sender;
-(void) showDownloadingProgressWithLabel:(id)sender;

- (void) removeProgress;

@end
