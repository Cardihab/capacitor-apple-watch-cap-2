import Foundation
import Capacitor
import WatchConnectivity

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AppleWatchConnectivity)
public class AppleWatchConnectivity: CAPPlugin {

    var session: WCSession?

    @objc override init!(bridge: CAPBridge!, pluginId: String!, pluginName: String!) {
        super.init(bridge: bridge, pluginId: pluginId, pluginName: pluginName)
        if WCSession.isSupported() {
            self.session = WCSession.default
            self.session?.delegate = self
            self.session?.activate()
        }
    }

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.success([
            "value": value
        ])
    }

    @objc func sendMessage(_ call: CAPPluginCall) {
        let messageId = call.getString("messageId") ?? ""
        let message = call.getArray("message", Any.self)
        if let validSession = self.session, validSession.isReachable {
            validSession.sendMessage(
                [
                    "messageId": messageId,
                    "message": message
                ], replyHandler: nil
            )
            call.resolve()
        } else {
            call.reject("No reachable session")
        }
    }
}

extension AppleWatchConnectivity: WCSessionDelegate {
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    public func sessionDidBecomeInactive(_ session: WCSession) {
        // TODO:: Add hooks
    }

    public func sessionDidDeactivate(_ session: WCSession) {
        // TODO:: Add hooks
    }
}

