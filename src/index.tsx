import { NativeModules } from 'react-native';

type LandmarksidType = {
  initialize(appId: string, appSecret: string): Promise<void>;
};

const { Landmarksid } = NativeModules;

export default Landmarksid as LandmarksidType;
