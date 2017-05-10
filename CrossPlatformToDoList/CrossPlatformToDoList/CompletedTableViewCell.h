//
//  CompletedTableViewCell.h
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
