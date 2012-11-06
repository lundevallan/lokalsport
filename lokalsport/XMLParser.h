//
//  XMLParser.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class lokalsportAppDelegate, categoryXML;

@interface XMLParser : NSObject<NSXMLParserDelegate> {

    NSMutableString *currentElementValue;
    lokalsportAppDelegate *appDelegate;
    categoryXML *catXML;
    
}

@property (nonatomic, retain)categoryXML *catXML;

-(XMLParser *) initXMLParser;

@end
