//
//  Tab3View.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import SwiftUI
import CoreMedia

struct Tab3View: View {
  
  @ObservedObject var presenter: Tab3Presenter
  
  @State var isReady = false
  
  var body: some View {
    audio
      .onChange(of: presenter.player.prepareToPlay(), perform: { newValue in
        self.isReady = newValue
        print("isready: \(isReady)")
      })
      .onAppear {
        setup()
        if presenter.audios.count == 0 {
          presenter.fetchAudio()
        }
        //        presenter.firstPlay(url: "https://firebasestorage.googleapis.com/v0/b/alpa-5e940.appspot.com/o/ALLAH%20AKAN%20GANTI.mp3?alt=media&token=2dcd5a6b-1da6-4112-93ef-0bdab00b0b67")
      }
      .navigationBarTitle("")
      .navigationBarHidden(true)
  }
  
}

extension Tab3View {
  
  var content: some View {
    audio
  }
  
  var audio: some View {
    ZStack {
      if presenter.isLoading {
        LoadingIndicator()
      } else if presenter.isError {
        ErrorIndicator(message: presenter.errorMessage)
      } else {
        List {
          ForEach(presenter.audios) { audio in
            Tab3AudioListView(audio: audio)
            .onTapGesture {
              presenter.selectAudio(audio)
              presenter.play(url: audio.file)
            }
          }
        }
        .listStyle(PlainListStyle())
        if presenter.isPlaying {
          VStack {
            Spacer()
          playIndicator
            .transition(.move(edge: .bottom))
            .animation(.spring())
          }
        }
      }
    }
    .animation(.spring())
  }
  
  var playIndicator: some View {
      HStack {
        Image("default-image")
          .resizable()
          .scaledToFill()
          .frame(width: 60, height: 60)
          .clipped()
          .padding(.vertical, 5)
        VStack(alignment: .leading) {
          Text(presenter.currentAudio.title)
            .font(.subheadline)
          Text(presenter.currentAudio.author)
            .font(.callout)
            .foregroundColor(.gray)
        }
        Spacer()
        Button(action: {
          presenter.togglePlayPause()
        }) {
          Image(systemName: presenter.isPaused ? "play.fill" : "pause.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .scaledToFit()
            .padding()
        }
      }
      .padding(.leading)
      .background(Color.gray.opacity(0.5))
      .padding(.bottom, 8)
  }
  
  func setup() {
    presenter.setupRemoteTransportControls()
    presenter.setupNowPlaying()
    presenter.setupNotifications()
  }
  
}
