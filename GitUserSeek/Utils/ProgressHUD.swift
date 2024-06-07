import Foundation
import SwiftUI
import JGProgressHUD

struct ProgressHUD: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    var text: String

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()  // Dummy controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isShowing {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = text
            hud.show(in: uiViewController.view)
            context.coordinator.hud = hud
        } else {
            context.coordinator.hud?.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var hud: JGProgressHUD?
        var parent: ProgressHUD

        init(_ parent: ProgressHUD) {
            self.parent = parent
        }
    }
}
