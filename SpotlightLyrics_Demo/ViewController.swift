//
//  ViewController.swift
//  SpotlightLyrics_Demo
//
//  Created by Scott Rong on 2017/7/24.
//  Copyright © 2017年 jayasme. All rights reserved.
//

import UIKit
import SpotlightLyrics

class ViewController: UIViewController {
    
    @IBOutlet weak var lyricsView: LyricsView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    private let totalDuration: TimeInterval = 332
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Read the test LRC file
        guard
            let path = Bundle.main.path(forResource: "Santa Monica Dream", ofType: "lrc"),
            let stream = InputStream(fileAtPath: path)
        else {
            return
        }
        
        var data = Data.init()
        
        stream.open()
        let bufferSize = 1024
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        while (stream.hasBytesAvailable) {
            let read = stream.read(buffer, maxLength: bufferSize)
            data.append(buffer, count: read)
        }
        stream.close()
        buffer.deallocate()
        let lyrics = String(data: data, encoding: .utf8)
        
        // Initialize the SpotlightLyrics view
        lyricsView.lyrics = lyrics
        lyricsView.lyricFont = UIFont.systemFont(ofSize: 13)
        lyricsView.lyricTextColor = UIColor.lightGray
        lyricsView.lyricHighlightedFont = UIFont.systemFont(ofSize: 13)
        lyricsView.lyricHighlightedTextColor = UIColor.black
    }
    
    
    @IBAction func onStartButtonPress() {
        // unselected = stopped
        // selected = playing
        if (playButton.isSelected) {
            stop()
        } else {
            play()
        }
    }
    
    private func play() {
        playButton.isSelected = true
        lyricsView.timer.seek(toTime: 0)
        lyricsView.timer.play()
    }
    
    private func stop() {
        playButton.isSelected = false
        lyricsView.timer.pause()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

