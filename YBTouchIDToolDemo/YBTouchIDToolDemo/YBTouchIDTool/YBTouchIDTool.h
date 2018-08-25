//
//  YBTouchIDTool.h
//  YBTouchIDToolDemo
//
//  Created by idbeny on 16/3/11.
//  Copyright © 2016年 https://github.com/idbeny/YBTouchID.git. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBTouchIDTool : NSObject

+ (instancetype)sharedInstance;

- (void)show;
- (void)dismiss;

@end
