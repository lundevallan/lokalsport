//
//  lokalsportNewsFeedController.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "lokalsportNewsFeedViewController.h"
#import "newsItemViewController.h"
#import "lokalsportAppDelegate.h"
#import "newsFeedXML.h"
#import "XMLNewsFeedParser.h"




@implementation lokalsportNewsFeedViewController


@synthesize News, spinner, updateIsHappening;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.spinner.hidden = YES;
    
    @try {
        appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate]; 
    }
    @catch (NSException *exception) {
        
   
    }
    @finally {
        
    }
    
    //Hämtar om det inte lyckades
    if([appDelegate.newsFeed count]==1){
        
       
        [self refreshMethod];
        [appDelegate downloadAndParse];

    }
    
    
    //Fixar bakgrunden
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

    updateIsHappening = NO;
    
    
   
}


- (IBAction)refreshMethod:(id)senderId {
    

    
    if (!updateIsHappening)
    {
        [self refreshMethod];
    }
        updateIsHappening = YES;
    
   }

-(void)refreshMethod{
    
    //Gör så att inte flera spinners syns samtidigt
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    
        //Sparar undan feeden så vi kan jämföra den gamla med den nya
    appDelegate.oldNewsFeed = [[NSMutableArray alloc] initWithArray: appDelegate.newsFeed];
    appDelegate.newsFeed = nil;
        
    [self startThingsUp];
    [self.tableView reloadData];
}


- (void) startThingsUp {
    
    [self.spinner startAnimating];
    self.spinner.hidden = NO;
    
    //Scrollar tillbaka min tableview vid reload.
    if([appDelegate.newsFeed count] >0)
    {
        NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        [[self tableView] scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
        
      
    
    //Url
    NSString *path = @"http://lokalsport.nu/index.php?format=feed&type=lsfeed";
    [self performSelectorInBackground:@selector(parseXMLFileAtURL:) withObject:path];
}

- (void) parseXMLFileAtURL:(NSString *)path {
    
  
    NSURL *newsFeedUrl = [[NSURL alloc] initWithString:path];
     NSXMLParser *xmlNewsFeedParserFromClass = [[NSXMLParser alloc] initWithContentsOfURL:newsFeedUrl];
    XMLNewsFeedParser *parserNFFromClass = [[XMLNewsFeedParser alloc] initXMLNewsFeedParser];
    
    [xmlNewsFeedParserFromClass  setDelegate:(id)parserNFFromClass];
    
    
    BOOL success1 = [xmlNewsFeedParserFromClass  parse];
    
    if(success1)
    {
    
    }
    else
    {
   
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nätverksproblem" message:@"Nyheterna kunde inte hämtas" delegate:self cancelButtonTitle:@"Försök igen" otherButtonTitles: nil];
        [alert show];
    }
    
    [self performSelectorOnMainThread:@selector(doneParsing) withObject:nil waitUntilDone:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self refreshMethod];
    
}

- (void) doneParsing {
    
    
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
    
    
    if ([appDelegate.newsFeed count]>1)
    {
    
    [self.tableView reloadData];
    
    }
    //Med dessa rader kan jag färga celler som innehåller nya nyheter.
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {.91, .91, .91, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    
    NSUInteger  mySection = 0;
    NSUInteger numberOfNewNews = 0;
    
    NSString *oldTitle =[ [NSString alloc]initWithString: [[appDelegate.oldNewsFeed objectAtIndex:0] title] ];
    
    for (int i = 0; i < ([appDelegate.newsFeed count])  ; i++) {
        
        NSString *newTitle =[ [NSString alloc]initWithString: [[appDelegate.newsFeed objectAtIndex:i] title] ];

        if([oldTitle isEqualToString:newTitle])
        {
            break;
        }
        else {
              numberOfNewNews++;
        }
    }
    
    for (int i=0; i < numberOfNewNews; i++) {

        NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:i  inSection:mySection]; 
        UITableViewCell* myCell = [self.tableView  cellForRowAtIndexPath:myIndexPath];
        myCell.backgroundColor = [UIColor colorWithCGColor:color];
    }
    
     theTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                              target:self 
                                            selector:@selector(allWhite) 
                                            userInfo:nil 
                                             repeats:NO];
    
    
    updateIsHappening = NO;
}

//Gör allt till vitt igen
-(void)allWhite{
    NSUInteger  mySection = 0;

    for (int i=0; i<[appDelegate.newsFeed count]; i++) {
        
        NSIndexPath *myIndexPath =[NSIndexPath indexPathForRow:i  inSection:mySection]; 
        UITableViewCell* myCell = [self.tableView  cellForRowAtIndexPath:myIndexPath];
        myCell.backgroundColor = [UIColor whiteColor];
    }
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [appDelegate.newsFeed count];
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
     NSString *trimmedTitle = [[[appDelegate.newsFeed objectAtIndex:indexPath.row] title]   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [cellLabel setText: trimmedTitle];    
    
    UILabel *cellLabel2 = (UILabel *)[cell viewWithTag:2];
    NSString *trimmedDescription = [[[appDelegate.newsFeed objectAtIndex:indexPath.row] pubDate]   stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [cellLabel2 setText: trimmedDescription];

     return cell;
    
} 


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
     spinner.hidden = YES;
    if ([[segue identifier] isEqualToString:@"selectedItem"]) {
        
        newsItemViewController *vc = [segue destinationViewController];
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        
        [vc setSelectedItem: [[appDelegate.newsFeed objectAtIndex:selectedIndex] link]];
        [vc setSelectedIndex:selectedIndex];
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
      
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
