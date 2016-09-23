//
//  PPEViewController.m
//  EditableGrid
//
//  Created by Alexander Snegursky on 9/23/16.
//  Copyright © 2016 Alexander Snegursky. All rights reserved.
//


#import "PPEViewController.h"
#import "PPEGridColumnModel.h"


@interface PPEViewController ()

@end


@implementation PPEViewController


#pragma mark - Lifecycle Methods


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray <PPEGridColumnModel *> *columns = [PPEGridColumnModel itemsFromFileWithName:@"columns"];
    NSLog(@"");
}

@end
