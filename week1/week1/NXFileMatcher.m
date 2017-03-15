//
//  NXFileMatcher.m
//  week1
//
//  Created by 최원영 on 2017. 3. 15..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "NXFileMatcher.h"

@implementation NXFileMatcher

NSFileManager *nsFileManager;


//초기화 할 때 FileManager를 만들어 놓는다.
- (instancetype)init
{
    self = [super init];
    if (self) {
        nsFileManager = [NSFileManager defaultManager];
    }
    return self;
}

//경로의 모든 파일을 출력하는 메소드
- (void) displayAllFilesAtPath:(NSString*)path {

    NSError *error;
    NSArray *filenames = [nsFileManager contentsOfDirectoryAtPath:path error:&error];
    
    if (!error) {
        for (NSString * filename in filenames) {
            NSLog(@"filename: %@", filename);
        }
    }
    
}


//특정 확장자면 필터링해서 출력하는 메소드
- (void) displayAllFilesAtPath:(NSString*)path
             filterByExtension:(NSString*)extension {
    NSError *error;
    NSArray *filenames = [nsFileManager contentsOfDirectoryAtPath:path error:&error];
    
    if (!error) {
        for (NSString * filename in filenames) {
            
            NSString *_extension = [filename pathExtension];
            
            //소름...
            if ([_extension isEqualToString:extension]) {
                NSLog(@"%@", filename);
            }
        }
    }
    
}

@end
