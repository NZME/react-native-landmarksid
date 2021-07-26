# react-native-landmarksid

React native bridge for landmarksid location tracking

## Installation

```sh
npm install react-native-landmarksid
```

Include the LandmarksID pod in the Podfile. Usually located in `iod/Podfile`
```
pod 'LandmarksID/LO', :git => 'https://github.com/LANDMARKSID/LandmarksID-iOS.git', :tag => '2.5.1'
```

## Usage

```js
import Landmarksid from "react-native-landmarksid";

// ...

const result = await Landmarksid.initialize('APP_ID', 'APP_SECRET');
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
