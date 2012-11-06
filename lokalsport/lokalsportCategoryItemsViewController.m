//
//  lokalsportCategoryItemsViewController.m
//  lokalsport
//
//  Created by Linus  Karlsson on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lokalsportCategoryItemsViewController.h"
#import "newsItemViewController.h"
#import "lokalsportAppDelegate.h"
#import "newsFeedXML.h"
#import "categoryXML.h"
#import "XMLCategoryFeedParser.h"

@implementation lokalsportCategoryItemsViewController

@synthesize selectedItem, spinner,label;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Starts the shit

    @try {
        
        appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    }
    @catch (NSException *exception) {
        

    }
    @finally {
        
    }
    
    self.title = appDelegate.currentCategoryFeed;

   
    //Start the parsing
    [self startThingsUp:  [selectedItem intValue]];
    
}

- (void) startThingsUp: (NSInteger) selIndex{
    
    UIImage *cTop = [UIImage imageNamed:@"spinnerbgSquare.png"];
    //UIImage *cBot = [UIImage imageNamed:@"spinnerbgBottom.png"];
    
    
    
    //initiates the spinnerView
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.spinner.center=self.view.center;
    self.spinner.frame = CGRectMake(0, 0, 70,70);
    
    
    self.spinner.backgroundColor = [[UIColor blackColor] initWithPatternImage:cTop];
    
    // self.spinner.alpha = CGImageGetAlphaInfo(cRef);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    
    
    
    // self.label.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.0];
    
    
    
    [window addSubview:self.spinner];
    
    
    
    self.spinner.center = window.center;
    
    
    //Nollställer feeden
    appDelegate.categoryFeeds = nil;   
    
    //Gör hela view vit
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; 

    
    [self.spinner startAnimating];
    self.spinner.hidden = NO;
    
    //URL
    NSString *path = [[NSString alloc] initWithFormat:@"http://lokalsport.nu/index.php?view=category&id=%i&format=feed&type=lsfeed", selIndex];

    
    [self performSelectorInBackground:@selector(parseXMLFileAtURL:) withObject:path];
}

- (void) parseXMLFileAtURL:(NSString *)path {
    

    //do stuff
    NSURL *choosenCategoryUrl = [[NSURL alloc] initWithString:path];
    NSXMLParser *xmlCategoryFeedParser = [[NSXMLParser alloc] initWithContentsOfURL:choosenCategoryUrl];
    XMLCategoryFeedParser *parserCategoryFeed = [[XMLCategoryFeedParser alloc] initXMLCategoryFeedParser];
    [xmlCategoryFeedParser  setDelegate:(id)parserCategoryFeed];
    
    BOOL success1 = [xmlCategoryFeedParser  parse];
    
    if(success1)
    {

    }
    else
    {

    }
    
    [self performSelectorOnMainThread:@selector(doneParsing) withObject:nil waitUntilDone:NO];
}

- (void) doneParsing {

    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
 
    //Visa tableview-separatorerna igen
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine; 
    
    //Laddar in datan i tableView
    [self.tableView reloadData];    
    
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    
    
    return [[appDelegate.categoryFeeds objectForKey:appDelegate.currentCategoryFeed]count];
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
    
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    NSString *trimmedTitle = [[[[appDelegate.categoryFeeds objectForKey:appDelegate.currentCategoryFeed] objectAtIndex:indexPath.row] title]   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [cellLabel setText: trimmedTitle];    
    
    UILabel *cellLabel2 = (UILabel *)[cell viewWithTag:2];
    NSString *trimmedDescription = [[[[appDelegate.categoryFeeds objectForKey:appDelegate.currentCategoryFeed] objectAtIndex:indexPath.row]  pubDate]   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [cellLabel2 setText: trimmedDescription];
    
    return cell;
} 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"selectedCategoryItem"]) {
        
        newsItemViewController *vc = [segue destinationViewController];
        
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        
        [vc setSelectedItem: [[[appDelegate.categoryFeeds objectForKey:appDelegate.currentCategoryFeed] objectAtIndex: selectedIndex]link]];
        
        [vc setSelectedCategory: appDelegate.currentCategoryFeed];
    }
}

- (IBAction)refreshMethod:(id)senderId {
    
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    [self.spinner removeFromSuperview];
    [self startThingsUp:  [selectedItem intValue]];
    [self.tableView reloadData];
    
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
        [self.spinner removeFromSuperview]; 
	[super viewWillDisappear:animated];
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
