//
//  AppDelegate.h
//  week11CoreData
//
//  Created by 최원영 on 2017. 5. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

