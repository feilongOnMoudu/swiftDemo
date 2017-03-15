//
//  AFNetwokingUtil.m
//  SwiftUtil
//
//  Created by 宋飞龙 on 17/3/13.
//  Copyright © 2017年 宋飞龙. All rights reserved.
//

#import "AFNetwokingUtil.h"
#import "AFNetworking.h"

@implementation AFNetwokingUtil

#define HTTP_TIME_OUT 20
//get json
+ (void)getJson:(NSString *)url
 withParameters:(NSDictionary *)parameters
        success:(RESPONSEOBJECT)success
        failure:(ERROR)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置超时时间(秒)
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    //支持https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        } else {
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%ld",(long)error.code);
        failure(error);
    }];
}

+ (void)postJson:(NSString *)url
  withParameters:(NSDictionary *)parameters
         success:(RESPONSEOBJECT)success
         failure:(ERROR)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置超时时间(秒)
    manager.requestSerializer.timeoutInterval = HTTP_TIME_OUT;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    //支持https
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;//是否允许使用自签名证书
    securityPolicy.validatesDomainName = NO;//是否需要验证域名
    manager.securityPolicy = securityPolicy;
    
    __weak typeof(manager) weakManager = manager;
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession * _Nonnull session, NSURLAuthenticationChallenge * _Nonnull challenge, NSURLCredential *__autoreleasing  _Nullable * _Nullable credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential * credent = nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if ([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credent = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString * p12 = [[NSBundle mainBundle] pathForResource:@"" ofType:@"p12"];
            NSFileManager * fileManager = [NSFileManager defaultManager];
            if (![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            } else {
                NSData * PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([[self class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]) {
                    SecCertificateRef certificate = NULL;
                    
                    SecIdentityCopyCertificate(identity, &certificate);
                    
                    const void*certs[] = {certificate};
                    
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                    credent =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        return disposition;
    }];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        } else {
            failure(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"#######%ld",(long)error.code);
        failure(error);
    }];
}

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data
{
    OSStatus securityError = errSecSuccess;
    
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"" forKey:(id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((CFDataRef)inPKCS12Data,(CFDictionaryRef)optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}


@end
