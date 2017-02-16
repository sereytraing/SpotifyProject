//
//  ResultViewController.m
//  SpotifyProject
//
//  Created by TRAING Serey on 14/01/2017.
//  Copyright © 2017 TRAING Serey. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailViewController.h"
#import "AlbumViewController.h"
#import "ArtistViewController.h"
#import "ResultTrackCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ResultViewController () <UITableViewDelegate, UITableViewDataSource>
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = UIColorFromRGB(0x333333);
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBarHidden = 0;
    self.noResultLabel.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //Title Navigation Bar
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    [titleLabel setFont:[UIFont systemFontOfSize:20]];
    titleLabel.textColor = [UINavigationBar appearance].tintColor;
    titleLabel.text = self.artistNameReceived;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;

    
    //Replace " " > +
    self.artistNameReceived = [self.artistNameReceived stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    artistNameUpdated = [[self.artistNameReceived stringByReplacingOccurrencesOfString:@" " withString:@"+"] mutableCopy];
    NSLog(@"%@",artistNameUpdated);
    
    NSString* urlTrack = [NSString stringWithFormat: @"https://api.spotify.com/v1/search?q=%@&type=track&market=FR", artistNameUpdated];
    NSString* urlArtist = [NSString stringWithFormat: @"https://api.spotify.com/v1/search?q=%@&type=artist&market=FR", artistNameUpdated];
    NSString* urlAlbum = [NSString stringWithFormat: @"https://api.spotify.com/v1/search?q=%@&type=album&market=FR", artistNameUpdated];
    
    
    [self.trackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.artistButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.albumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

    NSURLSession* sessionTrack = [NSURLSession sharedSession];
    NSURLRequest* requestTrack = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: urlTrack]];
    NSURLSessionDataTask* dataTask = [sessionTrack dataTaskWithRequest:requestTrack completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            self->jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self->listTracks = [[jsonDict objectForKey:(@"tracks")]objectForKey:(@"items")];
        }

    }];
    [dataTask resume];
    
    NSURLSession* sessionArtist = [NSURLSession sharedSession];
    NSURLRequest* requestArtist = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: urlArtist]];
    NSURLSessionDataTask* dataTaskArtist = [sessionArtist dataTaskWithRequest:requestArtist completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            self->jsonDictArtist = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self->listArtists = [[jsonDictArtist objectForKey:(@"artists")]objectForKey:(@"items")];
        }
        
    }];
    [dataTaskArtist resume];
    
    NSURLSession* sessionAlbum = [NSURLSession sharedSession];
    NSURLRequest* requestAlbum = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: urlAlbum]];
    NSURLSessionDataTask* dataTaskAlbum = [sessionAlbum dataTaskWithRequest:requestAlbum completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error) {
            self->jsonDictAlbum = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self->listAlbums = [[jsonDictAlbum objectForKey:(@"albums")]objectForKey:(@"items")];
        }
        
    }];
    [dataTaskAlbum resume];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listTracks count];
}

static NSString* const kCellId = @"myCell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultTrackCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ResultTrackCell" bundle:nil] forCellReuseIdentifier:kCellId];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    }
    cell.albumLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    cell.containerView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    cell.backgroundColor = UIColorFromRGB(0x333333);
    switch(self.segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            cell.trackView.hidden = YES;
            cell.artistView.hidden = NO;
            cell.imageView.image = nil;
            cell.artistNameLabel.text = [NSString stringWithFormat:@"%@", [[listArtists objectAtIndex:indexPath.row] objectForKey:@"name"]];
            break;
        }
        case 1:
        {
            cell.artistView.hidden = YES;
            cell.trackView.hidden = NO;
            cell.trackLabel.text = [NSString stringWithFormat:@"%@", [[listTracks objectAtIndex:indexPath.row] objectForKey:@"name"]];
            cell.trackLabel.textColor =[UIColor colorWithRed:0.114 green:0.725 blue:0.329 alpha:1];
            NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[[listTracks objectAtIndex: indexPath.row] objectForKey:@"album"] objectForKey:@"images"] objectAtIndex:1] objectForKey:@"url"]]];
            cell.imageView.image = [UIImage imageWithData: imageData];
            cell.albumLabel.text = [[[listTracks objectAtIndex:indexPath.row] objectForKey:@"album"]objectForKey:@"name"];
            break;
        }
        case 2:
        {
            cell.artistView.hidden = YES;
            cell.trackView.hidden = NO;
            cell.trackLabel.text = [NSString stringWithFormat:@"%@", [[listAlbums objectAtIndex:indexPath.row] objectForKey:@"name"]];
            cell.trackLabel.textColor =[UIColor colorWithRed:0.114 green:0.725 blue:0.329 alpha:1];
            NSData* imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [[[[listAlbums objectAtIndex:indexPath.row]objectForKey:@"images"]objectAtIndex:1] objectForKey:@"url"]]];
            cell.imageView.image = [UIImage imageWithData: imageData];
            cell.albumLabel.text = [NSString stringWithFormat:@"%@",[[[[listAlbums objectAtIndex:indexPath.row] objectForKey:@"artists"]objectAtIndex:0]objectForKey:@"name"]];
            break;
            
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    DetailViewController* dvc = [[DetailViewController alloc]init];
    ArtistViewController* avc = [[ArtistViewController alloc]init];
    avc.itemReceived = [listTracks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:avc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
- (IBAction)touchSegmentedControl:(id)sender {
    [self.tableView reloadData];
}

@end
