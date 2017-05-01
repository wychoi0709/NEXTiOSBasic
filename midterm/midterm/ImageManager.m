//
//  ImageManager.m
//  midterm
//
//  Created by 최원영 on 2017. 5. 1..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ImageManager.h"

@implementation ImageManager{
    char *data;
    NSData* jsonData;
    NSArray *imageArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},\{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},\{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},\{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},\{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},\{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},\{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},\{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},\{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},\{\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]";
        jsonData = [NSData dataWithBytes:data length:strlen(data)];
    
        //jsonData를 NSArray로 바꾼다.
        NSError *jsonParsingError = nil;
        imageArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:0 error:&jsonParsingError];
        
        NSLog(@"imageArray: %@", imageArray);
        
        //데이터를 담아 노티를 보낸다.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:imageArray forKey:@"imageArray"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"imageManagerObserver" object:self userInfo:userInfo];
    }
    return self;
}

- (void) reorderByDate{
    //sorting 하기
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc]
                                            initWithKey:@"date"
                                            ascending:YES
                                            selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:dateDescriptor, nil];
    NSArray *sortedArray = [imageArray sortedArrayUsingDescriptors:descriptors];
    
    NSLog(@"sortedArray: %@", sortedArray);

    //데이터를 담아 노티를 보낸다.
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:sortedArray forKey:@"sortedImageArray"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sortedImageManagerObserver" object:self userInfo:userInfo];

}

@end
