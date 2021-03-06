//
//  DetailToDoInterfaceController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "DetailToDoInterfaceController.h"
#import "ToDo.h"
#import "InterfaceController.h"

@interface DetailToDoInterfaceController ()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end

@implementation DetailToDoInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self.titleLabel setText:context[@"title"]];
    [self.contentLabel setText:context[@"content"]];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


@end



