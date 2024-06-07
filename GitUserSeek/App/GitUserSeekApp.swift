import SwiftUI

@main
struct GitUserSeekApp: App {
    // Network reachability should be globally accessible
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            SearchView()
        }
        .environmentObject(networkMonitor)
    }
}
