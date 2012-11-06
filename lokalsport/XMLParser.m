//
//  XMLParser.m
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "lokalsportAppDelegate.h"
#import "categoryXML.h"


BOOL blogOrNot = NO;

@implementation XMLParser 

@synthesize catXML;



- (XMLParser *) initXMLParser {
    
    self = [super init];
    
    appDelegate = (lokalsportAppDelegate *)[[UIApplication sharedApplication] delegate];

    return self;
}

//Denna går om något går fel i parsern
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    appDelegate.categories = [[NSMutableArray alloc] init];
  
    [parser abortParsing];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString:@"sports"]) {
        

        //Initialize the array.
        appDelegate.categories = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"category"]) {
        
        //Initialize the book.
        
        catXML = [[categoryXML alloc] init];
        
        

    }
    
    
    //Check if encountered sport or blogs
    if([elementName isEqualToString:@"sports"])
    {
        
    }
    if([elementName isEqualToString:@"blogs"])
    {
        blogOrNot = YES;
       appDelegate.categoriesBlog = [[NSMutableArray alloc] init];
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
    
    if (!blogOrNot)
    {
        
  
    
    
    @try {

    if([elementName isEqualToString:@"sports"])
    {
        return;
    }
    //There is nothing to do if we encounter the Books element here.
    //If we encounter the Book element howevere, we want to add the book object to the array
    // and release the object.
    if([elementName isEqualToString:@"category"]) {
        
        
        [appDelegate.categories addObject:catXML];
        
        catXML = nil;
    }
    else{
        
        [catXML setValue:currentElementValue forKey:elementName];

        currentElementValue = nil;
    }
    


        
    }
    @catch (NSException *exception) {
        

    }
    @finally {
        
    }
  }  
else
{

    
    @try {
        
        if([elementName isEqualToString:@"sports"])
        {
            return;
        }
        //There is nothing to do if we encounter the Books element here.
        //If we encounter the Book element howevere, we want to add the book object to the array
        // and release the object.
        if([elementName isEqualToString:@"category"]) {
            
            
            [appDelegate.categoriesBlog addObject:catXML];
            
            catXML = nil;
        }
        else{
            
            [catXML setValue:currentElementValue forKey:elementName];
            
            currentElementValue = nil;
        }
        
        
        
        
    }
    @catch (NSException *exception) {
        
      
    }
    @finally {
        
    }




}
  
}


@end
