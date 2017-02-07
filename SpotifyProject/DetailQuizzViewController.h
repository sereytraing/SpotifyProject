//
//  DetailQuizzViewController.h
//  SpotifyProject
//
//  Created by TRAING Serey on 07/02/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DetailQuizzViewController : UIViewController {
    @private
    int count;    // Count is used to change the title of button (Play/Pause)    
    AVPlayer *player; // AVPlayer used to play audio files
    AVPlayerItem *playerItem; // set a item for the AVPlayer
}
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end
