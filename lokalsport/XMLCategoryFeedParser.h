//
//  XMLNewsFeedParser.h
//  lokalsport
//
//  Created by Linus  Karlsson on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>


@class lokalsportAppDelegate, newsFeedXML;



@interface XMLCategoryFeedParser : NSObject<NSXMLParserDelegate>
{
    
    
    
    NSMutableString *currentElementValue;
    
    lokalsportAppDelegate *appDelegate;
    
    
    
    newsFeedXML *newsFXML;
    
    NSMutableArray  *category;
    
    
    
}

//@property (nonatomic, retain)categoriesXML *catXML;


@property (nonatomic, retain)newsFeedXML *newsFXML;

@property (nonatomic, retain)NSMutableArray *category;



-(XMLCategoryFeedParser *) initXMLCategoryFeedParser;

@end
