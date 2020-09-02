#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SmartconfigSwjava, NSObject)

RCT_EXTERN_METHOD(hahaha123123:(float)a withB:(float)b
                 withResolver:(RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(hihihiih:
                 (RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)


RCT_EXTERN_METHOD(startConfig:
                 (RCTPromiseResolveBlock)resolve
                 withRejecter:(RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(onUpdate)

@end
