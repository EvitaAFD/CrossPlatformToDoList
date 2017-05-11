//
//  TVDetailViewController.m
//  CrossPlatformToDoList
//
//  Created by Eve Denison on 5/10/17.
//  Copyright © 2017 Eve Denison. All rights reserved.
//

#import "TVDetailViewController.h"
#import "ToDo.h"
#import "TVHomeViewController.h"

@interface TVDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.titleLabel setText:self.selectedToDo.title];
    [self.contentLabel setText:self.selectedToDo.content];
}


@end
