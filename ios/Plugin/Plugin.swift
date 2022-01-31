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
        let message = call.getArray("message", NSDictionary.self)
        if let validSession = self.session {
            do {
                var payload = [] as [String]
                for m in message ?? [] {
                    let jsonData = try JSONSerialization.data(withJSONObject: m)
                    payload.append(String(data: jsonData, encoding: .utf8)!)
                }
                try validSession.updateApplicationContext([
                    "message": payload
                ])
            } catch {
                print(error)
            }
            call.resolve()
        } else {
            call.reject("No reachable session")
        }
    }
}

extension AppleWatchConnectivity: WCSessionDelegate {
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    public func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        DispatchQueue.main.async{
            self.notifyListeners("taskSelect", data: ["taskId": applicationContext["taskId"]], retainUntilConsumed: true)
        }
    }

    public func sessionDidBecomeInactive(_ session: WCSession) {
        // TODO:: Add hooks
    }

    public func sessionDidDeactivate(_ session: WCSession) {
        // TODO:: Add hooks
    }
}

