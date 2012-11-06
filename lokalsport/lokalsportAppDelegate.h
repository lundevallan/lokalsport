//
//  lokalsportAppDelegate.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/*
 Bugs
 
 1. Spinnern kommer upp på olika positioner.
 2. webview vill inte rotera som jag vill rotera
 3.
 
 Error
 
 1. Newsfeeden updateras inte.
 
 
 
 */

#import <UIKit/UIKit.h>




@interface lokalsportAppDelegate : UIResponder <UIApplicationDelegate,NSXMLParserDelegate>{
    
    //Alla olika sportkategorier
    NSMutableArray *categories;
    
    
    //De olika bloggarna
    NSMutableArray *categoriesBlog;
    
    //Håller den just valda bloggens poster
    NSMutableArray *currentBlogNewsFeed;
    
    //Förstasidans-feed
    NSMutableArray *newsFeed;
    NSMutableArray *oldNewsFeed;
    
    //Olika katerogiernas sparade feeds
    NSMutableDictionary *categoryFeeds;
    
    
    //Den valda sporten/kategorin
    NSString *currentCategoryFeed;
    
    //Internet finnt 
    BOOL internet; 
}


@property (nonatomic, assign) BOOL internet;

@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic, retain) NSMutableArray *categoriesBlog;

@property (nonatomic, retain) NSMutableArray *currentBlogNewsFeed;

//Förstasidans-feed
@property (nonatomic, retain) NSMutableArray *newsFeed;
@property (nonatomic, retain) NSMutableArray *oldNewsFeed;

//Kategorierna feeds
@property (nonatomic, retain) NSMutableDictionary *categoryFeeds;
@property (nonatomic, retain) NSString *currentCategoryFeed;



@property (strong, nonatomic) UIWindow *window;

-(void)downloadAndParse;

@end
