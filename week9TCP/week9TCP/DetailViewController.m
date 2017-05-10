//
//  DetailViewController.m
//  week9TCP
//
//  Created by 최원영 on 2017. 5. 10..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *facePictureView;
@property NSMutableData *data;

@end

@implementation DetailViewController{
    NSURLSessionConfiguration *defaultConfiguration;
    NSURLSession *sessionWithADelegate;
    NSURLSessionStreamTask *sessionStreamTask;
    NSInputStream *facePictureInputStream;
    
    NSInteger len;
    NSMutableData *imageDataLen;
    NSInteger imageDataLenInteger;
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
}


- (void)URLSession:(NSURLSession *)session streamTask:(NSURLSessionStreamTask *)streamTask didBecomeInputStream:(NSInputStream *)inputStream outputStream:(NSOutputStream *)outputStream{
    
    //inputStream을 설정하고, 델리게이트를 지정한다.
    facePictureInputStream = inputStream;
    [facePictureInputStream setDelegate:self];
    [facePictureInputStream scheduleInRunLoop:[NSRunLoop mainRunLoop]
                                      forMode:NSDefaultRunLoopMode];
    
    [facePictureInputStream open];
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable: {
            if(!_data &&  !imageDataLen) {
                _data = [NSMutableData data];
                imageDataLen = [NSMutableData data];
            }
            uint8_t num[1024];
            uint8_t buf[1024];
            
            if(imageDataLenInteger == 0) {
                
                //8바이트 숫자를 먼저 읽어서 이미지 길이 Integer에 넣어둔다.
                len = [(NSInputStream *)aStream read:num maxLength:8];
                [imageDataLen appendBytes:num length:8];
                
                NSString *receivedDataString = [[NSString alloc] initWithData:imageDataLen encoding:NSUTF8StringEncoding];
                NSLog(@"%@",receivedDataString);
                imageDataLenInteger = [receivedDataString integerValue];
                
            }

            if( imageDataLenInteger > 1024 ) {
                //만약 데이터 길이가 버퍼보다 크다면 1024를 append하고, 남은 데이터 길이를 줄인다.
                [(NSInputStream *)aStream read:buf maxLength:1024];
                [_data appendBytes:(const void *)buf length:1024];
                imageDataLenInteger -= 1024;
                
            } else {
                //만약 데이터 길이가 버퍼보다 작다면 남은 데이터 길이만큼 데이터를 읽고
                [(NSInputStream *)aStream read:buf maxLength:imageDataLenInteger];
                [_data appendBytes:(const void *)buf length:imageDataLenInteger];
                
                //이미지를 만든 후 넣고,
                [_facePictureView setImage:[UIImage imageWithData:_data]];
                
                //_data를 리셋하고,
                _data = [[NSMutableData alloc] init];
                imageDataLen = [[NSMutableData alloc] init];
                
                //imageDataLenInteger를 0으로 바꾼다.
                imageDataLenInteger = 0;
            }
            
            break;
        }
        case NSStreamEventEndEncountered:
        {
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
            aStream = nil; // stream is ivar, so reinit it
            break;
        }
        default:
            break;
    }
    
}


- (void)URLSession:(NSURLSession *)session readClosedForStreamTask:(NSURLSessionStreamTask *)streamTask{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    len = 0;
    
    defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionWithADelegate = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:nil];
    sessionStreamTask = [sessionWithADelegate streamTaskWithHostName:@"localhost" port:8000];
    
    [sessionStreamTask resume];
    [sessionStreamTask captureStreams];
    [sessionStreamTask startSecureConnection];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    
}


@end
