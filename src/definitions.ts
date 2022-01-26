declare module '@capacitor/core' {
  interface PluginRegistry {
    AppleWatchConnectivity: AppleWatchConnectivityPlugin;
  }
}

export interface AppleWatchConnectivityPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
