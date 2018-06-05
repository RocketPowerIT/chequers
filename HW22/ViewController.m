//
//  ViewController.m
//  HW22
//
//  Created by wolf on 30.05.18.
//  Copyright © 2018 wolf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(weak, nonatomic) UIView* druggingView;
@property(weak, nonatomic) UIView* boardView;
@property(assign,nonatomic) CGPoint prePosition;
@property(weak,nonatomic) UIView* bringToFront;
@property(strong, nonatomic) NSMutableArray* redCheckers;
@property(strong, nonatomic) NSMutableArray* cellsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    CGRect viewCell = CGRectMake(0.f, 0.f, 37.5f, 37.5f);
    CGRect rectRedChecker = CGRectMake(41.25f, 3.25f, 30, 30);
    
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIView* viewIndention = [[UIView alloc] init];
    viewIndention = [self viewCreatRectCell:CGRectMake(5, 129, 310, 310) colorViewRect:[UIColor blackColor] cornerRadius:0 parentView:self.view];
    
    UIView* viewBoard = [[UIView alloc] init];
    viewBoard = [self viewCreatRectCell:CGRectMake(5, 5, 300, 300) colorViewRect:[UIColor grayColor] cornerRadius:0 parentView:viewIndention];
    
    self.boardView = viewBoard;
    self.bringToFront = viewIndention;
    CGRect rectBlackChecker = CGRectMake(3.25f, CGRectGetMaxY(viewBoard.frame)-37.5f, 30, 30);
  

    
    for (NSInteger j = 0; j < 8; j++) {
        
        for (NSInteger i = 0; i < 4; i++) {
        
            UIView* viewAllBlackCell = [[UIView alloc] init];
        
            viewAllBlackCell = [self viewCreatRectCell:viewCell
                            colorViewRect:[UIColor whiteColor]
                                cornerRadius:0
                                parentView:viewBoard];
            __weak UIView* weakView = viewAllBlackCell;
            [self.cellsArray addObject:weakView];
            viewCell.origin.x += 75.f;
         
    
    }
        
                if(j%2) {
                    
                    viewCell.origin.x = 0.f;
                    
      
                } else {
            
                    viewCell.origin.x = 37.5f;
                }
        
        viewCell.origin.y += 37.5f;
    } //Creat all cells in board
   

    
    
    for (NSInteger j = 0; j < 3; j++) {
    for (NSInteger i = 0; i<4; i++) {
        
        UIView* viewRedChecker = [[UIView alloc] init];
        viewRedChecker = [self viewCreatRectCell:rectRedChecker colorViewRect:[UIColor greenColor] cornerRadius:10 parentView:viewBoard];
        
        rectRedChecker.origin.x +=75.f;
    }
    
        if (j%3) {
            rectRedChecker.origin.x = 41.25f;
        } else{
            rectRedChecker.origin.x = 3.25f;
        }
        
        rectRedChecker.origin.y += 37.5f;
        
        
    }
    
    
    for (NSInteger j = 0; j < 3; j++) {
        for (NSInteger i = 0; i<4; i++) {
            
            UIView* viewBlackChecker = [[UIView alloc] init];
            viewBlackChecker = [self viewCreatRectCell:rectBlackChecker colorViewRect:[UIColor blackColor] cornerRadius:10 parentView:viewBoard];

            
            rectBlackChecker.origin.x +=75.f;
        }
        
        if (j%3) {
            rectBlackChecker.origin.x = 3.25f;
        } else{
            rectBlackChecker.origin.x = 41.25f;
            
        }
        
        rectBlackChecker.origin.y -= 37.5f;
        
    }



}

#pragma mark - CreatMethod

- (UIView*) viewCreatRectCell: (CGRect) viewRect
                colorViewRect: (UIColor*) viewColor
                 cornerRadius: (CGFloat) viewCornerRadius
                   parentView:(UIView*) viewParent {
    UIView* viewLocal = [[UIView alloc] initWithFrame:viewRect];
    
    viewLocal.backgroundColor = viewColor;
    viewLocal.layer.cornerRadius = viewCornerRadius;
    [viewParent addSubview:viewLocal];
    
    viewLocal.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleTopMargin| UIViewAutoresizingFlexibleBottomMargin ;
    
    return viewLocal;
} //function creat cells


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) logTouches:(NSSet*) touches withMethod:(NSString*) methodName{
    
    NSMutableString* string = [NSMutableString stringWithString:methodName];
    for (UITouch* touch in touches) {
        CGPoint point = [touch locationInView:self.boardView];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
    }
    
    NSLog(@"%@", string);
}
/*
-(void) tochPoint:(NSSet*) touches {
    
    for(UITouch* touch in touches){
        
        CGPoint point = [touch locationInView:<#(nullable UIView *)#>]
    }
 }
*/


#pragma mark - Touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    UITouch* touch = [touches anyObject];
    
    CGPoint pointOfMainView  = [touch locationInView:self.boardView];
    
    UIView* view = [self.boardView hitTest:pointOfMainView withEvent:event];
    
    
    
    
    
    if (![view isEqual:self.boardView]) {
        
        self.druggingView = view;
        
        self.prePosition = view.center;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.druggingView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            self.druggingView.alpha = 0.3f;
        }];
        
        
        
    } else{
        
        self.druggingView = nil;
   
    }
    

    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [self logTouches:touches withMethod:@"touchesMoved"];
    
    if(self.druggingView){
         [self.view bringSubviewToFront:self.druggingView];
        UITouch* touch = [touches anyObject];
        
        CGPoint pointOfMainView  = [touch locationInView:self.boardView];

        
        self.druggingView.center = pointOfMainView;
    }
    UITouch* touch = [touches anyObject];
    
    CGPoint point  = [touch locationInView:self.boardView];
    
    if(![self.boardView pointInside:point withEvent:event]){
        
        self.druggingView.center = self.prePosition;
        [self onTouchesEnded];
        self.druggingView = nil;
        

    }
    
}
    
    


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    
    [self onTouchesEnded];
   

    
}
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    
    [self onTouchesEnded];
    
  
}

-(void) onTouchesEnded{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.druggingView.transform = CGAffineTransformIdentity;
        self.druggingView.alpha = 1.f;
    }];
    self.druggingView = nil;
    
}

@end
