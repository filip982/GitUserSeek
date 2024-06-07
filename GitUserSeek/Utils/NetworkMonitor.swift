import Foundation
import Alamofire

class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true
    private var reachabilityManager = NetworkReachabilityManager()

    init() {
        reachabilityManager?.startListening { status in
            switch status {
            case .notReachable:
                self.isConnected = false
            case .reachable(_), .unknown:
                self.isConnected = true
            }
        }
    }
}

