import { NativeModules } from 'react-native';

type LandmarksidType = {
  initialize(appId: string, appSecret: string): void;
};

const { Landmarksid } = NativeModules;

export default Landmarksid as LandmarksidType;
