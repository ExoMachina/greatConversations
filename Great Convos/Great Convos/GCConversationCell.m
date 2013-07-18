//
//  GCConversationCell.m
//  Great Convos
//
//  Created by Alexander List on 7/18/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import "GCConversationCell.h"

@implementation GCConversationCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	
	UINib * nib = [self viewNib];
	if ((self = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0])){

	}
	return self;
}

-(UINib*) viewNib{
	return [UINib nibWithNibName:@"GCConversationCell-iPhone" bundle:[NSBundle mainBundle]];
}

- (BOOL)shouldUpdateCellWithObject:(Conversation*)conversation{
	[self.conversationLabel setText:[conversation subject]];
	
	NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterFullStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setLocale:[NSLocale currentLocale]];
	[dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	
	NSString * partnerName = @"someone";
	if ([conversation.partnerName length] >0){
		partnerName = conversation.partnerName;
	}
	else if ([conversation.partnerTwitter length] >0){
		partnerName = conversation.partnerTwitter;
	}
	
	NSString * detailString = [NSString stringWithFormat:@"with %@ on %@", partnerName, [dateFormatter stringFromDate:conversation.modifiedDate]];
	[self.detailsLabel setText:detailString];

	
	return TRUE;
}

+ (CGFloat)heightForObject:(Conversation*)conversation atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView{
	return 107;
}

@end