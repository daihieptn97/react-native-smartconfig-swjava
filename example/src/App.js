import * as React from 'react';
import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import SmartconfigSwjava from 'react-native-smartconfig-swjava';
// import Geolocation from '@react-native-community/geolocation';

export default function App() {
  const [result, setResult] = React.useState();
  console.log(SmartconfigSwjava);
  console.log(SmartconfigSwjava.getConstants());


  React.useEffect(() => {

    let a = SmartconfigSwjava.onUpdate();
    console.log(a);
    // SmartconfigSwjava.hahaha123123(300, 7).then(setResult);

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

  });

  return (
    <View style={styles.container}>
      <Text>Result: {JSON.stringify(result)}</Text>
      <TouchableOpacity onPress={() => {
        SmartconfigSwjava.startConfig().then(setResult);

      }}>
        <Text>
          Config
        </Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
