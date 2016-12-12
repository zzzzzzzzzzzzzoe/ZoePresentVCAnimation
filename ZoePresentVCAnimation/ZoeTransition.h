//
//  ZoeTransition.h
//  ZoePresentVCAnimation
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZoeTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic,assign) CGRect originFrame;
@property (nonatomic,copy) void(^dissmissBlock)();
@property (nonatomic,strong) NSNumber * duration;
@property (nonatomic,assign) BOOL presenting;
@end
