#import <React/RCTBridgeModule.h>
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_MODULE(SmartconfigSwjava, NSObject)

RCT_EXTERN_METHOD(hahaha123123:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(hihihiih:
                 (RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(startConfig:
                 (RCTResponseSenderBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(onUpdate)

RCT_EXPORT_VIEW_PROPERTY(wifiName, NSString)
RCT_EXPORT_VIEW_PROPERTY(wifiPass, NSString)

RCT_EXTERN_METHOD(doSomethingThatHasMultipleResults: (RCTResponseSenderBlock *)errorCallback )

@end
