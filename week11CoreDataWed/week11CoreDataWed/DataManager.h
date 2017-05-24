//
//  DataManager.h
//  week11CoreDataWed
//
//  Created by 최원영 on 2017. 5. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "week11CoreDataWed+CoreDataModel.h"

@interface DataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController<Student *> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+(DataManager *) getDataManager;
- (void)insertNewStudentWithId:(NSString*)id withName:(NSString*)name withGender:(Boolean)isMale withGrade:(NSInteger)grade;
- (NSArray <Student *> *)selectAllStudentList;
@end
