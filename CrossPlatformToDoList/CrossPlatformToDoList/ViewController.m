//
//  ViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "ToDo.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)NSMutableArray *allToDos;

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allToDoHandler;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addToDoTop;
@property (weak, nonatomic) IBOutlet UIView *toDoContainerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkUserStatus];
}

-(void)checkUserStatus {
    
    if (![[FIRAuth auth] currentUser]) {
        
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
        
    } else {
        
        [self setUpFirebase];
        [self startMonitoringToDoUpdates];
    }

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
            
            if ([todoData[@"completed"] isEqual:@0]) {
                
            ToDo *toDo = [[ToDo alloc]initWithDictionary:todoData];
            
            [self.allToDos addObject:toDo];
                
            }
            [self.tableView reloadData];

        }
    }];
    
}

- (IBAction)addNewToDoPressed:(id)sender {
    
    double kDefaultDisplayTop = (-150);
    double kShowingTop = 0;
    
    if (self.toDoContainerView.hidden == YES) {
        [self.toDoContainerView setHidden:NO];
        self.addToDoTop.constant = kShowingTop;
        
    } else {
        [self.toDoContainerView setHidden:YES];
        self.addToDoTop.constant = kDefaultDisplayTop;
    
    }
    
}
- (IBAction)logoutButtonPressed:(id)sender {
    
    NSError *error;
    
    [[FIRAuth auth] signOut:&error];
    
    [self.allToDos removeAllObjects];
    
    [self checkUserStatus];
    [self.tableView reloadData];
    
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.userReference = [[FIRDatabase database] reference];
        
        ToDo *currentToDo = self.allToDos[indexPath.row];
        
        [[[[[[_userReference child:@"users"] child:_currentUser.uid] child:@"todos"] child:currentToDo.key] child:@"completed"] setValue:@1];
    }
    
    [self.tableView reloadData];

}


@end
