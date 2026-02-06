import SwiftUI

struct AppActionsMenuView: View {
    @ObservedObject var viewModel: DailyPassageViewModel
    @EnvironmentObject private var notificationManager: NotificationManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingSettings = false
    @State private var showingAbout = false
    @State private var showingDebugMenu = false
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button(action: { showingSettings = true }) {
                        Label("App Settings", systemImage: "gearshape")
                    }
                }
                
                Section {
                    Button(action: { handleRedownloadBible() }) {
                        Label("Re-download Bible", systemImage: "arrow.down.circle")
                    }
                    
                    Button(action: { handleCheckForUpdates() }) {
                        Label("Check for Updates", systemImage: "arrow.clockwise")
                    }
                }
                
                Section {
                    Button(action: { showingAbout = true }) {
                        Label("About", systemImage: "info.circle")
                    }
                }
                
                #if DEBUG
                Section {
                    Button(action: { showingDebugMenu = true }) {
                        Label("Debug Menu", systemImage: "ladybug")
                    }
                }
                #endif
            }
            .navigationTitle("Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(theme.background)
            .sheet(isPresented: $showingSettings) {
                AppSettingsView(viewModel: viewModel)
                    .environmentObject(notificationManager)
            }
            .sheet(isPresented: $showingAbout) {
                AboutView()
            }
            #if DEBUG
            .sheet(isPresented: $showingDebugMenu) {
                DebugMenuView(viewModel: viewModel)
            }
            #endif
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
    
    private func handleRedownloadBible() {
        // Placeholder: Re-download Bible data
        dismiss()
    }
    
    private func handleCheckForUpdates() {
        // Placeholder: Check for updates
        dismiss()
    }
}

// MARK: - App Settings View

struct AppSettingsView: View {
    @ObservedObject var viewModel: DailyPassageViewModel
    @EnvironmentObject private var notificationManager: NotificationManager
    @Environment(\.dismiss) private var dismiss
    @AppStorage("readingMode") private var readingMode: String = "default"
    @State private var reminderTime: Date = Date()
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Display")) {
                    Picker("Reading Mode", selection: $readingMode) {
                        Text("Default").tag("default")
                        Text("Night Mode").tag("night")
                        Text("Sepia").tag("sepia")
                    }
                }
                
                Section(header: Text("Notifications")) {
                    DatePicker("Reminder time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .onChange(of: reminderTime) { _, newValue in
                            let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                            notificationManager.updateNotificationTime(hour: components.hour ?? 8, minute: components.minute ?? 0)
                        }
                    Button("Enable Notifications") {
                        notificationManager.requestAuthorization()
                    }
                }
                
                Section(header: Text("Streak")) {
                    Button(role: .destructive) {
                        viewModel.resetStreak()
                        dismiss()
                    } label: {
                        Text("Reset Streak")
                    }
                }
            }
            .navigationTitle("App Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(theme.background)
            .onAppear {
                reminderTime = notificationManager.reminderDate()
            }
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
}

// MARK: - About View

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .center, spacing: 8) {
                        Text("Daily Verse Reading")
                            .font(.largeTitle.weight(.bold))
                        Text("Version 1.0.0")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                    
                    Text("Daily Verse Reading helps you build a daily Scripture reading habit. Passages are stored offline and rotate each day. Notifications are optional and configurable.")
                        .font(.body)
                        .padding(.horizontal)
                    
                    Section {
                        Text("Licenses")
                            .font(.headline)
                        Text("This app uses Bible verses from the public domain.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .background(theme.background)
        }
        .background(theme.background.ignoresSafeArea())
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
    }
}

// MARK: - Debug Menu View

#if DEBUG
struct DebugMenuView: View {
    @ObservedObject var viewModel: DailyPassageViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Debug Actions")) {
                    Button("Reset All Data") {
                        // Placeholder: Reset all app data
                        dismiss()
                    }
                    
                    Button("Export Debug Info") {
                        // Placeholder: Export debug information
                        dismiss()
                    }
                }
            }
            .navigationTitle("Debug Menu")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
#endif

