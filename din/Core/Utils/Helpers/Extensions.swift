//
//  Extensions.swift
//  din
//
//  Created by Addin Satria on 10/11/21.
//

import SwiftUI

// easier onchange
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
