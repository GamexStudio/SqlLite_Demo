//
//  DBManager.m
//  SqlLite_Demo
//
//  Created by Ashish Chauhan on 03/12/15.
//  Copyright (c) 2015 Ashish Chauhan. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;



+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}


-(BOOL)createDB{
    
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"student.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];

    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "create table if not exists studentsDetail (regno integer primary key AUTOINCREMENT, name text, department text, year text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else
        {
            isSuccess = NO;
            NSLog(@"Database Error Message : %s", sqlite3_errmsg(database));
            
            NSLog(@"Failed to open/create database");
            
        }
        

    }
    
    return isSuccess;

}


- (BOOL) saveData:(NSString*)name
       department:(NSString*)department year:(NSString*)year;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:@"insert into studentsDetail (name, department, year) values(\"%@\",\"%@\",\"%@\")",name,department,year];
                                const char *insert_stmt = [insertSQL UTF8String];
                                sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
                                if (sqlite3_step(statement) == SQLITE_DONE)
                                {
                                    return YES;
                                } 
                                else {
                                    return NO;
                                }
                                sqlite3_reset(statement);
                                }
                                return NO;
}


                            
                            
                            

                            
                            
                            
   -(NSMutableArray *)getalldata
        {
            const char *dbpath = [databasePath UTF8String];
            if (sqlite3_open(dbpath, &database) == SQLITE_OK)
            {

                
                 NSString *select = [NSString stringWithFormat:@"Select * from  studentsDetail"];
                const char *query_getOthrMDNVal = [select UTF8String];
                
                NSMutableArray *getMdns = [[NSMutableArray alloc] init];
                if (sqlite3_prepare_v2(database,query_getOthrMDNVal, -1, &statement, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(statement) == SQLITE_ROW)
                    {
                        //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                        //                                    (const char *) sqlite3_column_text(statement, 0)]];
                        //
                        //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                        //                                    (const char *) sqlite3_column_text(statement, 1)]];
                        //                [getMdns addObject:[[NSString alloc] initWithUTF8String:
                        //                                    (const char *) sqlite3_column_text(statement, 2)]];
                        
                      //  [getMdns addObject:[[NSString alloc] initWithUTF8String:
   //                                         (const char *) sqlite3_column_text(statement, 2)]];
                        //[getMdns addObject:[[NSString alloc] initWithUTF8String:
     //                                       (const char *) sqlite3_column_text(statement, 4)]];
                        
                        NSString *name = [[NSString alloc] initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 0)];
                        [getMdns addObject:name];
                        NSString *department = [[NSString alloc] initWithUTF8String:
                                                (const char *) sqlite3_column_text(statement, 1)];
                        [getMdns addObject:department];
                        NSString *year = [[NSString alloc]initWithUTF8String:
                                          (const char *) sqlite3_column_text(statement, 2)];
                        [getMdns addObject:year];
                       
     
                        
                        
                    }
                    return getMdns;
                    sqlite3_finalize(statement);
                    sqlite3_close(database);
                    
                }
            }
            sqlite3_close(database);
            return nil;
        }


@end

