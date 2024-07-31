//
//  LovoAIVoicesApp.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

@main
struct LovoAIVoicesApp: App {
    var body: some Scene {
        WindowGroup {
            if isNotTesting {
                ContentView()
            }
        }
    }
    private var isNotTesting: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
