//
//  AlbumViewController.h
//  SpotifyProject
//
//  Created by OFFROY Vincent on 08/02/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController
@property (nonatomic, strong) NSString* titleReceived;
@property (nonatomic, strong) NSString* albumReceived;
@property (nonatomic, strong) NSString* artistReceived;
@property (nonatomic, strong) NSString* imageURLReceived;
@property (nonatomic, strong) NSNumber* durationReceived;
@property (nonatomic, strong) NSMutableDictionary* itemReceived;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
