/********* ping.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "Pingpp.h"



#define kNote             @"提示"
#define kConfirm          @"确定"
#define kErrorNet         @"网络错误"
#define kResult           @"支付结果：%@"


@interface ping : CDVPlugin

@property (nonatomic,strong)UIAlertView* mAlert;

@property (nonatomic, strong) NSString* myCallbackId;


- (void)pay:(CDVInvokedUrlCommand*)command;

@end

@implementation ping


- (void)pay:(CDVInvokedUrlCommand*)command
{
    
    NSString* myarg = [command.arguments objectAtIndex:0];
    
    if (myarg.length != 0) {
        
        self.myCallbackId = command.callbackId;
        
        
        
        NSString* URLScheme = nil;
        
        NSArray* URLTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
        if (URLTypes != nil) {
            NSDictionary* dict = [URLTypes objectAtIndex:0];
            if (dict != nil) {
                NSArray* URLSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
                if (URLSchemes != nil) {
                    URLScheme = [URLSchemes objectAtIndex:0];
                }
            }
        }
        
        
        
        __weak __typeof(self)weakSelf = self;
        
        [Pingpp createPayment:myarg viewController:weakSelf.viewController appURLScheme:URLScheme withCompletion:^(NSString *result, PingppError *error) {
            
            
            NSLog(@"completion block: %@", result);
            
            
            CDVPluginResult* pluginResult = nil;
            
            if ([result isEqualToString:@"success"]) {
                
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
            } else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:result];
                //NSLog(@"PingppError: code=%lu msg=%@", error.code, [error getMsg]); //支付失败
            }
            
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.myCallbackId];
            
            
            if (error == nil) {
                NSLog(@"PingppError is nil");
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
            }
            
            [weakSelf showAlertMessage:result];
            
        }];
    }else{
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"无参数,调起支付失败!"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }
    
    
}


- (void)showAlertWait
{
    self.mAlert = [[UIAlertView alloc] initWithTitle:@"正在获取支付凭据,请稍后..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    [self.mAlert show];
    
    UIActivityIndicatorView* aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    aiv.center = CGPointMake(self.mAlert.frame.size.width / 2.0f - 15, self.mAlert.frame.size.height / 2.0f + 10 );
    [aiv startAnimating];
    
    [self.mAlert addSubview:aiv];
}



- (void)hideAlert
{
    if (self.mAlert != nil)
    {
        [self.mAlert dismissWithClickedButtonIndex:0 animated:YES];
        self.mAlert = nil;
    }
}

- (void)showAlertMessage:(NSString*)msg
{
    self.mAlert = [[UIAlertView alloc] initWithTitle:kNote message:msg delegate:nil cancelButtonTitle:kConfirm otherButtonTitles:nil, nil];
    [self.mAlert show];
}





@end
