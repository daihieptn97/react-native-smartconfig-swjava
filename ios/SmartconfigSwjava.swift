import UIKit

@objc(SmartconfigSwjava)
class SmartconfigSwjava: RCTEventEmitter {
    
    
    var SSID:String = ""
    var PASS:String = ""
    var BSSID:String = ""
    
    var isConfirmState: Bool!
    var condition:NSCondition!
    var esptouchTask: ESPTouchTask!
    //
    @objc var wifiPass = ""
    @objc var wifiName = "Thu Hung"
    var ipResult = "";
    
    init(fromString string: NSString) {
        super.init()
        condition = NSCondition()
    }
    
    convenience override init() {
        self.init(fromString:"John") // calls above mentioned controller with default name
    }
    
    
    /* Configuration result */
    func executeForResult(timeScan: Int) -> ESPTouchResult {
        print("executeForResult")
        // Sync lock
        condition.lock()
        // Get the parameters required for configuration
        esptouchTask = ESPTouchTask(apSsid: SSID, andApBssid: BSSID, andApPwd: PASS, andTimeoutMillisecond : Int32(timeScan))
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
    
    
    override func supportedEvents() -> [String]! {
        return [ "SmartConfig"]
    }
    
    func getResponseRN(data:ResultDataToRN) -> Any {
        return ["status": data.status , "message" : data.message, "data":  data.data, "ip": data.ip]
    }
    
    // Takes an errorCallback as a parameter so that you know when things go wrong.
    // This will make more sense once we get to the Javascript
    // ["status": "penđing smartconfig", "data" : nil]
    //
    
    @objc func stop(){
        self.cancel();
//        self.sendEvent(withName: "SmartConfig", body : "Cancel oke")
    }
    
    @objc(start:bssid:password:timeScan:errorCallback:) func start( ssid: String, bssid: String, password:String, timeScan: Int, errorCallback: @escaping RCTResponseSenderBlock) {
        print("wifiName", ssid, bssid, password)
        
        var res = ResultDataToRN()
        res.message = "penđing smartconfig"
        print(res)
        //self.sendEvent(withName: "SmartConfig", body: getResponseRN(data: res) )
        if !ssid.isEmpty {
            if !password.isEmpty {
                SSID = ssid
                PASS = password
                BSSID = bssid
                
                print("SSID" , SSID, "PASS", PASS)
                print("Configuration in progress...")
                
                res.message = "Configuration in progress... \(SSID) - \(PASS) - \(BSSID)" as NSString;
                
                //self.sendEvent(withName: "SmartConfig", body : self.getResponseRN(data: res))
                //resolve(["Configuration in progress..."])
                let queue = DispatchQueue.global(qos: .default)
                queue.async {
                    print("Thread is working...")
                    
                    res.message =  "Thread is working..."
                    //self.sendEvent(withName: "SmartConfig", body: self.getResponseRN(data: res))
                    
                    let esptouchResult: ESPTouchResult = self.executeForResult(timeScan: timeScan)
                    DispatchQueue.main.async(execute: {
                        if !esptouchResult.isCancelled {
                            print(" esptouchResult.description",  esptouchResult.description)
                            // IP拼接
                            
                            if (esptouchResult.getAddressString() != nil) {
                                res.data = esptouchResult.description;
                                res.status = true
                                res.message = "Smartconfig complate"
                                res.ip = esptouchResult.getAddressString()
                                self.sendEvent(withName: "SmartConfig", body: self.getResponseRN(data: res))
                            }else{
                                res.message = "Devives not found"
                                self.sendEvent(withName: "SmartConfig", body: self.getResponseRN(data: res))
                            }
                            
                            
                        }
                    })
                }
                
            } else {
                print("wifiPass null")
                res.message = "wifiPass null"
                self.sendEvent(withName: "SmartConfig", body: self.getResponseRN(data: res))
            }
            
        } else {
            print("wifi disconnected")
            res.message = "Wifi not connected";
            self.sendEvent(withName: "SmartConfig", body: self.getResponseRN(data: res))
            return
        }
    }
    
}


struct ResultDataToRN {
    var data: String = ""
    var status: Bool = false
    var message: NSString = ""
    var ip:String = ""
}
