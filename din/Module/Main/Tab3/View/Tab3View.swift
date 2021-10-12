//
//  Tab3View.swift
//  din
//
//  Created by Addin Satria on 10/10/21.
//

import SwiftUI

struct Tab3View: View {
  
  @State private var showPlayer = false
  
  var body: some View {
    ZStack {
      List {
        ForEach(0..<10) { _ in
          HStack {
            Image("default-image")
              .resizable()
              .scaledToFill()
              .frame(width: 60, height: 60)
              .clipped()
              .padding(.vertical, 5)
            VStack(alignment: .leading) {
              Text("Cerita Tentang Perang Badar")
                .font(.subheadline)
              Text("udin")
                .font(.callout)
                .foregroundColor(.gray)
            }
            Spacer()
            Text("1 minute")
              .font(.caption)
              .foregroundColor(.gray)
          }
          .onTapGesture {
            showPlayer.toggle()
          }
        }
      }
      .listStyle(PlainListStyle())
      if showPlayer {
        VStack {
          Spacer()
          HStack {
            Image("default-image")
              .resizable()
              .scaledToFill()
              .frame(width: 60, height: 60)
              .clipped()
              .padding(.vertical, 5)
            VStack(alignment: .leading) {
              Text("Cerita Tentang Perang Badar")
                .font(.subheadline)
              Text("udin")
                .font(.callout)
                .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "pause.fill")
              .resizable()
              .frame(width: 20, height: 20)
              .scaledToFit()
              .padding()
          }
          .padding(.leading)
          .background(Color.gray.opacity(0.5))
        }
        .transition(.move(edge: .bottom))
        .animation(.spring())
      }
    }
  }

}

struct Tab3View_Previews: PreviewProvider {
    static var previews: some View {
        Tab3View()
    }
}
