//
//  MusicPlayer.swift
//  Bloomy
//
//  Created by José Henrique Fernandes Silva on 11/12/20.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    
    func startBackgroundMusic(backgroundMusicFileName: String) {
        if let bundle = Bundle.main.path(forResource: backgroundMusicFileName, ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.prepareToPlay()
                audioPlayer.numberOfLoops = -1
                backgroundAudioPlayer?.volume = 0.5
                
                let stateSoundsSwitch = UserDefaults.standard.bool(forKey: UserDefaultsKeys.stateSoundsSwitch)
                if stateSoundsSwitch {
                    audioPlayer.play()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func changeStatePlayer(state: Bool) {
        if state {
            audioPlayer?.play()
        } else {
            audioPlayer?.pause()
        }
    }
}
