//
//  lokalsportCategoriesVIewController.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lokalsportCategoriesViewController.h"
#import "newsItemViewController.h"
#import "lokalsportAppDelegate.h"
#import "categoryXML.h"
#import "XMLCategoryFeedParser.h"

@implementation lokalsportCategoriesViewController

@synthesize activityIndicator,spinner;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @try {
        appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate]; 
        
   
    }
    @catch (NSException *exception) {
       
    }
    @finally {
        
    }
    
    
    [self checkIfEmpty];

    
    
    
   // Do any additional setup after loading the view, typically from a nib.
}

//Laddar in xml om det inte är laddat.
-(void)checkIfEmpty{

    if ([appDelegate.categories count] < 1) {
        [appDelegate downloadAndParse];
    }
    [self.tableView reloadData];
}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.categories count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:CellIdentifier];
    }
    
    
    
    NSString *trimmedName = [[ [appDelegate.categories objectAtIndex:indexPath.row] name]
                           stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    

    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    [cellLabel setText: trimmedName];
    
    
    NSString *trimmedID = [[ [appDelegate.categories objectAtIndex:indexPath.row] cid]
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UILabel *cellLabel2 = (UILabel *)[cell viewWithTag:2];
    [cellLabel2 setText:trimmedID];

    return cell;
} 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Set the current category
    NSUInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
    
    NSString *trimmedName = [[ [appDelegate.categories objectAtIndex:selectedIndex] name]
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    appDelegate.currentCategoryFeed = trimmedName;
  
    if ([[segue identifier] isEqualToString:@"selectedCategory"]) {
        
        newsItemViewController *vc = [segue destinationViewController];
    
        NSString *trimmedID = [[[appDelegate.categories objectAtIndex:selectedIndex] cid]
                                        stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        [vc setSelectedItem:trimmedID];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self checkIfEmpty];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
