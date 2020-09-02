import { NativeModules } from 'react-native';

type SmartconfigSwjavaType = {
  multiply(a: number, b: number): Promise<number>;
};

const { SmartconfigSwjava } = NativeModules;

export default SmartconfigSwjava as SmartconfigSwjavaType;
