//
//  LiveAndDetailViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 28/06/2021.
//

import UIKit
import LFLiveKit
import SocketIO
import IHKeyboardAvoiding
import IJKMediaFramework

class LiveAndDetailViewController: UIViewController{
    
    let socket = SocketManager(socketURL : URL(string: rtmpConfiguration.httpServer)!, config: [.log(true), .forceWebsockets(true)])
    
    let returnSocket = SocketManager(socketURL: URL(string: rtmpConfiguration.httpServer)!, config: [.log(true), .forcePolling(true)])
    
    var room: Room!
    var streamRunning : Bool = false
    var player : IJKFFMoviePlayerController!
    
    @IBOutlet var streamButton: UIButton!
    
    lazy var session : LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
        let session            = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.running = false;
        streamRunning = session.running
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startLive(_ sender: Any) {
        
        
        if(streamRunning == false)
        {
            
            room = Room(dict : [
                "title" : "Stream title test" as AnyObject,
                "key" : "1234" as AnyObject
            ])
            
            let stream = LFLiveStreamInfo()
            stream.url = "\(rtmpConfiguration.rtmpPushURL)\(room.key)"
            session.startLive(stream)
            
            socket.connect()
            socket.defaultSocket.once("connect", callback: {[weak self] data, ack in
                guard let this = self else {
                    return
                }
                
                this.socket.defaultSocket.emit("create_room", this.room.toDict())
            })
            
            streamButton.setTitle("Arrêter le live", for: .normal)
            session.running = true;
            streamRunning = session.running
    
            /*print("running -1")
            //Code to display the stream
            let streamUrlToPlay = rtmpConfiguration.rtmpPlayUrl + room.key
            
            player = IJKFFMoviePlayerController(contentURLString: streamUrlToPlay, with: IJKFFOptions.byDefault())
            player.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            player.view.frame = self.view.bounds
            self.view.addSubview(player.view)
            
            player.prepareToPlay()
            
            
            returnSocket.defaultSocket.on("connect") {[weak self] data, ack in
                
                self?.joinRoom()
                
            }
            
            print("running 0")
            
            player.play()
            self.returnSocket.connect()*/
            
        }
        else
        {
            session.running = false
            streamRunning = session.running
            streamButton.setTitle("Démarrer le live", for: .normal)
            stopLive()
        }
        
    }

    func joinRoom(){
        socket.defaultSocket.emit("join_room",room.key)
    }
    
    func stopLive() -> Void {
        guard room != nil else {
            return
        }
        
        session.stopLive()
        socket.disconnect()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LiveAndDetailViewController : LFLiveSessionDelegate {
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("Debug : \(debugInfo) ")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode)
    {
        print("ErrorCode : \(errorCode)")
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState)
    {
        
    }
    
}
