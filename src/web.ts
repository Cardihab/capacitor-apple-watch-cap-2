import { WebPlugin } from '@capacitor/core';
import { AppleWatchConnectivityPlugin } from './definitions';

export class AppleWatchConnectivityWeb extends WebPlugin implements AppleWatchConnectivityPlugin {
  constructor() {
    super({
      name: 'AppleWatchConnectivity',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async sendMessage(options: { messageId: string; message: [] }): Promise<void> {
    console.log(options);
    throw new Error("Method not implemented.");
  }
}

const AppleWatchConnectivity = new AppleWatchConnectivityWeb();

export { AppleWatchConnectivity };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(AppleWatchConnectivity);
