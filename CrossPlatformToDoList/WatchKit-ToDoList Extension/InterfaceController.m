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


@interface InterfaceController ()

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

-(NSArray<ToDo *> *)allToDos {
    ToDo *firstToDo = [[ToDo alloc]init];
    firstToDo.title = @"First To Do";
    firstToDo.content = @"To do stuff";
    
    ToDo *secondToDo = [[ToDo alloc]init];
    secondToDo.title = @"Second To Do";
    secondToDo.content = @"To do more stuff";
    
    ToDo *thirdToDo = [[ToDo alloc]init];
    thirdToDo.title = @"ThirdTo Do";
    thirdToDo.content = @"Oh no another to do";
    
    return @[firstToDo, secondToDo, thirdToDo];
    

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {

    
}

- (IBAction)newToDoPressed {
    
    NSArray *suggestions = @[@"Drink More Water", @"Pet Lola", @"Exercise"];
    
    [self presentTextInputControllerWithSuggestions:suggestions allowedInputMode:WKTextInputModeAllowEmoji completion:^(NSArray * _Nullable results) {
        NSLog(@"%@", results);
    }];
}



@end



