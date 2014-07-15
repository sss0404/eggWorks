//
//  Request.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/10.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "Request.h"
#import "Utils.h"
#import "JSON.h"

@implementation Request

@synthesize downloadData = _downloadData;
//@synthesize HUD = _HUD;
@synthesize asynRunner = _asynRunner;

- (void)dealloc
{
    [_downloadData release]; _downloadData = nil;
//    [_HUD release]; _HUD = nil;
    [_asynRunner release]; _asynRunner = nil;
    callback_ = nil;
    [super dealloc];
}

-(void)requestWithPostApiAndParameter:(NSString*)apiAndParameter withUrl:(NSString*)urlStr withCallBack:(callBack)callback method:(NSString*)method withView:(UIView*)view
{
//    self.HUD = [[[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
//    [view addSubview:_HUD];
//    [_HUD show:YES];
    
    callback_ = [callback copy];
    
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    [_asynRunner runOnBackground:^id{
        [self startWithUrl:urlStr apiAndParameter:apiAndParameter method:method];
        return @"";
    } onUpdateUI:^(id obj) {
        NSString * str = [[NSString alloc] initWithData:_downloadData encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonParser = [[[SBJsonParser alloc]init]autorelease];
        NSDictionary* dic = [jsonParser objectWithString:str];
        callback_(dic);
//        callback_();
    } inView:view];
    
//    [_HUD show:NO];
//    [_HUD hide:YES];
}


-(void)startWithUrl:(NSString*)urlStr apiAndParameter:(NSString*)apiAndParameter method:(NSString *)method
{
    self.downloadData = [[[NSMutableData alloc] init] autorelease];
    NSURL * url = [[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@%@",urlStr,apiAndParameter]] autorelease];;
    NSMutableURLRequest * urlRequest = [[[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60] autorelease];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest addValue:@"cdcf-ios-1.0.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest addValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [urlRequest setHTTPMethod:method];
    urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    while (nil != urlConn) {
        NSLog(@"1.....");
        //此处在等待，永远在等待。。。除非_connection = nil
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
        NSLog(@"2.....:");
    }
}


#pragma mark - NSURLConnection delegate method
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"--------didReceiveResponse--------------");
    int statusCode = [response statusCode];
    NSDictionary * headers = [response allHeaderFields];
    NSLog(@"headers:%@",headers);
    
}

long long curr = 0;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_downloadData appendData:data];
    NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"--------didReceiveData-------------------------:%@",str);
    
}

- (void)connection:(NSURLConnection *)connection
   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"----------------------------");
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"----------connectionDidFinishLoading-------------------");
    [urlConn cancel];
    [urlConn release]; urlConn = nil;
    
}

- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"=-----");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"---------didFailWithError-----------:%@",connection);
    [urlConn cancel];
    [urlConn release]; urlConn = nil;
//    callback_(nil);
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    return NO;
}

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"----willSendRequestForAuthenticationChallenge------");
    // 之前已经失败过
    if ([challenge previousFailureCount] > 0) {
        
        // 为什么失败
        NSError *failure = [challenge error];
        NSLog(@"Can't authenticate:%@", [failure localizedDescription]);
        
        // 放弃
        [[challenge sender] cancelAuthenticationChallenge:challenge];
//        callback_(nil);
        return;
    }
    
    NSString * account = [Utils getAccount];
    NSString * password = [Utils getPassword];
    
    // 创建 NSURLCredential 对象
    NSURLCredential *newCred = [NSURLCredential credentialWithUser:account
                                                          password:password
                                                       persistence:NSURLCredentialPersistenceNone];
    
    // 为 challenge 的发送方提供 credential
    [[challenge sender] useCredential:newCred
           forAuthenticationChallenge:challenge];
}

// Deprecated authentication delegates.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog(@"------didReceiveAuthenticationChallenge------");
}

//- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    NSLog(@"=======didCancelAuthenticationChallenge===========");
//}
@end
