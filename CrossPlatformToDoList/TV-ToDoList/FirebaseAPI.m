//
//  FirebaseAPI.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/10/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"
#import "ToDo.h"


@implementation FirebaseAPI


+(void)fetchAllTodos:(AllTodosCompletion)completion {

    NSString *urlString = [NSString stringWithFormat:@"https://crossplatformtodolist-821fe.firebaseio.com/users.json?auth=%@", APP_KEY];
                       
    NSURL *databaseURL = [NSURL URLWithString:urlString];
                           
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
    NSLog(@"ROOT OBEJCT:%@", rootObject);
        
    NSMutableArray *allToDos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *userToDosDictionary in [rootObject allValues]) {
            NSArray *userToDos = [userToDosDictionary[@"todos"] allValues];
            
            for (NSDictionary *toDoDictionary in userToDos) {
                ToDo *newToDo = [[ToDo alloc]init];
                newToDo.title = toDoDictionary[@"title"];
                newToDo.content = toDoDictionary[@"content"];
                //assign other to do properties here
                
                [allToDos addObject:newToDo];
            
            
            }
        }
        
        if (completion) {
            completion(allToDos);
        }
        
    }] resume];

}

@end
