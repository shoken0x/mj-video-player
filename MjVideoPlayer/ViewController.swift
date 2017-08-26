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
    var videoPlayer : AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "test", ofType: "mp4")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVURLAsset(url: fileURL as URL, options: nil)
        let playerItem = AVPlayerItem(asset: avAsset)
        
        videoPlayer = AVPlayer(playerItem: playerItem)
        playerView.player = videoPlayer
        playerView.showsFullScreenToggleButton = true
        //videoPlayer.play()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

