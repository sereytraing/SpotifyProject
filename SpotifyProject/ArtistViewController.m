//
//  ArtistViewController.m
//  SpotifyProject
//
//  Created by OFFROY Vincent on 24/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import "ArtistViewController.h"
#import "ArtistAlbumCell.h"

@interface ArtistViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIScrollView *kindScrollView;
@property (strong, nonatomic) IBOutlet UIView *kindView;

@end

@implementation ArtistViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    if([self.navigationController respondsToSelector:@selector(hidesBarsOnSwipe)]) {
        self.navigationController.hidesBarsOnSwipe = YES;
    }
    self.scrollView.delegate= self;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self addKindLabelToView];
    [self.scrollView layoutIfNeeded];
    self.scrollView.contentSize= self.contentView.bounds.size;
    [self.kindScrollView layoutIfNeeded];
    self.kindScrollView.contentSize = self.kindView.bounds.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addKindLabelToView {
    int i = 0;
    while(i < 1400){
        UILabel *kind = [[UILabel alloc] initWithFrame:CGRectMake(i, 0, 100, 60)];
        [kind setText:@"azertyuiop"];
        [kind setTextColor:[UIColor greenColor]];
        kind.textAlignment = NSTextAlignmentCenter;
        
        [self.kindView addSubview:kind];
        i+=150;
    }
    CGRect newFrame = self.kindView.frame;
    newFrame.size.width = i;
    newFrame.size.height = 78;
    [self.kindView setFrame:newFrame];
}

- (void) addAlbumToList {
    int i = 0;
    while(i < 1400){
        UILabel *kind = [[UILabel alloc] initWithFrame:CGRectMake(i, 0, 100, 60)];
        [kind setText:@"azertyuiop"];
        [kind setTextColor:[UIColor greenColor]];
        kind.textAlignment = NSTextAlignmentCenter;
        
        [self.kindView addSubview:kind];
        i+=150;
    }
    CGRect newFrame = self.kindView.frame;
    newFrame.size.width = i;
    newFrame.size.height = 78;
    [self.kindView setFrame:newFrame];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%g",scrollView.contentOffset.y);
    if(scrollView.contentOffset.y <= 20){
        [self.navigationController.navigationBar setHidden:NO];
        self.navigationController.hidesBarsOnSwipe = NO;
    }else{
        [self.navigationController.navigationBar setHidden:YES];
        self.navigationController.hidesBarsOnSwipe = YES;
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
