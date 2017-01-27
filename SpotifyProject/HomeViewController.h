//
//  HomeViewController.h
//  SpotifyProject
//
//  Created by TRAING Serey on 13/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController {
    @private
    BOOL viewChanged;
    BOOL requested;
    NSString *next;
    NSNumber *total;
    NSMutableDictionary* jsonDict;
    NSMutableArray* tempArr;
    NSMutableArray* listArtists;
}
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *tf_artistName;
- (IBAction)valueChanged:(id)sender;
-(void)getArtistFromApi;

@end
