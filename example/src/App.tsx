import * as React from 'react';

import {
  StyleSheet,
  View,
  Text,
  Platform,
  TouchableOpacity,
  Alert,
} from 'react-native';
import Geolocation from '@react-native-community/geolocation';

import Landmarksid from 'react-native-landmarksid';

export default function App() {
  const [result, setResult] = React.useState<string | undefined>();
  const [location, setLocation] = React.useState<string | undefined>();

  const APP_ID_IOS = 'APP_ID_IOS';
  const APP_SECRET_IOS = 'APP_SECRET_IOS';

  const APP_ID_ANDROID = 'APP_ID_ANDROID';
  const APP_SECRET_ANDROID = 'APP_SECRET_ANDROID';

  const findCoordinates = () => {
    Geolocation.getCurrentPosition(
      (position) => {
        setLocation(JSON.stringify(position));
      },
      (error) => Alert.alert(error.message),
      { enableHighAccuracy: true, timeout: 20000, maximumAge: 1000 }
    );
  };

  React.useEffect(() => {
    let appId = APP_ID_IOS;
    let appSecret = APP_SECRET_IOS;
    if (Platform.OS === 'android') {
      appId = APP_ID_ANDROID;
      appSecret = APP_SECRET_ANDROID;
    }
    Landmarksid.initialize(appId, appSecret, {
      customerId: 'test-user',
      country: 'Germany',
      code: 49,
      score: 23.58,
    });
    setResult('Landmarkid initialized.');
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      <TouchableOpacity onPress={findCoordinates}>
        <Text>Find My Coords?</Text>
        <Text>Location: {location}</Text>
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
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
