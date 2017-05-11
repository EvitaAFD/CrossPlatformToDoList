//
//  ToDo.h
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property(strong, nonatomic)NSString *title;
@property(strong,nonatomic)NSString *content;
@property(strong,nonatomic)NSString *key;
@property(strong,nonatomic)NSNumber *completed;
@property(strong, nonatomic)NSString *email;

- (instancetype)initWithTitle:(NSString *)title withContent:(NSString *)content withKey:(NSString *)key completed:(NSNumber *)completed andEmail:(NSString *)email;

-(instancetype)initWithDictionary:(NSDictionary *)jsonDictionary;



@end
