//
//  DirectoryViewController.m
//  Mush-Mush
//
//  Created by Tatyana Shut on 14.07.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "DirectoryViewController.h"
#import "DataSource.h"
#import "DirectoryTableViewCell.h"
#import "DetailsViewController.h"


NSString *const cellReuseIdentifier = @"imageID";

@interface DirectoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *urlArray;
@property(strong, nonatomic) NSArray *nameMushroom;
@property(strong, nonatomic) NSMutableArray *tableDataModel;
@property(strong, nonatomic) NSOperationQueue *customQueue;

@end

@implementation DirectoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableDataModel = [NSMutableArray array];
    
    [self tableViewSetUp];
    [self.tableView registerClass:[DirectoryTableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    
    self.navigationItem.title = @"Справочник грибов";
    
    self.urlArray = [[DataSource alloc]init].urlArray;
    self.nameMushroom = [[DataSource alloc]init].nameMushroom;
    
    DirectoryTableViewCell *cell = [[DirectoryTableViewCell alloc]init];
    for (int index = 0; index < self.urlArray.count; index++) {
        NSMutableDictionary *imageInfo = [@{
                                            @"defaultImage": [UIImage imageNamed:@"noPhoto"],
                                            @"defaultText": cell.urlLabel.text
                                            } mutableCopy];
        
        [self.tableDataModel addObject:imageInfo];
    }
    self.customQueue = [[NSOperationQueue alloc] init];
    [self operationQueue];
    
}
- (void)viewDidAppear:(BOOL)animated {
    if (self.customQueue.isSuspended) {
        [self.customQueue setSuspended:NO];
    }
}

- (void)operationQueue {
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSOperation *lastTask = nil;
    
    for (NSInteger index = 0; index < self.urlArray.count; index++) {
        NSOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSOperation *finalOperation = [NSBlockOperation blockOperationWithBlock:^{
                NSString *dataMushroom = [[NSString alloc]initWithFormat:@"%@", self.nameMushroom[index]];
                NSURL *url = [NSURL URLWithString:self.urlArray[index]];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                NSMutableDictionary *imageInfo = self.tableDataModel[index];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
                [imageInfo setDictionary:@{
                                           @"url": dataMushroom ,
                                           @"image": image,
                                           }];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }];
            [mainQueue addOperation:finalOperation];
        }];
        if (lastTask) {
            [operation addDependency:lastTask];
        }
        
        lastTask = operation;
        
        [self.customQueue addOperation:operation];
    }
    // dispatch_async(dispatch_get_main_queue(), ^{
    //  [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    //});
    //}
    
}

- (void) tableViewSetUp {
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
                                              ]];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.urlArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DirectoryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *imageInfo = self.tableDataModel[indexPath.row];
    UIImage *image = [imageInfo objectForKey:@"image"];
    
    if (image) {
        cell.imageFromUrlView.image = [imageInfo objectForKey:@"image"];
        cell.urlLabel.text = self.nameMushroom[indexPath.row];
        cell.imageFromUrlView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{
        
        cell.imageFromUrlView.image = [imageInfo objectForKey:@"defaultImage"];
        cell.urlLabel.text = [imageInfo objectForKey:@"defaultText"];
    }
    
    return cell;
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSOperationQueue *currentQueue = [NSOperationQueue new];
    [currentQueue setSuspended:YES];
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    NSDictionary *imageInfo = self.tableDataModel[indexPath.row];
    UIImage *image = [imageInfo objectForKey:@"image"];
    NSString *title = [[NSString alloc]initWithString:[[NSString alloc]initWithFormat:@"%@",self.nameMushroom[indexPath.row]]];
    DataSource *descriptionMush = [[DataSource alloc]init];
    NSString *descriptionMushName = [[NSString alloc]initWithString:[[NSString alloc]initWithFormat:@"%@",descriptionMush.descriptionMushroom[indexPath.row]]];
    
    if (!image) {
        image = [UIImage imageNamed:@"noPhoto"];
        detailsVC.descriptionMushroom = @"";
        detailsVC.titleDetailsVc = @"Справочник грибов";
    }
    
    detailsVC.imageFull = image;
    detailsVC.titleDetailsVc = title;
    detailsVC.descriptionMushroom = descriptionMushName;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
@end
