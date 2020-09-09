# react-native-smartconfig-swjava

This library works only on ios. Not working android

## Installation
- step 1:
```sh
yarn add react-native-smartconfig-swjava
```
- step 2:
```sh
cd ios && pod install
```


## Props
- startSmartConfig (ssid, bssid, password, timeScan, callback): function
    - ssid(String): ssid wifi device connected
    - bssid(String): bssid wifi device connected
    - password(String): password wifi device connected
    - timeScan(millisecond): time find device smart config
    - callback(func): function response message.

- stopSmartConfig(): function

## Example

```js
import * as React from 'react';
import { ActivityIndicator, StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import { startSmartConfig, stopSmartConfig } from 'react-native-smartconfig-swjava';

// NetInfo check state network
// https://github.com/react-native-community/react-native-netinfo
import NetInfo from '@react-native-community/netinfo';

// NetworkInfo get ssid and bssid
// https://github.com/react-native-community/react-native-netinfo
import { NetworkInfo } from 'react-native-network-info';

export default function App() {
  const [result, setResult] = React.useState();
  const [ssid, setSsid] = React.useState();
  const [bssid, setBssid] = React.useState();
  const [password, setPassword] = React.useState('hamhoc123');


//Lấy thông tin ssid và bssid của wifi

  React.useEffect(() => {
    const setStateWifi = async () => {
      let ssid1 = await NetworkInfo.getSSID();
      if (typeof (ssid1) !== 'undefined') {
        setSsid(ssid1);
        let bssid1 = await NetworkInfo.getBSSID();
        setBssid(bssid1);
      } else {
        console.log('ssid undefine');
      }
    };

    setStateWifi();

    // Subscribe
    const unsubscribe = NetInfo.addEventListener(state => {
      console.log('Connection type', state.type);
      console.log('Is connected?', state.isConnected);
    });

    // Geolocation.requestAuthorization();
    // Geolocation.getCurrentPosition(info => console.log(info), e => {
    //   Alert.alert('Thông báo', 'Bạn cần cho phép quyền truy cập vị trí để sử dụng tính năng này', [
    //     {
    //       text: 'Đồng ý',
    //       onPress: () => {
    //         // this.props.navigation.goBack()
    //         Linking.openURL('app-settings:1');
    //       }
    //       ,
    //       style: 'cancel',
    //     },
    //   ]);
    // });

  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {JSON.stringify(result)}</Text>
      <ActivityIndicator size="large" color="#0000ff" />
      <TouchableOpacity
        style={{
          backgroundColor: 'green',
          width: 150,
          height: 60,
          alignItems: 'center',
          justifyContent: 'center',
          borderRadius: 12,
          margin: 12,
        }}
        onPress={() => {
          stopSmartConfig(ssid, bssid, password, 31000, (response) => {
            console.log(response);
            setResult(response);
          });
        }}>
        <Text style={{ color: 'white' }}>
          Config
        </Text>
      </TouchableOpacity>


      <TouchableOpacity
        style={{
          backgroundColor: 'orange',
          width: 150,
          height: 60,
          alignItems: 'center',
          justifyContent: 'center',
          borderRadius: 12,
          margin: 12,
        }}
        onPress={() => {
          stopSmartConfig();
        }}>
        <Text style={{ color: 'white' }}>
          Stop
        </Text>
      </TouchableOpacity>

    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});


```

