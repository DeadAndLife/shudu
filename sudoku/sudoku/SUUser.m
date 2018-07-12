//
//  SUUser.m
//  sudoku
//
//  Created by iOSDeveloper on 2018/7/10.
//  Copyright © 2018年 iOSDeveloper. All rights reserved.
//

#import "SUUser.h"

#define  KEY_USERNAME_PASSWORD @"com.kuke99.kukeStudent.usernamepassword"

@implementation SUUser

+ (instancetype)defaultUser {
    DroiError *error = nil;
    SUUser *anonymousUser = [SUUser getCurrentUser];
    if (!anonymousUser) {
        anonymousUser = [SUUser loginWithAnonymous:&error];
        if (error.isOk && anonymousUser != nil) {
            // Login OK
            // ObjectId 为 User 的唯一 ID，每个 User 都有其独一无二的 ID
//            NSLog(@"User object id: %@", anonymousUser.objectId);
//            // SessionToken 为 User 成功登入后，服务器生成的 ID，对服务器所有动作都需要有合法的 SessionToken
//            NSLog(@"User session token: %@", anonymousUser.sessionToken);
        }
    }
    
    return anonymousUser;
}

+ (NSString *)getUUID {
    NSString * strUUID = (NSString *)[self load:KEY_USERNAME_PASSWORD];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [self save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    return strUUID;
}

#pragma mark - 钥匙串相关
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
