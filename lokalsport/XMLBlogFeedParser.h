//
//  XMLBlogFeedParser.h
//  lokalsport
//
//  Created by Linus  Karlsson on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class lokalsportAppDelegate, newsFeedXML;

@interface XMLBlogFeedParser : NSObject<NSXMLParserDelegate>
{
    
    
    
    NSMutableString *currentElementValue;
    
    lokalsportAppDelegate *appDelegate;
    
    
    
    newsFeedXML *newsFXML;
    
    
    
}

//@property (nonatomic, retain)categoriesXML *catXML;


@property (nonatomic, retain)newsFeedXML *newsFXML;



-(XMLBlogFeedParser *) initXMLBlogFeedParser;

@end
