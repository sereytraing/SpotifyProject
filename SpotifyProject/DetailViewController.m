//
//  DetailViewController.m
//  SpotifyProject
//
//  Created by Sereypich TRAING on 18/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [self.itemReceived objectForKey:@"name"]);
    self.titleLabel.text = [NSString stringWithFormat:@"%@", [self.itemReceived objectForKey:@"name"]];
    self.albumLabel.text = [NSString stringWithFormat:@"%@", [[self.itemReceived objectForKey:@"album"]objectForKey:@"name"]];
    NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[self.itemReceived objectForKey:@"album"] objectForKey:@"images"] objectAtIndex:0] objectForKey:@"url"]]];
        //objectAtIndex: 0 <- pour prendre la plus grande image, sinon (300x300, 64x64)
    self.imageView.image = [UIImage imageWithData: imageData];
    self.durationLabel.text = [NSString stringWithFormat:@"%@",[self convertMSToSec: [self.itemReceived objectForKey:@"duration_ms" ]]];
    self.artistLabel.text = [NSString stringWithFormat:@"%@", [[[self.itemReceived objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"name"]];
    self.containerView.layer.cornerRadius = 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*) convertMSToSec: (NSNumber*)time {
    int ms = 0;
    int secondes = 0;
    int minutes = 0;
    
    ms = [time intValue]/1000;
    secondes = ms%60;
    ms = ms/60;
    minutes = ms%60;
    ms = ms/60;

    NSString* resultat = [NSString stringWithFormat: @"%d:%d min", minutes, secondes];
    return resultat;
}

@end
