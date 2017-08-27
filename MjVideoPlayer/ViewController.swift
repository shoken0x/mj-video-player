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
  var timerOffset = 1.5
  let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
  

  override func viewDidLoad() {
    super.viewDidLoad()
    let videoPath = homeDirURL.path + "/Downloads/mjvideo/001.mp4"
    let avAsset = AVURLAsset(url: URL(fileURLWithPath: videoPath))
    let playerItem = AVPlayerItem(asset: avAsset)

    logView.backgroundColor = NSColor.black
    logView.textColor = NSColor.green
    videoPlayer = AVPlayer(playerItem: playerItem)
    playerView.player = videoPlayer
    playerView.showsFullScreenToggleButton = true

    imageTimer = Timer.scheduledTimer(timeInterval: timerOffset, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
    imageTimer.fire()
    logTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateLog), userInfo: nil, repeats: true)
    logTimer.fire()
  }

  override func viewDidAppear() {
    super.viewDidAppear()
    graphView.layer?.backgroundColor = NSColor.black.cgColor
    self.view.window?.title = "Mj Video Player"
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  func updateImage(tm: Timer) {
    NSLog("update")
    logView.insertText("update\r", replacementRange: NSMakeRange(-1, 0))
    let prefix = "o_r_img_"
    let imageNum = String(format: "%04d", counter)
    let imagePath = homeDirURL.path + "/Downloads/cascade/" + prefix + imageNum + ".png"
    let graphPath = homeDirURL.path + "/Downloads/ssd/" + prefix + imageNum + ".png"
    NSLog(prefix + imageNum)
    logView.insertText(prefix + imageNum + "\r", replacementRange: NSMakeRange(-1, 0))
    
    if FileManager.default.fileExists(atPath: imagePath) {
      let imgAsset = NSImage(contentsOfFile: imagePath)
      let graphAsset = NSImage(contentsOfFile: graphPath)
      
      NSLog(imagePath)
      logView.insertText(imagePath + "\r", replacementRange: NSMakeRange(-1, 0))
      imageView.image = imgAsset
      graphView.image = graphAsset
    } else {
      NSLog("Image missing.")
    }
    counter = counter + 1

    if counter == 5 {
      timerOffset = 2.0
      imageTimer.invalidate()
      imageTimer = Timer.scheduledTimer(timeInterval: timerOffset, target: self, selector: #selector(self.updateImage), userInfo: nil, repeats: true)
      imageTimer.fire()
    }
    logView.insertText("timeOffset = " + String(timerOffset) + "\r", replacementRange: NSMakeRange(-1, 0))
  }

  func updateLog(tm: Timer) {
    let randomNum:UInt32 = arc4random_uniform(1000000)
    logView.insertText("update successful " + String(randomNum) + "\r", replacementRange: NSMakeRange(-1, 0))
  }
}

