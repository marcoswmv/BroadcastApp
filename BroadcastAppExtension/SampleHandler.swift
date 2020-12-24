//
//  SampleHandler.swift
//  BroadcastAppExtension
//
//  Created by Marcos Vicente on 23.12.2020.
//

import ReplayKit
import VideoToolbox

class SampleHandler: RPBroadcastSampleHandler {

    var session: VTCompressionSession!
    
    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        
    }
    
    override func broadcastPaused() {
        // User has  requested to pause the broadcast. Samples will stop being delivered.
    }
    
    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }
    
    override func broadcastFinished() {
        // User has requested to finish the broadcast.
    }
    
    override func finishBroadcastWithError(_ error: Error) {
        
    }
    override func broadcastAnnotated(withApplicationInfo applicationInfo: [AnyHashable : Any]) {
        
    }
    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            let imageBuffer:CVImageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
            let pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer) as CMTime
            VTCompressionSessionEncodeFrame(session, imageBuffer: imageBuffer, presentationTimeStamp: pts, duration: CMTime.invalid, frameProperties: nil, sourceFrameRefcon: nil, infoFlagsOut: nil)
            
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("Unknown type of sample buffer")
        }
    }
}
