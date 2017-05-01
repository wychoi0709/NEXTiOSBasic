//
//  ViewController.m
//  week7
//
//  Created by 최원영 on 2017. 4. 26..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *imageListView;
@property NSMutableArray *imageCacheArray;
@property NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *motherViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *motherViewOfImages;
@property NSMutableArray *indexHeightArray;
@property int currentIndex;
@property UIView *motherViewOfImageViews;
@property NSMutableArray *cgrectArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //스크롤 뷰 델리게이트 설정
    _imageListView.delegate = self;
    _imageCacheArray = [[NSMutableArray alloc] init];
    _indexHeightArray = [[NSMutableArray alloc] init];
    _imageArray = [[NSMutableArray alloc] init];
    _cgrectArray = [[NSMutableArray alloc] init];
    
    //이미지 배열 생성
    [self setImageArray];
    
    [self initImageCacheArray];
    [self initScrollView];
    
    //스크롤 뷰 세팅
    [self setScrollView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int index = 0;
    
    NSLog(@"offset 정보 %f", scrollView.contentOffset.y);
    for (int i = 0; i < _indexHeightArray.count; i++) {
        if( scrollView.contentOffset.y < [((NSNumber*)_indexHeightArray[i]) floatValue] ){
            index = i;
            break;
        }
    }
    
    if( _currentIndex != index ){
        [_imageCacheArray removeAllObjects];
        for ( int i = index; i < index + 4; i++ ) {
            if( i == 21 ){
                [_imageCacheArray addObject:_imageArray[i]];
                break;
            } else {
                [_imageCacheArray addObject:_imageArray[i]];
            }
        }
        _currentIndex = index;
        [self setScrollView];
    }
    
    
}


/**
 *  모든 이미지 배열을 만드는 메소드
 */
- (void)setImageArray{
    
    NSString *nameOfImage;
    float yOrigin = 0.0f;
    
    for (int i = 1; i < 23; i++) {
        if(i < 10) {
            nameOfImage = [@"0" stringByAppendingString: [NSString stringWithFormat:@"%d", i]];
        } else {
            nameOfImage = [NSString stringWithFormat:@"%d", i];
        }
        
        nameOfImage = [nameOfImage stringByAppendingString:@".jpg"];
        
        UIImage *imageForScrollView = [UIImage imageNamed:nameOfImage];
        
        UIImageView *imageViewForScrollView = [[UIImageView alloc] initWithImage:imageForScrollView];
        imageViewForScrollView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGRect frameRect = imageViewForScrollView.frame;
        frameRect.size.width = [UIScreen mainScreen].bounds.size.width;
        frameRect.size.height = [UIScreen mainScreen].bounds.size.width * imageViewForScrollView.frame.size.height / imageViewForScrollView.frame.size.width;
        frameRect.origin.y = yOrigin;
        
        [_cgrectArray addObject:[NSValue valueWithCGRect:frameRect]];
        [_indexHeightArray addObject:[NSNumber numberWithFloat: yOrigin]];
        yOrigin += imageViewForScrollView.frame.size.height;
        
//        [_imageArray addObject:imageViewForScrollView];
    }
    
    NSLog(@"imageCacheArray: %@", _imageArray);
    
}


/**
 *  스크롤 뷰에 이미지 뷰를 붙이는 메소드
 */
- (void)setScrollView{

    // 이미지 뷰를 붙인다.
    for (int i = 0; i < _imageCacheArray.count; i++) {
        [_motherViewOfImageViews addSubview:_imageCacheArray[i]];
    }
    
    [_imageListView addSubview:_motherViewOfImageViews];
}


/**
 *  스크롤뷰의 높이를 초기화하는 메소드
 */
- (void) initScrollView{
    
    //서브 뷰의 총 높이를 구한다.
    float totalHeight = 0;
    for (int i = 0; i < _imageArray.count-1; i++) {
        
        totalHeight += ((UIImageView*)_imageArray[i]).frame.size.height;
    }
    
    NSLayoutConstraint *newHeight = [NSLayoutConstraint constraintWithItem:_motherViewHeightConstraint.firstItem attribute:_motherViewHeightConstraint.firstAttribute relatedBy:NSLayoutRelationEqual toItem:_motherViewHeightConstraint.secondItem attribute:_motherViewHeightConstraint.secondAttribute multiplier:1 constant:totalHeight];
    [_imageListView removeConstraint:_motherViewHeightConstraint];
    [_imageListView addConstraint:newHeight];
    
    
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, totalHeight);
    _motherViewOfImageViews = [[UIView alloc] initWithFrame:frame];
    
}


/**
 *  초기화 캐시 배열을 만드는 메소드
 */
- (void) initImageCacheArray{
    for ( int i = 0; i < 4; i++ ) {
        [_imageCacheArray addObject:_imageArray[i]];
    }
    
}

@end
