import SwiftUI

struct ShareCardView: View {
    let text: String
    let reference: String
    let streakText: String?

    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 24) {
                Text(text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .padding()

                Text(reference)
                    .font(.headline)
                    .foregroundStyle(.gray)

                if let streakText {
                    Text(streakText)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.orange)
                        .padding(.top, 16)
                }
            }
            .padding(40)
        }
        .frame(width: 800, height: 1200)
    }
}

