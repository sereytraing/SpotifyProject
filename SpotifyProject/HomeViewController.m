//
//  HomeViewController.m
//  SpotifyProject
//
//  Created by TRAING Serey on 13/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import "HomeViewController.h"
#import "ResultViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface HomeViewController () <UITextFieldDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    NSLog(@"GIT DE MEEEEEEEEERDE");
    [super viewDidLoad];
    self.tf_artistName.delegate = self;
    self.submitButton.layer.cornerRadius = 10;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].shadowImage = [UIImage new];
    [UINavigationBar appearance].translucent = YES;
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x1DB954)];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchSubmit:(id)sender {
    ResultViewController* rvc = [[ResultViewController alloc]init];
    rvc.artistNameReceived = self.tf_artistName.text;
    [self.navigationController pushViewController:rvc animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if(viewChanged) {
        [self animationMove:self.view moveUp:NO];
    }
    viewChanged = NO;
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if(!viewChanged) {
        [self animationMove:self.view moveUp:YES];
        viewChanged = YES;
    }
}

-(void)animationMove:(UIView *)viewToMove moveUp:(BOOL) moved {
    
    const int distance = - 80; // distance du decalage
    const float durationAnimation = 0.3f;
    int movement;
    
    if (moved == YES) {
        movement = distance;
    } else {
        movement = - distance;
    }
    [UIView beginAnimations: @"textFieldAnimation" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: durationAnimation];
    viewToMove.frame = CGRectOffset(viewToMove.frame, 0, movement);
    [UIView commitAnimations];
}
@end
