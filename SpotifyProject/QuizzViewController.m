//
//  QuizzViewController.m
//  SpotifyProject
//
//  Created by TRAING Serey on 07/02/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import "QuizzViewController.h"
#import "DetailQuizzViewController.h"

@interface QuizzViewController ()

@end

@implementation QuizzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextTouched:(id)sender {
    DetailQuizzViewController* dqvc = [[DetailQuizzViewController alloc]init];
    [self.navigationController pushViewController:dqvc animated:YES];
}

@end
