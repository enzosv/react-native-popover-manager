'use strict';

const AppContainer = require('AppContainer');
const I18nManager = require('I18nManager');
const Platform = require('Platform');
const React = require('React');
const StyleSheet = require('StyleSheet');
const View = require('View');

const requireNativeComponent = require('requireNativeComponent');
const PopoverView = requireNativeComponent('Popover', PopoverView);

const PropTypes = React.PropTypes;

class Popover extends React.Component {
  static propTypes = {

    originX: PropTypes.number,
    originY: PropTypes.number,
    originW: PropTypes.number,
    originH: PropTypes.number,
    popoverW: PropTypes.number,
    popoverH: PropTypes.number,
    /**
     * The `transparent` prop determines whether your modal will fill the entire view. Setting this to `true` will render the modal over a transparent background.
     */
    transparent: PropTypes.bool,
    /**
     * The `visible` prop determines whether your modal is visible.
     */
    visible: PropTypes.bool,
    /**
     * The `onRequestClose` callback is called when the user taps the hardware back button.
     * @platform android
     */
    onRequestClose: Platform.OS === 'android' ? PropTypes.func.isRequired : PropTypes.func,
    /**
     * The `onShow` prop allows passing a function that will be called once the modal has been shown.
     */
    onShow: PropTypes.func,
    /**
     * The `supportedOrientations` prop allows the modal to be rotated to any of the specified orientations.
     * On iOS, the modal is still restricted by what's specified in your app's Info.plist's UISupportedInterfaceOrientations field.
     * @platform ios
     */
    supportedOrientations: PropTypes.arrayOf(PropTypes.oneOf(['portrait', 'portrait-upside-down', 'landscape', 'landscape-left', 'landscape-right'])),
    /**
     * The `onOrientationChange` callback is called when the orientation changes while the modal is being displayed.
     * The orientation provided is only 'portrait' or 'landscape'. This callback is also called on initial render, regardless of the current orientation.
     * @platform ios
     */
    onOrientationChange: PropTypes.func,
  };

  static defaultProps = {
    visible: true,
  };

  static contextTypes = {
    rootTag: React.PropTypes.number,
  };

  render(): ?React.Element<any> {
    if (this.props.visible === false) {
      return null;
    }

    const containerStyles = {
      backgroundColor: this.props.transparent ? 'transparent' : 'white',
    };

    const innerChildren = __DEV__ ?
      ( <AppContainer rootTag={this.context.rootTag}>
          {this.props.children}
        </AppContainer>) :
      this.props.children;

    return (
      <PopoverView
        originX={this.props.originX}
        originY={this.props.originY}
        originW={this.props.originW}
        originH={this.props.originH}
        popoverW={this.props.popoverW}
        popoverH={this.props.popoverH}
        transparent={this.props.transparent}
        onRequestClose={this.props.onRequestClose}
        onShow={this.props.onShow}
        style={styles.modal}
        onStartShouldSetResponder={this._shouldSetResponder}
        supportedOrientations={this.props.supportedOrientations}
        onOrientationChange={this.props.onOrientationChange}
        >
        <View style={[styles.container, containerStyles]}>
          {innerChildren}
        </View>
      </PopoverView>
    );
  }

  // We don't want any responder events bubbling out of the modal.
  _shouldSetResponder(): boolean {
    return true;
  }
}

const side = I18nManager.isRTL ? 'right' : 'left';
const styles = StyleSheet.create({
  modal: {
    position: 'absolute',
  },
  container: {
    position: 'absolute',
    [side] : 0,
    top: 0,
  }
});

module.exports = Popover;
