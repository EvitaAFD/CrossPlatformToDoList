//
//  ToDo.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo

- (instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content withKey:(NSString *)key completed:(NSNumber *)completed andEmail:(NSString *)email{
    
    self = [super init];
 
    if (self) {
        _title = title;
        _content = content;
        _key = key;
        _completed = @0;
        _email = email;
        
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
        _email = jsonDictionary[@"email"];
        
    }
    return self;
}

@end
