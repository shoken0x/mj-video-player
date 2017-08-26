//
//  ViewController.swift
//  MjVideoPlayer
//
//  Created by Shoken Fujisaki on 2017/08/26.
//  Copyright © 2017 Shoken Fujisaki. All rights reserved.
//

import Cocoa
import AVKit
import Foundation
import AVFoundation

class ViewController: NSViewController {
    @IBOutlet weak var playerView: AVPlayerView!
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var logView: NSTextView!
    @IBOutlet weak var graphView: NSImageView!
    var videoPlayer : AVPlayer!
    var imageTimer: Timer!
    var logTimer: Timer!
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        logView.backgroundColor = NSColor.black
        logView.textColor = NSColor.green
        
        let videoPath = Bundle.main.path(forResource: "test", ofType: "mp4")
        let graphPath = Bundle.main.path(forResource: "loading", ofType: "gif")
        let graphAsset = NSImage(contentsOfFile: graphPath!)
        graphView.image = graphAsset
        graphView.layer?.backgroundColor = NSColor.black.cgColor
        graphView.animates = true

        
        let avAsset = AVURLAsset(url: URL(fileURLWithPath: videoPath!))
        let playerItem = AVPlayerItem(asset: avAsset)
        
        videoPlayer = AVPlayer(playerItem: playerItem)
        playerView.player = videoPlayer
        playerView.showsFullScreenToggleButton = true

        imageTimer = Timer.scheduledTimer(timeInterval: 1.7, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
        imageTimer.fire()
        logTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateLog), userInfo: nil, repeats: true)
        logTimer.fire()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.title = "Mj Video Player"
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func updateImage(tm: Timer) {
        NSLog("update")
        let prefix = "o_img_"
        let imageNum = String(format: "%05d", counter)
        let imagePath = Bundle.main.path(forResource: prefix + imageNum, ofType: "png")
        NSLog(prefix + imageNum)
        if imagePath != nil {
            let imgAsset = NSImage(contentsOfFile: imagePath!)
            NSLog(imagePath!)
            imageView.image = imgAsset
        } else {
            NSLog("Image missing.")
        }
        counter = counter + 1
    }
    
    func updateLog(tm: Timer) {
        let randomNum:UInt32 = arc4random_uniform(1000000)
        logView.insertText("update successful " + String(randomNum) + "\r", replacementRange: NSMakeRange(-1, 0))
    }
}

