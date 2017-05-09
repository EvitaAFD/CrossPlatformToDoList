//
//  ViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController ()

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property (nonatomic) FIRDatabaseHandle allToDoHandler;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addToDoTop;
@property (weak, nonatomic) IBOutlet UIView *toDoContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        
        NSMutableArray *allTodos = [[NSMutableArray alloc] init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
        
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            
            //for lab append new Todo to allTodos array
            
            NSLog(@"Todo Title: %@ - Conent: %@ ", todoTitle, todoContent);
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


@end
