//
//  lokalsportAppDelegate.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lokalsportAppDelegate.h"
#import "XMLParser.h"
#import "lokalsportNewsFeedController.h"
#import "XMLNewsFeedParser.h"
#import "lokalsportNewsFeedViewController.h"


#import "Reachability.h"

@interface lokalsportAppDelegate (private) 

-(void)reachabilityChanged:(NSNotification*)note;

@end


@implementation lokalsportAppDelegate


@synthesize window = _window, categories, categoriesBlog, newsFeed, categoryFeeds, currentCategoryFeed, currentBlogNewsFeed, oldNewsFeed, internet;


-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {    
        internet = YES;
    }
    else
    {
        internet = NO;
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self downloadAndParse];
    
    internet = YES;
    
    //en notifikationsfångare
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(reachabilityChanged:) 
                                                 name:kReachabilityChangedNotification 
                                               object:nil];
    
    
    //Här nedan gör det så att man alltid får notifikation om internet försvinner eller kommer igång igen.
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.lokalsport.nu"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            internet = YES;
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            internet = NO;
        });
    };
    
   [reach startNotifier];

  
    //Initierar categoryfeeds dictionary...
    categoryFeeds = [[NSMutableDictionary alloc] init];

    return YES;
}

-(void)downloadAndParse{

    //laddar in xml-feeden för startsidan.
    NSURL *newsFeedUrl = [[NSURL alloc] initWithString:@"http://lokalsport.nu/index.php?format=feed&type=lsfeed"];    
    NSXMLParser *xmlNewsFeedParser = [[NSXMLParser alloc] initWithContentsOfURL:newsFeedUrl];
    
    XMLNewsFeedParser *parserNF = [[XMLNewsFeedParser alloc] initXMLNewsFeedParser];
    
    [xmlNewsFeedParser  setDelegate:(id)parserNF];
    
    BOOL success1 = [xmlNewsFeedParser parse];
   
    
    //Laddar in xml filen för kategorierna och bloggarna.
    NSURL *url = [[NSURL alloc] initWithString:@"http://lokalsport.nu/mobilapp/feedinfo.xml"];
    
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    [xmlParser setDelegate:(id)parser];
    BOOL success = [xmlParser parse];
    
    
    if (success1 && success)
    {

    }
    else
    {

    }
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
