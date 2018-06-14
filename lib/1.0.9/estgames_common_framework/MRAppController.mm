//
//  MRAppController.m
//  Unity-iPhone
//
//  Created by MRStudio on 25/05/2018.
//

#import "MRAppController.h"

//! kkw 180524 : emp
#import "EMPBridge-Swift.h"



@implementation MRAppController

- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    BOOL ret = [super application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return (ret && [[EMPNative shared] application_openURLWithSourceApplication:application open:url sourceApplication:sourceApplication annotation:annotation]);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //인터페이스만 있고 구현되지 않은 함수를 호출할려고 해서 에러가 나서 주석처리 해놨습니다.
    //BOOL ret = [super application:app openURL:url options:options];
    //return (ret && [[EMPNative shared] application_openURLWithOptionKey:app open:url options:options]);
    return ([[EMPNative shared] application_openURLWithOptionKey:app open:url options:options]);
}

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    BOOL ret = [super application:application didFinishLaunchingWithOptions:launchOptions];
    return ret && [[EMPNative shared] application_didFinishLaunchingWithOptions:application didFinishLaunchingWithOptions:launchOptions];
}

@end
