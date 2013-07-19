//
//  Conversation.h
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NICellFactory.h"


@interface Conversation : NSManagedObject <NICellObject>

@property (nonatomic, retain) NSNumber * conversationID;
@property (nonatomic, retain) NSNumber * incompleteLocal;
@property (nonatomic, retain) NSDate * modifiedDate;
@property (nonatomic, retain) NSString * partnerName;
@property (nonatomic, retain) NSString * partnerTwitter;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSData * location;

@end
