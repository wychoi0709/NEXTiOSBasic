//
//  GoView.m
//  week4
//
//  Created by 최원영 on 2017. 4. 5..
//  Copyright © 2017년 최원영. All rights reserved.
//

#import "GoView.h"
#import "GoCoordinate.h"
#import "GoGraph.h"

@implementation GoView {
    GoCoordinate *goCoordinate;
    GoGraph *goGraph;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //배경을 그린다.
    [self drawBackground];
    
    //라인을 그린다.
    for( int i = 0; i < 11; i ++ ) {
        [self drawLineWithStartXY: goCoordinate.coordinatePositionArray[0][i] withEndXY: goCoordinate.coordinatePositionArray[10][i]];
    }
    
    for( int i = 0; i < 11; i ++ ) {
        [self drawLineWithStartXY:goCoordinate.coordinatePositionArray[i][0] withEndXY:goCoordinate.coordinatePositionArray[i][10]];
    }
    
    //돌을 배치한다.
    [self drawStoneByGoCoordinate];
    
    //밑에 선을 그린다.
    [self drawBottomLine];
    
}


/**
 * 로딩 이후, 화면 너비에 따라서 보드를 초기화한다.
 */
- (void)awakeFromNib{
    [super awakeFromNib];
    
    //모델을 갱신하고, 화면을 그린다(모델 갱신을 여기서 하는게 맞을까? 뷰컨트롤러가 맞지 않을까?)
    //그렇다면, 뷰 컨트롤러에서 갱신한 모델을 여기서는 어떻게 불러오지?__________질문!!
    goCoordinate = [[GoCoordinate alloc] initWithTotalWidth:[UIScreen mainScreen].bounds.size.width];
    goGraph = [[GoGraph alloc] init];
    
}

/**
 *  배경을 그린다.
 */
- (void) drawBackground {
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGRect oakRect = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    UIImage *image = [UIImage imageNamed:@"oak.png"];
    CGContextDrawImage(c, oakRect, image.CGImage);
}

/**
 *  좌표에 따라 라인을 그린다.
 */
- (void) drawLineWithStartXY:(NSArray*)startCoordinate withEndXY:(NSArray*)endCoordinate {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake([startCoordinate[0] floatValue], [startCoordinate[1] floatValue]);
    [path moveToPoint:startPoint];
    CGPoint nextPoint = CGPointMake([endCoordinate[0] floatValue], [endCoordinate[1] floatValue]);
    [path addLineToPoint:nextPoint];
    [path setLineWidth:1.0];
    [path stroke];
    
}

/**
 * 터치되면 모델을 업데이트하고, 뷰를 갱신해달라고 한다.
 */
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    for ( int i = 0; i < 11; i++ ) {
        for ( int j = 0; j < 11; j++ ) {
            
            //x축 위치를 파악한다.
            if((([(goCoordinate.coordinatePositionArray[i][j])[0] floatValue]) - goCoordinate.individualWidth/2) <= (float)point.x && (float)point.x < (([(goCoordinate.coordinatePositionArray[i][j])[0] floatValue]) + goCoordinate.individualWidth/2 )){
                
                //y축 위치를 파악한다.
                if ((([(goCoordinate.coordinatePositionArray[i][j])[1] floatValue]) - goCoordinate.individualWidth/2) <= (float)point.y && (float)point.y < (([(goCoordinate.coordinatePositionArray[i][j])[1] floatValue]) + goCoordinate.individualWidth/2 )) {
                    
                    //위치 포착! i -> x // j -> y!! 모델을 업데이트하고 뷰 갱신
                    //해당 위치가 비어있다면, 업데이트!
                    if( [goCoordinate.coordinatePositionArray[i][j][2] boolValue] ) {
                        
                        if ( goCoordinate.isWhite ) {
                            goCoordinate.isWhite = false;
                            
                            //해당 위치를 검정돌로 표시한다.
                            [goCoordinate.coordinatePositionArray[i][j] replaceObjectAtIndex:3 withObject:@"black"];
                            
                            
                            
                            //해당 위치의 검정 돌 수를 추가한다.
                            NSInteger numberOfBlackStone = [(goGraph.graphLinePositionArray[j])[0] integerValue];
                            numberOfBlackStone ++;
                            [goGraph.graphLinePositionArray[j] replaceObjectAtIndex:0 withObject:[NSNumber numberWithInteger:numberOfBlackStone]];
                            
                        } else {
                            goCoordinate.isWhite = true;
                            
                            //해당 위치를 흰 돌로 표시한다.
                            [goCoordinate.coordinatePositionArray[i][j] replaceObjectAtIndex:3 withObject:@"white"];
                            
                            //해당 위치의 흰 돌 수를 추가한다.
                            NSInteger numberOfWhiteStone = [(goGraph.graphLinePositionArray[j])[1] integerValue];
                            numberOfWhiteStone ++;
                            [goGraph.graphLinePositionArray[j] replaceObjectAtIndex:1 withObject:[NSNumber numberWithInteger: numberOfWhiteStone]];
                            
                        }
                        
                        [goCoordinate.coordinatePositionArray[i][j] replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:NO]];
                        
                        [self setNeedsDisplay];
                    }
                    //안비어 있으면 패스
                    
                    
                }
            }
        }
        
    }
    
}

