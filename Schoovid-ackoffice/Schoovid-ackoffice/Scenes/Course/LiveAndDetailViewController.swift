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

class LiveAndDetailViewController: UIViewController{
    
    let manager = SocketManager(socketURL : URL(string: rtmpConfiguration.httpServer)!, config: [.log(false), .forceWebsockets(true), .forcePolling(true)])
    
    var room: Room!
    var comments : [Comment] = []
    var streamRunning : Bool = false
    var user : User!
    var course : Course!
    var socket : SocketIOClient!

    @IBOutlet var updateBn: UIButton!
    @IBOutlet var streamButton: UIButton!
    @IBOutlet var chatTabView: UITableView!
    
    lazy var session : LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.high3, outputImageOrientation: .landscapeLeft)
        let session            = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        videoConfiguration?.videoSize = CGSize(width: 1280, height: 720)
        
        
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()
    
    //Set the newInstance method
    static func newInstance(user : User, course : Course) -> LiveAndDetailViewController
    {
        let controller = LiveAndDetailViewController()
        controller.user = user
        controller.course = course
        return controller
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        socket = self.manager.defaultSocket
        
        //Configure the table view
        self.chatTabView.delegate = self
        self.chatTabView.dataSource = self
        self.chatTabView.register(UINib(nibName : "ChatTableViewCell",bundle: nil), forCellReuseIdentifier: "comment-cell")
        self.chatTabView.layer.borderColor = UIColor.lightGray.cgColor
        self.chatTabView.layer.borderWidth = 1
        self.chatTabView.layer.cornerRadius = 5
        
        
        //Configure startLive button UI
        self.streamButton.layer.cornerRadius = 5
        self.streamButton.setTitle(NSLocalizedString("live.startLive", comment: ""), for: .normal)
        
        //Configure update button
        self.updateBn.setTitle(NSLocalizedString("create.course.modify", comment: ""), for: .normal)
        self.updateBn.layer.cornerRadius = 5
        
        self.room = Room(dict : [
            "title" : "\(course.libelle!)" as AnyObject,
            "key" : "\(course.id!)" as AnyObject
        ])
        
        socket.connect()
        
        socket.once("connect") {[weak self] data, ack in
            guard let this = self else {
                return
            }
            
            this.socket.emit("create_room", this.room.toDict())
        }
        
        session.running = false;
        streamRunning = session.running
        // Do any additional setup after loading the view.
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        socket.on("comment") {[weak self] data, ack in
            DispatchQueue.main.async { [self] in
                let comment = Comment(dict: data[0] as! [String: AnyObject])
                self?.comments.append(comment)
                self?.chatTabView.reloadData()
                self?.chatTabView?.scrollToBottomRow()
            }
        }
    }

    @IBAction func startLive(_ sender: Any) {
        
        
        if(streamRunning == false)
        {
            
            room = Room(dict : [
                "title" : "\(course.libelle!)" as AnyObject,
                "key" : "\(course.id!)" as AnyObject
            ])
            
            let stream = LFLiveStreamInfo()
            stream.url = "\(rtmpConfiguration.rtmpPushURL)\(room.key)"
            
            session.startLive(stream)
            
            streamButton.setTitle(NSLocalizedString("live.stopLive", comment: ""), for: .normal)
            session.running = true;
            streamRunning = session.running
    
        }
        else
        {
            session.running = false
            streamRunning = session.running
            streamButton.setTitle(NSLocalizedString("live.startLive", comment: ""), for: .normal)
            stopLive()
        }
    }
    
    func stopLive() -> Void {
        guard room != nil else {
            return
        }
        
        session.stopLive()
        socket.disconnect()
    }
    
    @IBAction func updateBn(_ sender: Any) {
        
        let createOrModifyController = CreateCourseViewController.newInstance(user: user, course: course, action: "Modifier")
        
        navigationController?.pushViewController(createOrModifyController, animated: true)
    }
    
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

extension LiveAndDetailViewController : UITableViewDelegate {
    
   
    
}

extension LiveAndDetailViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView();
        header.backgroundColor = UIColor.clear
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "comment-cell") as? ChatTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "comment-cell")
        }
        
        let comment = comments[indexPath.section]
        cell.nameAndCommentLabel.text = comment.username + " : " + comment.text
        return cell
    }
    
    
}

extension UITableView {
    func scrollToBottomRow(){
        DispatchQueue.main.async {
            guard self.numberOfSections > 0 else
            {
                return
            }
            
            var section = max(self.numberOfSections - 1 , 0)
            var row    = max(self.numberOfRows(inSection: section) - 1, 0)
            var indexPath = IndexPath(row: row, section: section)
            
            while(!self.isIndexPathValid(indexPath))
            {
                section = max(self.numberOfSections - 1 , 0)
                row    = max(self.numberOfRows(inSection: section) - 1, 0)
                indexPath = IndexPath(row: row, section: section)
                
                if(indexPath.section == 0)
                {
                    indexPath = IndexPath(row: 0, section: 0)
                    break
                }
            }
            
            guard self.isIndexPathValid(indexPath) else { return }
            
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func isIndexPathValid(_ indexPath : IndexPath) -> Bool
    {
        let section = indexPath.section
        let row     = indexPath.row
        return section < self.numberOfSections && row < self.numberOfRows(inSection: section)
    }
}




