import { NativeModules } from 'react-native';

type LandmarksidType = {
  multiply(a: number, b: number): Promise<number>;
};

const { Landmarksid } = NativeModules;

export default Landmarksid as LandmarksidType;
