//
//  categoriesXML.h
//  lokalsport
//
//  Created by Christian Ulf on 2012-04-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


/**********<>- Denna klass får alla olika sporter (INTE BLOGGAR) -<>***********/
#import <Foundation/Foundation.h>

@interface categoryXML : NSObject{


    
    //Elementens values
    NSString *name;
    NSString *info;
    NSString *cid;
    NSString *weight;
  
    

}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *info;
@property(nonatomic, retain) NSString *cid;
@property(nonatomic, retain) NSString *weight;


@end
