//
//  Network.swift
//  din
//
//  Created by Addin Satria on 08/10/21.
//

import SwiftUI
import Network

class Network: ObservableObject {
  
  @Published private(set) var connected: Bool = false
  
  let monitor = NWPathMonitor()
  let queue = DispatchQueue(label: "Monitor")
  
  init() {
    checkConnection()
  }
  
  func checkConnection() {
      monitor.pathUpdateHandler = { path in
          if path.status == .satisfied {
              self.connected = true
          } else {
              self.connected = false
          }
      }
      monitor.start(queue: queue)
  }
  
}

struct NetworkConnectivityIndicator: View {
  @StateObject var network = Network()
  var body: some View {
    if !network.connected {
      Text("we're not connected to the internet.")
        .foregroundColor(.white)
        .frame(width: .infinity)
        .background(Color.red)
    }
//    Text("We're \(network.connected ? "connected" : "not connected") to the Internet.")
//      .foregroundColor(network.connected ? .green : .red)
//      .padding()
  }
}
