//
//  ViewController.m
//  SqlLite_Demo
//
//  Created by Ashish Chauhan on 03/12/15.
//  Copyright (c) 2015 Ashish Chauhan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    BOOL success = NO;

    
    success = [[DBManager getSharedInstance]saveData:@"darshan" department:@"IOS" year:@"2012"];
    
    
    if (success) {
        
        NSLog(@"Success%hhd",success);
    }
    else
    {
        NSLog(@"fail%hhd",success);
    }
    
    
    NSMutableArray *data = [[DBManager getSharedInstance]getalldata];
     NSLog(@"All data %@",data);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
