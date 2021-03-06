//
//  AudioPlayer.swift
//  din
//
//  Created by Addin Satria on 12/10/21.
//

import Foundation
import UIKit
import AVFoundation
import MediaPlayer

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
  
  var player = AVAudioPlayer()
  
  @Published var currentAudio: AudioModel = .empty()
  
  @Published var isPlaying = false
  @Published var isPaused = false
  
  func togglePlayPause() {
    if player.isPlaying {
      pause()
    } else {
      play()
    }
  }
  
  // "https://firebasestorage.googleapis.com/v0/b/alpa-5e940.appspot.com/o/ALLAH%20AKAN%20GANTI.mp3?alt=media&token=2dcd5a6b-1da6-4112-93ef-0bdab00b0b67"
  
  func play(_ audio: AudioModel) {
    
    currentAudio = audio
    
    let audioSession = AVAudioSession.sharedInstance()
    
    do {
      try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
    } catch let error as NSError {
      print("Setting category to AVAudioSessionCategoryPlayback failed: \(error)")
    }
    
    guard let fileURL = URL(string: audio.file) else { return }
    do {
      let soundData = try Data(contentsOf: fileURL)
      player = try AVAudioPlayer(data: soundData)
      player.prepareToPlay()
      play()
      print("TASK AUDIO DURATION: \(player.duration)")
    } catch let error as NSError {
      print("Failed to init audio player: \(error)")
    }
  }
  
  func play() {
    isPlaying = true
    isPaused = false
    player.play()
    updateNowPlaying(isPause: false)
    print("Play - current: \(currentAudio.title)")
  }
  
  func pause() {
    isPlaying = true
    isPaused = true
    player.pause()
    updateNowPlaying(isPause: true)
    print("Pause - current time: \(player.currentTime) - is playing: \(player.isPlaying)")
  }
  
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    if flag {
      print("TASK AUDIO FINISHED: \(flag)")
      isPlaying = false
      updateNowPlaying(isPause: true)
    } else {
      print("TASKERROR AUDIO: flag: \(flag)")
    }
  }
  
  func setupRemoteTransportControls() {
    // Get the shared MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()
    
    // Add handler for Play Command
    commandCenter.playCommand.addTarget { [unowned self] _ in
      print("Play command - is playing: \(self.player.isPlaying)")
      if !self.player.isPlaying {
        self.play()
        return .success
      }
      return .commandFailed
    }
    
    // Add handler for Pause Command
    commandCenter.pauseCommand.addTarget { [unowned self] _ in
      print("Pause command - is playing: \(self.player.isPlaying)")
      if self.player.isPlaying {
        self.pause()
        return .success
      }
      return .commandFailed
    }
  }
  
  func updateNowPlaying(isPause: Bool) {
    // Define Now Playing Info
    var nowPlayingInfo = [String: Any]()
    
    nowPlayingInfo[MPMediaItemPropertyTitle] = currentAudio.title
    nowPlayingInfo[MPMediaItemPropertyArtist] = currentAudio.author
    
    guard let coverURL = URL(string: currentAudio.cover) else { return }
    do {
      let imageData = try Data(contentsOf: coverURL)
      if let cover = UIImage(data: imageData) {
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: cover.size) { _ in
          return cover
        }
      }
    } catch let error as NSError {
      print("TASKERROR: cover: \(error.localizedDescription)")
    }
    
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
        
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = isPause ? 0 : 1
    
    // Set the metadata
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
  
  func setupNotifications() {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: #selector(handleInterruption),
                                   name: AVAudioSession.interruptionNotification,
                                   object: nil)
    notificationCenter.addObserver(self,
                                   selector: #selector(handleRouteChange),
                                   name: AVAudioSession.routeChangeNotification,
                                   object: nil)
  }
  
  // MARK: Handle Notifications
  @objc func handleRouteChange(notification: Notification) {
    guard let userInfo = notification.userInfo,
          let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
          let reason = AVAudioSession.RouteChangeReason(rawValue: reasonValue) else {
            return
          }
    switch reason {
      case .newDeviceAvailable:
        let session = AVAudioSession.sharedInstance()
        for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.headphones {
          print("headphones connected")
          DispatchQueue.main.sync {
            self.play()
          }
          break
        }
      case .oldDeviceUnavailable:
        if let previousRoute =
            userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
          for output in previousRoute.outputs where output.portType == AVAudioSession.Port.headphones {
            print("headphones disconnected")
            DispatchQueue.main.sync {
              self.pause()
            }
            break
          }
        }
      default: ()
    }
  }
  
  @objc func handleInterruption(notification: Notification) {
    guard let userInfo = notification.userInfo,
          let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
          let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
          }
    
    if type == .began {
      print("Interruption began")
      // Interruption began, take appropriate actions
    } else if type == .ended {
      if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
        let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
        if options.contains(.shouldResume) {
          // Interruption Ended - playback should resume
          print("Interruption Ended - playback should resume")
          play()
        } else {
          // Interruption Ended - playback should NOT resume
          print("Interruption Ended - playback should NOT resume")
        }
      }
    }
  }
  
}
