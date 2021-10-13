//
//  AudioPlayer.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import AVFoundation

class AudioPlayer: ObservableObject {
  
  @Published var isPlaying = false
  
  @Published var player = AVPlayer()
  
  @Published var currentAudio: AudioModel?
  
  init() {
    
  }
  
  func play(_ url: URL?) {
    if let url = url {
      do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
      } catch {
        print("TASKERROR AUDIO: \(error.localizedDescription)")
      }
      print("TASK AUDIO url: \(url)")
      player = AVPlayer(playerItem: AVPlayerItem(url: url))
      isPlaying = true
      player.play()
    }
  }
  
  func togglePlayer() {
    if isPlaying {
      player.pause()
    } else {
      player.play()
    }
    isPlaying.toggle()
  }
  
}
