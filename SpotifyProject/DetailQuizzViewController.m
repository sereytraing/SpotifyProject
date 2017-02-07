//
//  DetailQuizzViewController.m
//  SpotifyProject
//
//  Created by TRAING Serey on 07/02/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DetailQuizzViewController.h"

@interface DetailQuizzViewController ()

@end

@implementation DetailQuizzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"https://p.scdn.co/mp3-preview/751781f22acdd19a5edf8d27e05d79fbcd8ad679?cid=null"]; //Add any link of audio file which you want to play
    
    playerItem = [AVPlayerItem playerItemWithURL:url]; // add url to playerItem
    
    player = [AVPlayer playerWithPlayerItem:playerItem]; // add player item to AVAudioPlayer
    player = [AVPlayer playerWithURL:url];
    
    count = 0; // intialize count to zero
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playAction:(id)sender {
    count++;  // incremnets the count
    
    [player play];  // make avplyer play the sound
    [self.playButton setTitle:@"Pause" forState:UIControlStateNormal];  // change the Button`s text
    
    if (count == 2) {
        count = 0;
        [self.playButton setTitle:@"Play" forState:UIControlStateNormal];  // change the Button`s text
        [player pause];  // make the player pause
    }

}

- (IBAction)submitAction:(id)sender {
}

@end
