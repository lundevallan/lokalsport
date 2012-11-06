//
//  newsItemViewController.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newsItemViewController.h"


@implementation newsItemViewController 

@synthesize selectedItem, selectedIndex, selectedCategory, webView, spinner,interceptLinks,label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  
                    
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




    //[webView setDelegate:newsItemViewController];

    
    if(selectedCategory == nil){
    self.title= @"Nyheter";
    }
    else {
    self.title = selectedCategory;
    }
    //self.navigationItem.prompt = @"Tap image for more options.";

    

    
    NSString *trimmedUrl = [selectedItem stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSURL *url = [NSURL URLWithString: trimmedUrl];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
    [super viewDidLoad];
}


- (void)viewWillDisappear:(BOOL)animated
{

    [self.spinner removeFromSuperview];

}

- (void)viewDidUnload

{
    
    

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

 
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{


}

-(void)webViewDidStartLoad:(UIWebView *)webView {

	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
       [self.spinner startAnimating];
    self.spinner.hidden = NO;

 
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
   
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //If körs om man redan har en sida inladdad
    if (self.interceptLinks) {
        NSURL *url = request.URL;
        //Denna startar safari
        [[UIApplication sharedApplication] openURL:url];   
        return NO;
    }
    //In hit går första requesten
    else {
        self.interceptLinks = TRUE;
        return YES;
    }
}




@end
