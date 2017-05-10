//
//  DetailViewController.h
//  week9TCP
//
//  Created by 최원영 on 2017. 5. 10..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <NSURLSessionStreamDelegate, NSStreamDelegate>

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

