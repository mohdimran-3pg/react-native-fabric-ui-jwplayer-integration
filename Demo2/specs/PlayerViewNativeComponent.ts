import type {
  HostComponent,
  ViewProps,
} from 'react-native';
import {codegenNativeComponent} from 'react-native';

export interface NativeProps extends ViewProps {
  sourceURL?: string;
}

export default codegenNativeComponent<NativeProps>(
  'CustomPlayerView',
) as HostComponent<NativeProps>;