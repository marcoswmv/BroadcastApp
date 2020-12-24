//
//  ViewController.swift
//  BroadcastApp
//
//  Created by Marcos Vicente on 23.12.2020.
//

import UIKit
import ReplayKit

class ViewController: UIViewController {
    
    var broadcastPicker: RPSystemBroadcastPickerView!
    
    var activityController: RPBroadcastActivityViewController!
    var broadcastController: RPBroadcastController!
    
    @IBAction func startBroadcast(_ sender: UIButton) {
        RPBroadcastActivityViewController.load(withPreferredExtension: "com.mwmv.BroadcastApp.BroadcastAppExtensionSetupUI") { [weak self] (broadcastAVC, error) in
            guard let self = self else { return }
            guard error == nil else {
                print("Can't load activity view controller")
                return
            }
            
            self.activityController = broadcastAVC
            self.activityController.delegate = self
            self.present(self.activityController, animated: true, completion: nil)
            
            
            if self.activityController.isBeingDismissed {
                print("Activity View Controller being dismissed")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    fileprivate func broadcastFromControlCenterPickerView() {
//        broadcastPicker = RPSystemBroadcastPickerView(frame: CGRect(x: UIScreen.main.bounds.minX,
//                                                                    y: UIScreen.main.bounds.minY,
//                                                                    width: UIScreen.main.bounds.width,
//                                                                    height: UIScreen.main.bounds.height))
//        broadcastPicker.backgroundColor = .yellow
//        broadcastPicker.preferredExtension = "com.mwmv.BroadcastApp.BroadcastAppExtension"
//        broadcastPicker.showsMicrophoneButton = true
//        
//        if let button = broadcastPicker.subviews.first as? UIButton {
//            button.setImage(UIImage(named: "screen"), for: .normal)
//        }
//        view.addSubview(broadcastPicker)
//    }
}

extension ViewController: RPBroadcastActivityViewControllerDelegate {
    
    func broadcastActivityViewController(_ broadcastActivityViewController: RPBroadcastActivityViewController, didFinishWith broadcastController: RPBroadcastController?, error: Error?) {
        guard error == nil else {
            print("Broadcast activity controller not available. \(error.debugDescription)")
            return
        }
        
        self.broadcastController = broadcastController
        broadcastActivityViewController.dismiss(animated: true) {
            self.broadcastController?.startBroadcast(handler: { (error) in
                if error == nil {
                    print("Broadcast started successfully")
                } else {
                    debugPrint("An error occurred: \(error.debugDescription)")
                }
            })
        }
    }
}
