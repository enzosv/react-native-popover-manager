# react-native-popover-manager
React Native Module to present popovers for iPad

This is just a fork of the [Modal](https://facebook.github.io/react-native/docs/modal.html) Component in the [React Native Project](https://github.com/facebook/react-native).

Modified files are: </br> 
[RCTModalHostView.h](https://github.com/facebook/react-native/blob/master/React/Views/RCTModalHostView.h), [RCTModalHostView.m](https://github.com/facebook/react-native/blob/master/React/Views/RCTModalHostView.m) (now [PopoverView](https://github.com/enzosv/react-native-popover-manager/tree/master/PopoverManager/PopoverView.h)), </br>
[RCTModalHostViewManager.h](https://github.com/facebook/react-native/blob/master/React/Views/RCTModalHostViewManager.h), [RCTModalHostViewManager.m](https://github.com/facebook/react-native/blob/master/React/Views/RCTModalHostViewManager.m) (now [PopoverManager](https://github.com/enzosv/react-native-popover-manager/tree/master/PopoverManager/PopoverManager.h)) </br>
and [Modal.js](https://github.com/facebook/react-native/blob/master/Libraries/Modal/Modal.js) now [popovermanager.js](https://github.com/enzosv/react-native-popover-manager/tree/master/popovermanager.js)

## Install
```shell
npm install --save react-native-popover-manager
react-native link react-native-popover-manager
```

## Example
```js
import React, { Component } from 'react';
import {
  Button
} from 'react-native';
import React, { Component } from 'react';
import {
  Text,
  View
} from 'react-native';
var Popover = require('react-native-popover-manager');
export default class PopoverExample extends Component {
  render() {
    return (
      <Popover
        originX={100}
        originY={100}
        originW={100}
        originH={100}
        popoverW={320}
        popoverH={200}>
        <View>
          <Text>
            I'm a popover
          </Text>
        </View>
      </Popover>
    );
  }
}
```