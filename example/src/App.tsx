import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import Landmarksid from 'react-native-landmarksid';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  const appId = 'APP_ID';
  const appSecret = 'APP_SECRET';

  React.useEffect(() => {
    Landmarksid.initialize(appId, appSecret, {
      customerId: 'test-user',
      country: 'Germany',
      code: 49,
      score: 23.58,
    });
    setResult(0);
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
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
