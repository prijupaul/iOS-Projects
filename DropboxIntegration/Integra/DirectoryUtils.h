//
//  DirectoryUtils.h
//  Integra
//
//  Created by Priju Jacob Paul on 5/02/2014.
//  Copyright (c) 2014 Integra Cooperation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryUtils : NSObject

+ (NSMutableArray*) getListOfDirectoriesUnderNSDocument;
+ (NSMutableArray*) getListOfDirectoriesUnder:(NSString*)directory;
+ (BOOL) createDirectoryWithName:(NSString*)name;
+ (BOOL) doesDirectoryExist:(NSString*)name;
+ (BOOL) deleteDirectoryWithName:(NSString*)name;
+ (void) deleteFilesUnderFolder:(NSString*) folderName;
@end
