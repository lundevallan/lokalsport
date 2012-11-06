//
//  XMLNewsFeedParser.m
//  lokalsport
//
//  Created by Linus  Karlsson on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//http://linuskarlsson.se/joomla-lokalsporttest/index.php?format=feed&type=lsfeed

/*
 NSString *title;
 NSString *link;
 NSString *guid;
 NSString *image;
 NSString *description;
 NSString *author;
 NSString *category;
 NSString *pubDate;
 */


#import "XMLNewsFeedParser.h"
#import "lokalsportAppDelegate.h"
#import "newsFeedXML.h"

@implementation XMLNewsFeedParser

@synthesize newsFXML;


- (XMLNewsFeedParser *) initXMLNewsFeedParser {
    
    self = [super init];
    
    appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return self;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{



}
//Denna går om något går fel i parsern
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{


    appDelegate.newsFeed = [[NSMutableArray alloc] init];
    newsFeedXML *nf = [[newsFeedXML alloc] init];
    [nf setTitle:@"Inga nyheter hämtades..."];
    [nf setPubDate:@"Uppdatera för att hämta igen"];
    
    [appDelegate.newsFeed addObject:nf]; 

    [parser abortParsing];
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"items"]) {
        
        appDelegate.newsFeed = [[NSMutableArray alloc] init];
     
    }
    else if([elementName isEqualToString:@"item"]) {
        
        //Initialize the book.
        
        newsFXML = [[newsFeedXML alloc] init];
    }
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(!currentElementValue)
    {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    }
    else
    {
        [currentElementValue appendString:string];
    }
    
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
 
        @try {
            
            if([elementName isEqualToString:@"items"])
            {
                return;
            }
            //There is nothing to do if we encounter the Books element here.
            //If we encounter the Book element howevere, we want to add the book object to the array
            // and release the object.
            if([elementName isEqualToString:@"item"]) {
                
                
                
                [appDelegate.newsFeed addObject:newsFXML];
                
                newsFXML = nil;
            }
            else{
                
                [newsFXML setValue:currentElementValue forKey:elementName];
                
                currentElementValue = nil;
            }  
            
        }
        @catch (NSException *exception) {
            

        }
        @finally {
            
        }
}


@end
