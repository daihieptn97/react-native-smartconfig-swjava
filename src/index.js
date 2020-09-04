import { NativeEventEmitter, NativeModules } from 'react-native';

let {
  SmartconfigSwjava,
} = NativeModules;

console.log(SmartconfigSwjava);

module.exports = {
  emitter: new NativeEventEmitter(SmartconfigSwjava),
  start(ssid, bssid, password, timeScan, callback) {
    this.emitter.addListener(
      'SmartConfig',
      response => callback(response),
    );
    SmartconfigSwjava.start(ssid, bssid, password, timeScan, callback);
  },
  stop() {
    SmartconfigSwjava.stop();
  },
};
