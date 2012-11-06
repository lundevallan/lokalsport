//
//  XMLBlogFeedParser.m
//  lokalsport
//
//  Created by Linus  Karlsson on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLBlogFeedParser.h"
#import "lokalsportAppDelegate.h"
#import "newsFeedXML.h"

@implementation XMLBlogFeedParser

@synthesize newsFXML;

- (XMLBlogFeedParser *) initXMLBlogFeedParser {
    
    self = [super init];
    
    appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return self;
}

//Denna går om något går fel i parsern
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nätverksproblem" message:@"Försök igen genom att trycka på uppdatera." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"items"]) {
        
        //Initialize the array.
        appDelegate.currentBlogNewsFeed = [[NSMutableArray alloc] init];
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
            
            
            
            [appDelegate.currentBlogNewsFeed addObject:newsFXML];
            
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
