//
//  TouchWindow.m
//  YBTouchIDToolDemo
//
//  Created by idbeny on 16/3/11.
//  Copyright © 2016年 https://github.com/idbeny/YBTouchID.git. All rights reserved.
//

#import "YBTouchIDTool.h"
#import <LocalAuthentication/LAContext.h>
#import <LocalAuthentication/LAError.h>

@interface YBTouchIDTool ()

@property (nonatomic, strong) UIWindow *rootWindow;

@property (nonatomic, strong) UIAlertAction *confirmAction;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, strong) LAContext *context;

@end

@implementation YBTouchIDTool

+ (instancetype)sharedInstance {
    static YBTouchIDTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YBTouchIDTool alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(applicationDidChangeStatusBarOrientation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    });
    return instance;
}

#pragma mark - UIApplicationDidChangeStatusBarOrientationNotification
- (void)applicationDidChangeStatusBarOrientation:(NSNotification *)notif {
    [self layoutSubViews];
    NSDictionary *userInfo = notif.userInfo;
    NSString *orientationKey = @"UIApplicationStatusBarOrientationUserInfoKey";
    if ([userInfo.allKeys containsObject:orientationKey]) {
        UIInterfaceOrientation orientation = [[userInfo valueForKey:orientationKey] integerValue];
        NSLog(@"%ld",orientation);
    }
}

- (void)layoutSubViews {
    
}

- (void)show {
    [self.rootWindow makeKeyAndVisible];
    self.rootWindow.hidden = NO;
    [self startEvaluateTouchID];
}

- (void)dismiss {
    [self.rootWindow resignKeyWindow];
    self.rootWindow.hidden = YES;
}

//successed,show animation
- (void)imageViewShowAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.rootWindow.rootViewController.view.alpha = 0.0;
            self.rootWindow.rootViewController.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
        } completion:^(BOOL finished) {
            [self dismiss];
        }];
    });
}

// 开始验证TouchID
- (void)startEvaluateTouchID {
    [self.alert dismissViewControllerAnimated:YES completion:nil];
    self.rootWindow.rootViewController = [UIViewController new];
    self.context = [[LAContext alloc] init];
    self.context.localizedFallbackTitle = @"输入密码";
    NSError *error;
    // 验证设备是否支持TouchID(具体策略对系统版本要求不一样，但最低系统版本需要iOS8)
    if([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        __weak typeof(self) weakSelf = self;
        [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"轻触Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self imageViewShowAnimation];
            } else {
                 LAError errorCode = error.code;
                [weakSelf touchEvaluateErrorCode:errorCode];
            }
        }];
    } else {
        [self alertTitle:@"暂不支持该设备" message:nil];
    }
}

//弹出提示框
- (void)alertTitle:(NSString *)title message:(NSString *)message {
    self.alert.title = title;
    self.alert.message = message;
    [self.rootWindow.rootViewController presentViewController:self.alert animated:YES completion:nil];
}

//touchID验证失败
- (void)touchEvaluateErrorCode:(LAError)errorCode {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *title = nil;
        switch (errorCode) {
            case LAErrorAuthenticationFailed://验证失败(连续三次指纹识别错误)
                title = @"验证失败，请使用密码或手势验证";
                break;
                
            case LAErrorUserCancel://用户取消验证(在TouchID对话框中点击了取消按钮)
                title = @"取消指纹验证";
                break;
                
            case LAErrorSystemCancel://系统取消验证(TouchID对话框被系统取消，例如按下Home或者电源键)
                title = @"暂时取消验证";
                break;
                
            case LAErrorUserFallback://选择输入密码(在TouchID对话框中点击了输入密码按钮)
                title = @"输入密码";
                break;
                
            case LAErrorPasscodeNotSet://设备未设置密码
                title = @"设备未设置密码";
                break;
                
            case LAErrorTouchIDNotAvailable://设备未设置Touch ID
                title = @"设备未设置TouchID";
                break;
                
            case LAErrorTouchIDNotEnrolled://用户未录入指纹
                title = @"未发现任何指纹";
                break;
                
            case LAErrorTouchIDLockout://连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                title = @"指纹输入错误";
                break;
                
            case LAErrorAppCancel://用户不能控制情况下APP被挂起
                title = @"验证失效";
                break;
                
            case LAErrorInvalidContext://LAContext传递给这个调用之前已经失效
                title = @"已失效，请稍后再试";
                break;
                
            default:
                break;
        }
        [self alertTitle:title message:nil];
    });
}

#pragma mark - Setter and Getter
- (UIWindow *)rootWindow {
    if (!_rootWindow) {
        _rootWindow = [[UIWindow alloc] init];
        _rootWindow.windowLevel = UIWindowLevelAlert;
        _rootWindow.rootViewController = [[UIViewController alloc] init];
    }
    return _rootWindow;
}

- (UIAlertController *)alert {
    if (!_alert) {
        _alert = [UIAlertController alertControllerWithTitle:@"验证失败" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [_alert addAction:cancelAction];
    }
    return _alert;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
