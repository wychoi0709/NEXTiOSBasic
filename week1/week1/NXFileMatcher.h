//
//  NXFileMatcher.h
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXFileMatcher : NSObject

- (void) displayAllFilesAtPath:(NSString*)path;

- (void) displayAllFilesAtPath:(NSString*)path
             filterByExtension:(NSString*)extension;

@end
