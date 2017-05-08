//
//  LoginViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/8/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "LoginViewController.h"

@import FirebaseAuth;

@interface LoginViewController ()

@property(strong, nonatomic) UITextField *emailTextField;
@property(strong, nonatomic) UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)emailTextField:(id)sender {
    
}

- (IBAction)passwordTextField:(id)sender {
    
}


- (IBAction)loginPressed:(id)sender {
    
    [[FIRAuth auth]  signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {

        if (error) {
            NSLog(@"Error Logging in: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"Logged in User %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
}

- (IBAction)signupPressed:(id)sender {
    
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error){
        
        if (error) {
            NSLog(@"Error Signing Up: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"User Signed Up %@", user);
        }
        
    }];
    
}


@end
