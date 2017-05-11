//
//  TVHomeViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TVDetailViewController.h"
#import "ToDo.h"
#import "FirebaseAPI.h"

@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvTableView;
@property(strong, nonatomic) NSArray<ToDo *> *allToDos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tvTableView.dataSource = self;
    self.tvTableView.delegate = self;
    
    [FirebaseAPI fetchAllTodos:^(NSArray<ToDo *> *allTodos) {
        NSLog(@"%@", allTodos);
        
        self.allToDos = allTodos;
        [self.tvTableView reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.allToDos[indexPath.row].title;
    cell.detailTextLabel.text = self.allToDos[indexPath.row].content;
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allToDos.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TVDetailViewController *detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"TVDetailViewController"];
    detailController.selectedToDo = self.allToDos[indexPath.row];
    
    [self presentViewController:detailController animated:YES completion:nil];

}

@end
