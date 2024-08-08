//
//  SpeakersListItemView.swift
//  LovoAISpeakers
//
//  Created by Robbie Elliott on 2024-02-08.
//

import SwiftUI

struct SpeakersListItemView: View {
    var viewModel: SpeakerViewModel
    @Environment(ImageCache.self) private var imageCache
    private let locale: Locale = .current

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                if let personImage = imageCache.getImage(for: viewModel.speakerId) {
                    StyledImageView(image: personImage)
                } else {
                    ProgressView()
                        .onAppear() {
                            imageCache.fetchImage(for: viewModel)
                        }
                }
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.name)")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)

                    Text("\(Locale.current.language(cultureCode: viewModel.locale) ?? "".capitalized) \(viewModel.gender.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
                
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.clear)
                        .frame(width: 30, height: 30)
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .frame(width: 350)
            .background(Color.primary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .cornerRadius(12)
        }
        .frame(width: 250, height: 350)
    }
}

struct SpeakersListItemView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakersListItemView(viewModel: .init(speaker: .mock))
            .previewLayout(.sizeThatFits)
    }
}
