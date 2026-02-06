import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: DailyPassageViewModel
    @EnvironmentObject private var notificationManager: NotificationManager
    @State private var reminderTime: Date = Date()
    @AppStorage("readingMode") private var readingMode = "default"
    
    private var theme: ReadingTheme {
        ReadingTheme.from(rawValue: readingMode)
    }

    var body: some View {
        Form {
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
                } label: {
                    Text("Reset Streak")
                }
            }

            Section(header: Text("About")) {
                Text("Daily Verse Reading helps you build a daily Scripture habit. Passages are stored offline and rotate each day. Notifications are optional and configurable.")
                
                Link("Privacy Policy", destination: URL(string: "https://luknarz.github.io/dailyverse-support/privacy.html")!)
                    .foregroundColor(theme.accent)
                
                Link("Support", destination: URL(string: "https://luknarz.github.io/dailyverse-support/")!)
                    .foregroundColor(theme.accent)
            }
        }
        .navigationTitle("Settings")
        .scrollContentBackground(.hidden)
        .background(theme.background)
        .preferredColorScheme(theme.colorScheme)
        .tint(theme.accent)
        .onAppear {
            reminderTime = notificationManager.reminderDate()
        }
    }
}
