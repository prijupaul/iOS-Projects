//
//  DirectoryUtils.m
//  Integra
//
//  Created by Priju Jacob Paul on 5/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import "DirectoryUtils.h"

@implementation DirectoryUtils

+ (NSMutableArray*) getListOfDirectoriesUnderNSDocument {
    
   
    
    NSString* documentDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
     NSLog(@"%@",[[NSFileManager defaultManager]contentsOfDirectoryAtPath:documentDirPath error:nil]);
    NSArray* paths = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:documentDirPath error:nil];
    BOOL isDir = NO;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSMutableArray* directoryName = [NSMutableArray new];
    
    for (NSString* path in paths) {
        if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
            [directoryName addObject:path];
        }
    }
    return directoryName;
}

+ (NSMutableArray*) getListOfDirectoriesUnder:(NSString*)directory {
    

     NSString* directoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:directory];
    
    NSLog(@"%@",[[NSFileManager defaultManager]contentsOfDirectoryAtPath:directoryPath error:nil]);
    NSArray* paths = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:directoryPath error:nil];
//    BOOL isDir = NO;
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSMutableArray* fileNames = [NSMutableArray new];
//    
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.pdf'"];
    NSMutableArray *onlyPDFs = [paths filteredArrayUsingPredicate:fltr];
    
    
    return onlyPDFs;
}

+ (BOOL) createDirectoryWithName:(NSString*)name{
  
    NSString* directoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:name];
    NSError* error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
        //Does directory already exist?
    {
        if ([[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                       withIntermediateDirectories:YES
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
            return YES;
        }
    }
    return NO;
}

+ (BOOL) doesDirectoryExist:(NSString*)name{
    NSArray* list = [self getListOfDirectoriesUnderNSDocument];
    if( [list containsObject:name]){
        return YES;
    }
    return NO;
}

+ (BOOL) deleteFileWithName:(NSString*)path {
    NSError* error;
    if ([[NSFileManager defaultManager]removeItemAtPath:path error:&error])
        return YES;
    return NO;
    
}

+ (void) deleteFilesUnderFolder:(NSString*) folderName {
    NSMutableArray* filesUnderFolder = [DirectoryUtils getListOfDirectoriesUnder:folderName];
    NSString* documentDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    if ([filesUnderFolder count] >0){
        for (NSString* path in filesUnderFolder) {
            NSString* fullPath = [NSString stringWithFormat:@"%@/%@/%@",documentDirPath,folderName,path];
            [DirectoryUtils deleteFileWithName:fullPath];
        }
        
    }
}

+ (BOOL) deleteDirectoryWithName:(NSString*)name{
    
    NSString* directoryPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:name];
    NSError* error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath])
        //Does directory already exist?
    {
        if ([[NSFileManager defaultManager] removeItemAtPath:directoryPath
                                                       error:&error])
        {
            NSLog(@"delete directory error: %@", error);
            return YES;
        }
    }
    return NO;
}



@end
