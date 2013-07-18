//
//  GCConversationCell.h
//  Great Convos
//
//  Created by Alexander List on 7/18/13.
//  Copyright (c) 2013 ExoMachina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conversation.h"

@interface GCConversationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel * conversationLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailsLabel;


+ (CGFloat)heightForObject:(Conversation*)conversation atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
- (BOOL)shouldUpdateCellWithObject:(Conversation*)conversation;
@end
