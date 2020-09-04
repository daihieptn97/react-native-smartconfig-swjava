import {NativeEventEmitter, NativeModules} from 'react-native';

let {
  SmartconfigSwjava,
} = NativeModules;


const eventEmitter = new NativeEventEmitter(SmartconfigSwjava);
var subscription;

export const startSmartConfig = (ssid, bssid, password, timeScan, callback) => {
  if (typeof subscription !== 'undefined' && subscription) {
    subscription.remove();
  }
  subscription = eventEmitter.addListener('SmartConfig', callback);
  SmartconfigSwjava.start(ssid, bssid, password, timeScan, callback);
};

export const stopSmartConfig = () => {
  SmartconfigSwjava.stop();
};
