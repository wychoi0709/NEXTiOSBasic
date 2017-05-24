//
//  DataManager.m
//  week11CoreDataWed
//
//  Created by 최원영 on 2017. 5. 24..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

@implementation DataManager


+(DataManager *) getDataManager {
    
    static DataManager * sharedSingletonStateInstance;
    
    @synchronized (self){       // @synchronized를 통해 객체를 획득하는 부분의 상호배제
        if (!sharedSingletonStateInstance){
            sharedSingletonStateInstance = [[DataManager alloc] initPrivate];
        }
    }
    
    return sharedSingletonStateInstance;
}

-(instancetype) init {
    @throw [NSException exceptionWithName:@"DataManager is Singleton" reason:@"" userInfo:nil];
}

-(instancetype) initPrivate {
    self = [super init];
    if (self){
        
    }
    return self;
}

- (void)insertNewStudentWithId:(NSString*)id withName:(NSString*)name withGender:(Boolean)isMale withGrade:(NSInteger)grade{
    
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    Student *newStudent = [[Student alloc] initWithContext:context];
    
    // If appropriate, configure the new managed object.
    newStudent.id = id;
    newStudent.name = name;
    newStudent.gender = isMale;
    newStudent.grade = grade;
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (NSArray <Student *> *)selectAllStudentList{
    return [self.fetchedResultsController fetchedObjects];
}

- (NSFetchedResultsController<Student *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<Student *> *fetchRequest = Student.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Student *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    if([controller.cacheName isEqualToString:@"Master"]){
        //캐시 이름에 따라서 어떤 컨트롤러인지 구분 가능
    }
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:controller.fetchedObjects forKey:@"userInfo"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"afterChangeContent" object:nil userInfo:userInfo];
}

@end
