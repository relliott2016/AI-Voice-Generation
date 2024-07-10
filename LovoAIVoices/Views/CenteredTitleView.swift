//
//  CenteredTitleView.swift
//  LovoAIVoices
//
//  Created by Robbie Elliott on 2024-07-09.
//

import SwiftUI

struct CenteredTitleView: View {
    var title: String

    var body: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.title)
                .bold()
                .navigationBarTitleDisplayMode(.inline)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CenteredTitleView(title: Voice.mock.displayName)
}
