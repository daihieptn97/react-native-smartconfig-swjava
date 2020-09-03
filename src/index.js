import { NativeEventEmitter, NativeModules } from 'react-native';

let {
  SmartconfigSwjava,
} = NativeModules;

console.log(SmartconfigSwjava);

module.exports = {
  emitter: new NativeEventEmitter(SmartconfigSwjava),

  doSomethingThatHasMultipleResultsOK( callback) {
    this.emitter.addListener(
      'SmartConfig',
      name => callback('name000', name),
    );
    SmartconfigSwjava.doSomethingThatHasMultipleResults(callback);

  },
  ...SmartconfigSwjava
};
