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
            ContentView()
        }
    }
}

struct VoiceKey: EnvironmentKey {
  static let defaultValue: Voice = {
    return Voice.mock
  }()
}

struct VoicesDataSourceKey: EnvironmentKey {
    static let defaultValue: VoicesDataSource = {
        return VoicesDataSource()
    }()
}

extension EnvironmentValues {
    var voicesDataSource: VoicesDataSource {
      get { self[VoicesDataSourceKey.self] }
      set { self[VoicesDataSourceKey.self] = newValue }
    }

    var voice: Voice {
        get { self[VoiceKey.self] }
        set { self[VoiceKey.self] = newValue }
    }
}
