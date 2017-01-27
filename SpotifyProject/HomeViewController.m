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
    [super viewDidLoad];
    self.tf_artistName.delegate = self;
    self.submitButton.layer.cornerRadius = 10;
    requested = NO;
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

- (IBAction)valueChanged:(id)sender {
    NSLog(@"vChang");
    NSLog(@"BOOL Taille > 3 = %d",(self.tf_artistName.text.length > 3));
    self->next = @"null";
    if (self.tf_artistName.text.length > 2 && !requested) {
        [self getArtistFromApi];
        
    } else if (self.tf_artistName.text.length > 2 && !requested) {
        
    }else if (self.tf_artistName.text.length <= 2) {
        requested = NO;
    }
    NSLog(@"Le total %d", [total intValue]);
    for (int i = 1; i < [total intValue]; i++) {
        NSLog(@"Nom des artistes %@", [NSString stringWithFormat:@"%@",[[listArtists objectAtIndex:i] objectForKey:@"name"]]);
    }
}

-(void)getArtistFromApi {
    NSString* url;
    listArtists = [[NSMutableArray alloc] init];
    if ([next isEqualToString:@"null"]) {
        url = [NSString stringWithFormat: @"https://api.spotify.com/v1/search?q=%@&type=artist&market=FR&offset=0&limit=50", self.tf_artistName.text];
    } else {
        url = next;
    }
    NSURLSessionDataTask* dataTask;
    do {
        NSURLSession* session = [NSURLSession sharedSession];
        NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: url]];
        dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error) {
                self->jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                self->tempArr = [[jsonDict objectForKey:(@"artists")]objectForKey:(@"items")];
                //NSLog(@"tempArr %@", self->tempArr);
                [self->listArtists addObjectsFromArray:tempArr];
                NSLog(@"listArtist %@", self->listArtists);
                self->total = [[jsonDict objectForKey:(@"artists")]valueForKey:(@"total")];
                self->next = [[jsonDict objectForKey:(@"artists")]valueForKey:(@"next")];
                NSLog(@"%@ %@ %d", self->next, self->total, ![next isEqualToString:@"null"]);
            } else {
                NSLog(@"Erreur");
            }
            
        }];
    } while (![next isEqualToString:@"null"]);
    [dataTask resume];
    //NSLog(@"listArtist %@", self->listArtists);
}
@end
