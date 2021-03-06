import { NativeModules } from 'react-native';

type LandmarksidType = {
  initialize(
    appId: string,
    appSecret: string,
    options?: Record<string, string | number>
  ): void;
  startTracking(): void;
  stopTracking(): void;
  setCustomData(options: Record<string, string | number>): void;
};

const { Landmarksid } = NativeModules;

export default Landmarksid as LandmarksidType;
