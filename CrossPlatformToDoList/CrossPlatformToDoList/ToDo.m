//
//  ToDo.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content {
 
    self.title = title;
    self.content = content;
    
    return self;
}

@end
