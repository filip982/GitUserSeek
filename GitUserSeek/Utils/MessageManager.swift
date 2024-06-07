import Foundation
import UIKit.UIColor
import SwiftMessages

class MessageManager {
    @MainActor 
    static func showErrorMessage(_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "Error", body: message)
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.dimMode = .none
        config.interactiveHide = false

        SwiftMessages.show(config: config, view: view)
    }

    @MainActor 
    static func showSuccessMessage(_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "Success", body: message)
        SwiftMessages.show(view: view)
    }

    @MainActor 
    static func showInfoMessage(_ message: String) {
        let view = MessageView.viewFromNib(layout: .tabView)
        view.configureTheme(.info)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "Info", body: message)
        SwiftMessages.show(view: view)
    }

    @MainActor
    static func showNetworkStatus(isConnected: Bool) {
        
        SwiftMessages.hideAll()

        let statusMessage = isConnected ? "Connected" : "Disconnected"
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.backgroundView.backgroundColor = isConnected ? UIColor.green : UIColor.red
        view.bodyLabel?.textColor = UIColor.white
        view.configureContent(body: statusMessage)
        view.button?.isHidden = true

        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = isConnected ? .automatic : .forever
        config.dimMode = .none
        config.interactiveHide = false

        SwiftMessages.show(config: config, view: view)
    }
}
