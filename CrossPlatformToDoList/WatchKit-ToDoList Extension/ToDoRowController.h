//
//  ToDoRowController.h
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Foundation/Foundation.h>

@import WatchKit;

@interface ToDoRowController : NSObject
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;


@end
