import SwiftUI
import UIKit

struct VerseSelectionShareView: View {
    let verses: [Verse]
    @ObservedObject var viewModel: DailyPassageViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedVerseIDs: Set<Int> = []
    @State private var shareAsImages = true
    @State private var shouldDismiss = false
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Share as Images", isOn: $shareAsImages)
                } header: {
                    Text("Share Format")
                } footer: {
                    Text(shareAsImages ? "Each verse will be shared as a separate image card." : "All selected verses will be combined into a single text message.")
                }
                
                Section {
                    ForEach(verses, id: \.id) { verse in
                        Button(action: {
                            if selectedVerseIDs.contains(verse.id) {
                                selectedVerseIDs.remove(verse.id)
                            } else {
                                selectedVerseIDs.insert(verse.id)
                            }
                        }) {
                            HStack {
                                Image(systemName: selectedVerseIDs.contains(verse.id) ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selectedVerseIDs.contains(verse.id) ? .blue : .secondary)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(verse.text)
                                        .font(.body)
                                        .foregroundStyle(.primary)
                                        .lineLimit(2)
                                    
                                    Text(verse.reference)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text("Select Verses")
                } footer: {
                    Text("Tap to select or deselect verses to share.")
                }
                
                Section {
                    Button(action: selectAll) {
                        Label("Select All", systemImage: "checkmark.circle.fill")
                    }
                    
                    Button(action: deselectAll) {
                        Label("Deselect All", systemImage: "circle")
                    }
                }
            }
            .navigationTitle("Share Verses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button("Share") {
                        handleShare()
                    }
                    .disabled(selectedVerseIDs.isEmpty)
                }
            }
            .onAppear {
                // Select all verses by default
                selectedVerseIDs = Set(verses.map { $0.id })
            }
            .onChange(of: shouldDismiss) { _, newValue in
                if newValue {
                    dismiss()
                }
            }
            .scrollContentBackground(.hidden)
            .background(theme.background)
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
    
    private func selectAll() {
        selectedVerseIDs = Set(verses.map { $0.id })
    }
    
    private func deselectAll() {
        selectedVerseIDs = []
    }
    
    private func handleShare() {
        let selectedVerses = verses.filter { selectedVerseIDs.contains($0.id) }
        guard !selectedVerses.isEmpty else { return }
        
        // Find the topmost view controller to present from (important when inside a sheet)
        guard let topViewController = findTopViewController() else {
            return
        }
        
        if shareAsImages {
            // Share multiple images
            let images = viewModel.shareMultipleVerses(selectedVerses)
            guard !images.isEmpty else { return }
            
            let controller = UIActivityViewController(activityItems: images, applicationActivities: nil)
            controller.completionWithItemsHandler = { _, _, _, _ in
                // Dismiss the selection view after sharing is complete
                DispatchQueue.main.async {
                    shouldDismiss = true
                }
            }
            
            // Configure for iPad
            if let popover = controller.popoverPresentationController {
                popover.sourceView = topViewController.view
                popover.sourceRect = CGRect(x: topViewController.view.bounds.midX, y: topViewController.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            topViewController.present(controller, animated: true)
        } else {
            // Share as combined text
            let text = viewModel.shareMultipleVersesAsText(selectedVerses)
            let controller = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            controller.completionWithItemsHandler = { _, _, _, _ in
                // Dismiss the selection view after sharing is complete
                DispatchQueue.main.async {
                    shouldDismiss = true
                }
            }
            
            // Configure for iPad
            if let popover = controller.popoverPresentationController {
                popover.sourceView = topViewController.view
                popover.sourceRect = CGRect(x: topViewController.view.bounds.midX, y: topViewController.view.bounds.midY, width: 0, height: 0)
                popover.permittedArrowDirections = []
            }
            
            topViewController.present(controller, animated: true)
        }
    }
    
    private func findTopViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        
        var topViewController = window.rootViewController
        while let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        
        return topViewController
    }
}

