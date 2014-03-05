//
//  IntegraBrochuresViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 4/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraBrochuresViewController.h"
#import "IntegraViewBrochureViewController.h"
#import "IntegraSisterConcernViewController.h"
#import "DirectoryUtils.h"
#import "AlertDialogUtils.h"

@interface IntegraBrochuresViewController () <DBRestClientDelegate> {
    NSInteger fileDownloadedCount;
}

@end

@implementation IntegraBrochuresViewController

@synthesize restClient;
@synthesize contentSelected;
@synthesize tableView;
@synthesize fileDetails;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void) viewWillAppear:(BOOL)animated {
    
    self.title = @"Brochures";
    
    NSString *imageFile = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], @"logo"];
    UIImage *img = [UIImage imageWithContentsOfFile:imageFile];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    self.navigationItem.titleView = imgView;


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Sync" style:UIBarButtonItemStylePlain
                                              target:self action:@selector(didSyncPressed)];

    fileDetails = [[NSMutableArray alloc]init];
    fileDetails = [[DirectoryUtils getListOfDirectoriesUnder:contentSelected]mutableCopy];
   
}

-(IBAction)didSyncPressed{
  
    
    
    [fileDetails removeAllObjects];
    fileDetails = [[NSMutableArray alloc]init];
    [self.tableView reloadData];
    
    if (![[DBSession sharedSession] isLinked]) {
       [[DBSession sharedSession] linkFromController:self];
    }
    else{
         [self showMetadataProgressWithLabel:self];
        [[self restClient]loadMetadata:[NSString stringWithFormat:@"/Integra/%@",contentSelected]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(DBRestClient*) restClient{
    if (! restClient) {
        restClient = [[DBRestClient alloc]initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

-(void)showFolders{
    if (![DirectoryUtils doesDirectoryExist:contentSelected]) {
        [DirectoryUtils createDirectoryWithName:contentSelected];
    }
    
    [[self restClient]loadMetadata:[NSString stringWithFormat:@"/Integra/%@",contentSelected]];
    
}

- (IBAction)onBack:(id)sender {
    [self removeProgress];
    IntegraSisterConcernViewController* sisterViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"sisterconcernsviewcontroller"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:sisterViewController];
   
    [self presentViewController:navigationController animated:YES completion:nil];

}

-(void) restClient:(DBRestClient*)client loadedMetadata:(DBMetadata *)metadata {
    
    [self removeProgress];
    [self showDownloadingProgressWithLabel:self];
    
    NSLog(@"Folder '%@' contains: ",metadata.path);
    [DirectoryUtils deleteFilesUnderFolder:contentSelected];
    
    if (![DirectoryUtils doesDirectoryExist:contentSelected]) {
        [DirectoryUtils createDirectoryWithName:contentSelected];
    }
    
    
    for (DBMetadata* file in metadata.contents) {
        NSLog(@"  %@", file.filename);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",contentSelected,file.filename]];
        
        [[self restClient]loadFile:file.path intoPath:dataPath];
        
            [fileDetails addObject:file.filename];
        
        }
    NSLog(@"fileDetails count after downloading: %d",[fileDetails count]);
    fileDownloadedCount = [fileDetails count];
    [self.tableView reloadData];
    
    if(fileDownloadedCount ==0) {
        [self removeProgress];
    }
}

+ (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(void) restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError *)error{
    
    [self removeProgress];
    
    NSString* errorDesc = [NSString stringWithFormat:@"Error during loading. \n Error description: %@. \n Please try again!!",error.description];
    NSLog(@"Error loading metadata: %@", [error description]);
    [UIAlertView showWithTitle:@"Integra"
                                 message:errorDesc
                                 handler:nil];
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath
       contentType:(NSString*)contentType metadata:(DBMetadata*)metadata {
    
    NSLog(@"File loaded into path: %@", localPath);
    
    fileDownloadedCount -- ;
    
    if(fileDownloadedCount == 0) {
        [self removeProgress];
        
        NSString* message = [NSString stringWithFormat:@"Downloaded files!"];
        [UIAlertView showWithTitle:@"Integra"
                           message:message
                           handler:nil];
    }
    
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    NSLog(@"There was an error loading the file - %@", error);
    
    fileDownloadedCount -- ;
    
    NSString* errorDesc = [NSString stringWithFormat:@"Loading file failed. \n Error description: %@. \n Please try again!!",error.description];
    NSLog(@"Error loading metadata: %@", [error description]);
    [UIAlertView showWithTitle:@"Integra"
                       message:errorDesc
                       handler:nil];
    
    if (fileDownloadedCount ==0){
        [self removeProgress];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fileDetails count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"    %@", contentSelected;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = [fileDetails objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",contentSelected,[fileDetails objectAtIndex:[indexPath row]]]];
    
    IntegraViewBrochureViewController * brochure =  [self.storyboard instantiateViewControllerWithIdentifier:@"webview"];
    
    brochure.fullPath = dataPath;
    brochure.contentsName = contentSelected;
    
    [self presentViewController:brochure animated:YES completion:nil];
    
}

- (void)showMetadataProgressWithLabel:(id)sender {
	
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Retrieving metadata..Please wait..";
	[HUD show:YES];
}

- (void)showDownloadingProgressWithLabel:(id)sender {
	
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
	
	HUD.delegate = self;
	HUD.labelText = @"Downloading files..Please wait..";
	[HUD show:YES];
}

-(void) removeProgress {
    [HUD removeFromSuperview];
   
}

@end
