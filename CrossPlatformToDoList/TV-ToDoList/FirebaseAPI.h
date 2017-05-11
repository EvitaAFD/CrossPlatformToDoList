//
//  FirebaseAPI.h
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/10/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Todo.h"

typedef void(^AllTodosCompletion)(NSArray<ToDo *> *allTodos);

@interface FirebaseAPI : NSObject


+(void)fetchAllTodos:(AllTodosCompletion)completion;

@end



