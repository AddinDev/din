//
//  BoardingView.swift
//  din
//
//  Created by Addin Satria on 04/10/21.
//

import SwiftUI

struct OnBoardingView: View {
  
  let features: [(image: String, title: String, description: String)] = [
    (image: "person", title: "We have to communiate", description: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "),
    (image: "person", title: "We have to communiate", description: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla "),
    (image: "person", title: "We have to communiate", description: "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ")
  ]
  
  @Binding var showState: Bool
  
  var body: some View {
    VStack {
      Spacer()
      Text("What's din Can Do?")
        .font(.largeTitle)
        .fontWeight(.bold)
      Spacer()
      ForEach(0..<features.count) { index in
        OnBoardingList(features[index].image, features[index].title, features[index].description)
      }
      Spacer()
      Button(action: {
        showState = false
      }) {
        Text("Get Started")
          .foregroundColor(.white)
          .font(.headline)
          .padding()
          .padding(.horizontal, 100)
          .background(
            RoundedRectangle(cornerRadius: 15)
          )
      }
      .padding()
      Spacer()
    }
  }
}

struct OnBoardingList: View {
  var image: String
  var title: String
  var description: String
  
  init(_ image: String, _ title: String, _ description: String) {
    self.image = image
    self.title = title
    self.description = description
  }
  
  var body: some View {
    HStack {
      Image(systemName: image)
        .foregroundColor(.blue)
        .font(.title)
        .padding(7)
      VStack(alignment: .leading) {
        Text(title)
          .fontWeight(.semibold)
        Text(description)
          .foregroundColor(.gray)
      }
    }
    .padding(.horizontal)
    .padding(.vertical, 7)
  }
}

// struct BoardingView_Previews: PreviewProvider {
//  static var previews: some View {
//    OnBoardingView()
//  }
// }
