//
//  BroadcastSetupViewController.swift
//  BroadcastAppExtensionSetupUI
//
//  Created by Marcos Vicente on 23.12.2020.
//

import ReplayKit

class BroadcastSetupViewController: UIViewController {

    @IBOutlet weak var broadcastTitle: UITextField!
    
    @IBAction func broadcastOnFinishSetup(_ sender: Any) {
        self.userDidFinishSetup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Broadcast setup View Controller view did load!")
    }
    
    // Call this method when the user has finished interacting with the view controller and a broadcast stream can start
    func userDidFinishSetup() {
        // URL of the resource where broadcast can be viewed that will be returned to the application
        let broadcastURL = URL(string:"http://apple.com/broadcast/streamID")
        
        // Dictionary with setup information that will be provided to broadcast extension when broadcast is started
        let setupInfo: [String : NSCoding & NSObjectProtocol] = ["broadcastTitle": broadcastTitle.text! as NSCoding & NSObjectProtocol]
        
        // Tell ReplayKit that the extension is finished setting up and can begin broadcasting
        self.extensionContext?.completeRequest(withBroadcast: broadcastURL!, setupInfo: setupInfo)
    }
    
    func userDidCancelSetup() {
        let error = NSError(domain: "YouAppDomain", code: -1, userInfo: nil)
        // Tell ReplayKit that the extension was cancelled by the user
        self.extensionContext?.cancelRequest(withError: error)
    }
}
