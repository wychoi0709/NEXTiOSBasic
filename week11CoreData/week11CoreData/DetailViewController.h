//
//  DetailViewController.h
//  week11CoreData
//
//  Created by 최원영 on 2017. 5. 22..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "week11CoreData+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

