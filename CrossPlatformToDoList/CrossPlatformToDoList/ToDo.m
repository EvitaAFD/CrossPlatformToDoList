//
//  ToDo.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content withKey:(NSString *)key andCompleted:(NSNumber *)completed{
    
    self = [super init];
 
    if (self) {
        _title = title;
        _content = content;
        _key = key;
        _completed = @0;
        
    }
    
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)jsonDictionary {
    self = [super init];
    
    if (self) {
        _title = jsonDictionary[@"title"];
        _content = jsonDictionary[@"content"];
        _key = jsonDictionary[@"key"];
        _completed = jsonDictionary[@"completed"];
        
    }
    return self;
}

@end
