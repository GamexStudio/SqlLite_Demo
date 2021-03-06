//
//  DBManager.h
//  SqlLite_Demo
//
//  Created by Gamex on 03/12/15.
//  Copyright (c) 2015 Gamex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBManager : NSObject
{

    NSString *databasePath;


}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;

- (BOOL) saveData:(NSString*)name
       department:(NSString*)department year:(NSString*)year;

-(NSMutableArray *)getalldata;

-(BOOL)delete_Student:(NSString *)otherName;
@end
