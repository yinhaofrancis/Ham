//
//  HMTableViewController.m
//  Ham_Example
//
//  Created by hao yin on 2020/5/1.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "HMTableViewController.h"
#import "HMTableViewCell.h"
#import "HMRenderImage.h"
@interface HMTableViewController ()

@end

@implementation HMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 500;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for (UIImageView * v in cell.imms) {
        
        [[[HMRenderImage shared] draw:^(CGContextRef _Nonnull ctx, CGRect rect) {
            CGPathRef p = CGPathCreateWithRoundedRect(rect, 24, 24, nil);
            CGContextAddPath(ctx, p);
            CGPathRelease(p);
            CGContextClip(ctx);
            CGContextDrawImage(ctx, rect, [UIImage imageNamed:@"p"].CGImage);
            NSLog(@"int");
        }] drawSize:CGSizeMake(100, 100) callback:^(UIImage * _Nonnull img) {
            dispatch_async(dispatch_get_main_queue(), ^{
                v.image = img;
            });
        }];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


@end