/**
 *  모델에 따라서 돌맹이를 그린다.
 */
- (void) drawStoneByGoCoordinate{
    
    for ( int i = 0; i < 11; i++ ) {
        for ( int j = 0; j < 11; j++ ) {
            //모델을 돌면서 위치를 파악하고 돌맹이를 그린다.
            
            //해당 위치가 비어있지 않다면,
            if( ![goCoordinate.coordinatePositionArray[i][j][2] boolValue] ) {
                
                //해당 위치에 돌맹이 뷰를 만들어 배치한다.
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([goCoordinate.coordinatePositionArray[i][j][0] floatValue]-goCoordinate.individualWidth/2, [goCoordinate.coordinatePositionArray[i][j][1] floatValue]-goCoordinate.individualWidth/2, goCoordinate.individualWidth, goCoordinate.individualWidth)];
                UIImage *image;
                
                if ( [goCoordinate.coordinatePositionArray[i][j][3] isEqualToString:@"black"] ) {
                    image = [UIImage imageNamed:@"black.png"];
                } else {
                    image = [UIImage imageNamed:@"white.png"];
                }
                
                imageView.image = image;
                [self addSubview:imageView];
            }
        }
    }
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if ( motion == UIEventSubtypeMotionShake ) {
        NSLog(@"흔들");
        
        [self.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
        
        [goCoordinate clearCoordinate];
        [goGraph clearGraph];
    }
}

- (void) drawBottomLine {
    
    for (int i=0; i < 11; i ++) {
        
        NSMutableArray *aLineArray = goGraph.graphLinePositionArray[i];
        NSInteger numberOfStone;
        
        if( aLineArray[0] < aLineArray[1] ) {
        
            //흰돌이 더 많다면
            _strokeColor = [UIColor whiteColor];
            numberOfStone = [aLineArray[1] integerValue];
        } else {
            
            //검정돌이 더 많다면
            _strokeColor = [UIColor blackColor];
            numberOfStone = [aLineArray[0] integerValue];
            
        }
        
        _startPointOfBottomLine = CGPointMake((([UIScreen mainScreen].bounds.size.width/11)*i) +(goCoordinate.individualWidth/2) , [UIScreen mainScreen].bounds.size.height);
        _endPointOfBottomLine = CGPointMake((([UIScreen mainScreen].bounds.size.width/11)*i) + (goCoordinate.individualWidth/2) , [UIScreen mainScreen].bounds.size.height - (goCoordinate.individualWidth *numberOfStone));
        
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:_startPointOfBottomLine];
        [path addLineToPoint:_endPointOfBottomLine];
        [path setLineWidth:goCoordinate.individualWidth];
        [_strokeColor setStroke];
        [path stroke];
        
    }
    
}


@end
