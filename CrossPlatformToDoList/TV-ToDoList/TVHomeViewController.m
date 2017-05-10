//
//  TVHomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "TVHomeViewController.h"
#import "ToDo.h"
#import "FirebaseAPI.h"

@interface TVHomeViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tvTableView;
@property(strong, nonatomic) NSArray<ToDo *> *allToDos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tvTableView.dataSource = self;
    
    [FirebaseAPI fetchAllTodos:^(NSArray<ToDo *> *allTodos) {
        NSLog(@"%@", allTodos);
    }];
}

//-(NSArray<ToDo *> *)allToDos {
//    ToDo *firstToDo = [[ToDo alloc]init];
//    firstToDo.title = @"First To Do";
//    firstToDo.content = @"To do stuff";
//    
//    ToDo *secondToDo = [[ToDo alloc]init];
//    secondToDo.title = @"Second To Do";
//    secondToDo.content = @"To do more stuff";
//    
//    ToDo *thirdToDo = [[ToDo alloc]init];
//    thirdToDo.title = @"ThirdTo Do";
//    thirdToDo.content = @"Oh no another to do";
//    
//    return @[firstToDo, secondToDo, thirdToDo];
//    
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allToDos[indexPath.row].title;
    cell.textLabel.text = self.allToDos[indexPath.row].content;
    
    return cell;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allToDos.count;
}

@end
