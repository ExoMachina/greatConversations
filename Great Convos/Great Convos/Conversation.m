//
//  Conversation.m
//  Great Convos
//
//  Created by Alexander List on 7/15/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "Conversation.h"
#import "GCConversationCell.h"

@implementation Conversation

@dynamic conversationID;
@dynamic incompleteLocal;
@dynamic modifiedDate;
@dynamic partnerName;
@dynamic partnerTwitter;
@dynamic subject;
@dynamic latitude;
@dynamic longitude;
@dynamic location;

- (Class)cellClass{
	return [GCConversationCell class];
}

-(void) awakeFromInsert{
	[super awakeFromInsert];
	
	[self setModifiedDate:[NSDate date]];
}

@end
