//
//  ResultViewController.h
//  SpotifyProject
//
//  Created by TRAING Serey on 14/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController {
    @private
    NSMutableDictionary* jsonDict;
    NSMutableArray* listTracks;
    NSMutableArray* imageUrl;
    NSMutableString* artistNameUpdated;
   
}
@property (strong, nonatomic) IBOutlet UIButton *artistButton;
@property (strong, nonatomic) IBOutlet UIButton *trackButton;
@property (strong, nonatomic) IBOutlet UIButton *albumButton;

@property (strong, nonatomic) IBOutlet UILabel *noResultLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString* artistNameReceived;
@end
