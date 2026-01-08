import SwiftUI
import UIKit

@MainActor
func renderShareImage(text: String, reference: String, streakText: String?) -> UIImage? {
    let view = ShareCardView(text: text, reference: reference, streakText: streakText)
    let renderer = ImageRenderer(content: view)
    renderer.scale = UIScreen.main.scale
    return renderer.uiImage
}

