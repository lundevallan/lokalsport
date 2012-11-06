//
//  lokalsportSecondViewController.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lokalsportBlogViewController.h"
#import "newsItemViewController.h"
#import "lokalsportAppDelegate.h"
#import "categoryXML.h"
#import "lokalsportOneBlogViewController.h"

@implementation lokalsportBlogViewController

@synthesize Blogs;

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



-(void)checkIfEmpty{
    
    if ([appDelegate.categoriesBlog count] < 1) {
        
        [appDelegate downloadAndParse];
    }
    [self.tableView reloadData];
    
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.categoriesBlog count];
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

    
    NSString *trimmedName = [[ [appDelegate.categoriesBlog objectAtIndex:indexPath.row] name]
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    [cellLabel setText: trimmedName];
    
    
    NSString *trimmedInfo = [[ [appDelegate.categoriesBlog objectAtIndex:indexPath.row] info]
                             stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UILabel *cellLabel2 = (UILabel *)[cell viewWithTag:2];
    [cellLabel2 setText: trimmedInfo];
    
    return cell;
} 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([[segue identifier] isEqualToString:@"selectedBlogItem"]) {
        
        lokalsportOneBlogViewController *vc = [segue destinationViewController];
        
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        
        NSString *trimmedID = [[[appDelegate.categoriesBlog objectAtIndex:selectedIndex] cid]
                                         stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [vc setSelectedItem: trimmedID];

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
