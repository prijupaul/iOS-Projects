//
//  IntegraSisterConcernViewController.m
//  Integra
//
//  Created by Priju Jacob Paul on 23/01/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "IntegraSisterConcernViewController.h"
#import "IntegraBrochuresViewController.h"

@interface IntegraSisterConcernViewController ()

@end

@implementation IntegraSisterConcernViewController

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
    
    NSString *imageFile = [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], @"logo"];
    UIImage *img = [UIImage imageWithContentsOfFile:imageFile];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    self.navigationItem.titleView = imgView;
    
    
    tableData = [NSArray arrayWithObjects:@"Solar",@"Mobile",@"Networking",@"..",@"...",nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"    Choose a sister concern";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if( cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showActionSheet:indexPath];
    
}

#pragma mark - ActionSheet

-(void) showActionSheet:(NSIndexPath*)sender {
    
    NSString* salesForms = @"Sales Forms";
    NSString* salesBrochures = @"Sales Brochures";
    UIActionSheet *actionSheets = [[UIActionSheet alloc]initWithTitle:@"Choose to view" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Close" otherButtonTitles :salesForms,salesBrochures,nil];
    [actionSheets setTag: [sender row]];
    [actionSheets showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:@"Cancel"]) {
        
    }
    else if([buttonTitle isEqualToString:@"Sales Forms"]) {
        
    }
    else if([buttonTitle isEqualToString:@"Sales Brochures"]){
        
       IntegraBrochuresViewController* brochure =  [self.storyboard instantiateViewControllerWithIdentifier:@"brochuresViewController"];
     
        brochure.contentSelected = [tableData objectAtIndex:[actionSheet tag]];
     
        [self presentViewController:brochure animated:YES completion:nil];
       
    }
    
}
@end
