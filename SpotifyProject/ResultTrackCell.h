//
//  ResultTrackCell.h
//  SpotifyProject
//
//  Created by Sereypich TRAING on 25/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTrackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;

@end
