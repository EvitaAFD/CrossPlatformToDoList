//
//  NewToDoViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "NewToDoViewController.h"

@import Firebase;
@import FirebaseAuth;

@interface NewToDoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;


@end

@implementation NewToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)addToDoPressed:(id)sender {
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    
    FIRUser *currentUser = [[FIRAuth auth] currentUser];
    
    FIRDatabaseReference *userReference = [[databaseReference child:@"users"] child:currentUser.uid];
    
    FIRDatabaseReference *newToDoReference = [[userReference child:@"todos"] childByAutoId];
    
    [[newToDoReference child:@"title"] setValue:self.titleTextField.text];
    
    [[newToDoReference child:@"content"] setValue:self.contentTextField.text];
    
    [[newToDoReference child:@"completed"] setValue:@0];
    
    [[newToDoReference child:@"key"] setValue:newToDoReference.key];
    
    self.titleTextField.text = nil;
    self.contentTextField.text = nil;
    
}



@end
