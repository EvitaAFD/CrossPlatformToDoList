//
//  InterfaceController.m
//  WatchKit-ToDoList Extension
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "InterfaceController.h"
#import "ToDo.h"
#import "ToDoRowController.h"
#import "DetailToDoInterfaceController.h"

@import WatchConnectivity;


@interface InterfaceController () <WCSessionDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *watchTable;

//strongly typed array, only contain to do items
@property(strong, nonatomic)NSArray <ToDo *> *allToDos;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    [self setUpTable];
}

-(void)setUpTable {
    [self.watchTable setNumberOfRows:self.allToDos.count withRowType:@"ToDoRowController"];
    
    for (NSInteger i =0; i < self.allToDos.count; i++) {
        
        ToDoRowController *rowController = [self.watchTable rowControllerAtIndex:i];
        
        [rowController.titleLabel setText:self.allToDos[i].title];
        [rowController.contentLabel setText:self.allToDos[i].content];
        
    }
}


-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    NSDictionary *toDoDictionary = @{@"title":self.allToDos[rowIndex].title, @"content":self.allToDos[rowIndex].content};
    
    [self pushControllerWithName:@"DetailToDoInterfaceController" context:toDoDictionary];
}

- (IBAction)newToDoPressed {
    
    NSArray *suggestions = @[@"Drink More Water", @"Pet Lola", @"Exercise"];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [[WCSession defaultSession] setDelegate:self];
    [[WCSession defaultSession] activateSession];
    
    [[WCSession defaultSession] sendMessage:@{} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        NSArray *toDoDictionaries = replyMessage[@"todos"];
        
        NSMutableArray *allToDos = [[NSMutableArray alloc] init];
        
        for (NSDictionary *toDoObject in toDoDictionaries) {
            
            ToDo *newToDo = [[ToDo alloc]init];
            newToDo.title =toDoObject[@"title"];
            newToDo.content = toDoObject[@"content"];
            //ADD OTHER CONTENT HERE
            
            [allToDos addObject:newToDo];
            
        }
        
        self.allToDos = allToDos.copy;
        [self setUpTable];
        
    } errorHandler:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error.localizedDescription);
        
        
    }];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
@end



