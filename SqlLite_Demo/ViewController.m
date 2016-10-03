//
//  ViewController.m
//  SqlLite_Demo
//
//  Created by Gamex on 03/12/15.
//  Copyright (c) 2015 Gamex. All rights reserved.
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

    
    success = [[DBManager getSharedInstance]saveData:@"PIXER" department:@"IOS" year:@"2012"];
    
    
    if (success) {
        
        NSLog(@"Success%hhd",success);
    }
    else
    {
        NSLog(@"fail%hhd",success);
    }
    
    
    BOOL isdeleted = [[DBManager getSharedInstance] delete_Student:@"Gamex"];
    
    if (isdeleted) {
        
         NSLog(@"data deleted Successfully");
        
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
