//
//  CompletedViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/9/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "CompletedViewController.h"
#import "LoginViewController.h"
#import "ToDo.h"
#import "CompletedTableViewCell.h"
@import Firebase;
@import FirebaseAuth;

@interface CompletedViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoHandler;
@property (strong, nonatomic) NSMutableArray *allToDos;

@end

@implementation CompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setUpFirebase];
    [self startMonitoringToDoUpdates];
}

-(void) setUpFirebase {
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"]child:self.currentUser.uid];
    
    NSLog(@"USER REFERENCE: %@", self.userReference);
    
    
}

//Notify realtime changes to database
-(void) startMonitoringToDoUpdates {
    
    self.allToDoHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.allToDos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            
            NSDictionary *todoData = child.value;
            
            if ([todoData[@"completed"] isEqual:@1]) {
                
                ToDo *toDo = [[ToDo alloc]initWithDictionary:todoData];
                
                [self.allToDos addObject:toDo];
                
            }
            [self.tableView reloadData];
        }
    }];
                           
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allToDos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    ToDo *toDo = [self.allToDos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"TO DO NAME: %@, TO DO DETAILS: %@", toDo.title, toDo.content];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
    
}

@end
