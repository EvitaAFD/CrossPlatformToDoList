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

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


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
    
    NSString *password = self.passwordTextField.text;
    NSString *email = self.emailTextField.text;
    
    NSLog(@"Password: %@  Email: %@", password, email);
    
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRUser * _Nullable user, NSError * _Nullable error){
        
        if (error) {
            NSLog(@"Error Signing Up: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"User Signed Up %@", user);
        }
        
    }];
    
}


@end
