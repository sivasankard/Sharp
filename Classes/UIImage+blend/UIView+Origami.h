
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef double (^KeyframeParametricBlock)(double);
@interface CAKeyframeAnimation (Parametric)

+ (id)animationWithKeyPath:(NSString *)path 
                  function:(KeyframeParametricBlock)block
                 fromValue:(double)fromValue
                   toValue:(double)toValue;

@end



enum {
	XYOrigamiDirectionFromRight     = 0,
	XYOrigamiDirectionFromLeft      = 1,
    XYOrigamiDirectionFromTop       = 2,
    XYOrigamiDirectionFromBottom    = 3,
};
typedef NSUInteger XYOrigamiDirection;

enum {
	XYOrigamiTransitionStateIdle    = 0,
	XYOrigamiTransitionStateUpdate  = 1,
	XYOrigamiTransitionStateShow    = 2
};
typedef NSUInteger XYOrigamiTransitionState;


@interface UIView (Origami)

- (void)showOrigamiTransitionWith:(UIView *)view 
                    NumberOfFolds:(NSInteger)folds 
                         Duration:(CGFloat)duration
                        Direction:(XYOrigamiDirection)direction
                       completion:(void (^)(BOOL finished))completion;


- (void)hideOrigamiTransitionWith:(UIView *)view
                    NumberOfFolds:(NSInteger)folds
                         Duration:(CGFloat)duration
                        Direction:(XYOrigamiDirection)direction
                       completion:(void (^)(BOOL finished))completion;

@end
