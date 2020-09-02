import UIKit

@objc(SmartconfigSwjava)
class SmartconfigSwjava: NSObject {
    
    
    var SSID:String = ""
    var PASS:String = ""
    var BSSID:String = ""
    
    var isConfirmState: Bool!
    
    var condition:NSCondition!
    var esptouchTask: ESPTouchTask!
    //
    var wifiPass = "66668888"
    var wifiName = "Thu Hung"
    
    var ipResult = "";
    
    
    @objc(hahaha123123:withB:withResolver:withRejecter:)
    func hahaha123123(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(a*b*1000)
    }
    
    
    @objc(hihihiih:withRejecter:)
    func hihihiih(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve(["hello"  : 123])
    }
    
    @objc var onUpdate: RCTPromiseResolveBlock?
    
    
    @objc func sendUpdate() {
        if onUpdate != nil {
            print("onUpdate call ")
            onUpdate!(ipResult)
        }else {
            print("onUpdate null")
        }
    }
    
    @objc(startConfig:withRejecter:)
    func startConfig(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
        resolve("Pedding config")
        
        if isConnectWiFi() {
            if wifiPass != "" {
                SSID = getwifi().getSSID()!
                PASS = wifiPass
                BSSID = getwifi().getBSSID()!
                
                print("SSID" , SSID, "PASS", PASS)
                
                self.tapConfirmForResult(resolve: resolve, reject: reject)
                //                DispatchQueue.main.asyncAfter(deadline: .now() + 60.0) { // Change `2.0` to the desired number of seconds.
                //                    // Code you want to be delayed
                //                    print("End 15s")
                //                    self.cancel()
                //
                //                }
            } else {
                print("wifiPass null")
                resolve("wifiPass null");
            }
            
        } else {
            print("wifi disconnected")
            resolve("wifi disconnected");
            return
        }
    }
    
    init(fromString string: NSString) {
        super.init()
        condition = NSCondition()
        self.isConfirmState = false
        self.loadingNetworkStatus()
    }
    
    convenience override init() {
        self.init(fromString:"John") // calls above mentioned controller with default name
    }
    
    
    
    func isConnectWiFi() -> Bool {
        print("isConnectWiFi")
        let wifiSSID = getwifi().getSSID()
        return wifiSSID != nil ? true : false
    }
    
    func loadingNetworkStatus() {
        print("loadingNetworkStatus")
        let wifiSSID = getwifi().getSSID()
        
        guard wifiSSID != nil else {
            let text = NSLocalizedString("WIFI_DISCONNECTED", comment: "")
            wifiName = text
            return
        }
        let text = NSLocalizedString("WIFI_CONNECTED", comment: "")
        wifiName = text + wifiSSID!
    }
    
    
    func tapConfirmForResult(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) {
        print("tapConfirmForResult")
        //        resolve("tapConfirmForResult");
        self.ipResult = "tapConfirmForResult";
        self.sendUpdate();
        print("Configuration in progress...")
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            print("Thread is working...")
            let esptouchResult: ESPTouchResult = self.executeForResult()
            DispatchQueue.main.async(execute: {
                if !esptouchResult.isCancelled {
                    //                        UIAlertView(title: resultTitle, message: esptouchResult.description, delegate: nil, cancelButtonTitle: confirmSring).show()
                    print(" esptouchResult.description",  esptouchResult.description)
                    // IP拼接
                    
                    let strIP = String(esptouchResult.ipAddrData[0]) + "." + String(esptouchResult.ipAddrData[1]) + "." + String(esptouchResult.ipAddrData[2]) + "." + String(esptouchResult.ipAddrData[3])
                    print("⭕️\(strIP)")
                    self.ipResult = strIP;
                    self.sendUpdate();
                    //                        resolve(strIP)
                    
                }
            })
        }
        
    }
    
    
    
    /* Configuration result */
    func executeForResult() -> ESPTouchResult {
        print("executeForResult")
        // Sync lock
        condition.lock()
        // Get the parameters required for configuration
        esptouchTask = ESPTouchTask(apSsid: SSID, andApBssid: BSSID, andApPwd: PASS)
        // Set up proxy
        condition.unlock()
        let esptouchResult: ESPTouchResult = self.esptouchTask.executeForResult()
        return esptouchResult
    }
    
    /* Cancel distribution network */
    func cancel() {
        print("cancel")
        condition.lock()
        if self.esptouchTask != nil {
            self.esptouchTask.interrupt()
        }
        condition.unlock()
    }
    
}
