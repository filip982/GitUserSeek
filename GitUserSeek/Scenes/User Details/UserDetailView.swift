import Foundation
import SwiftUI

struct UserDetailView: View {
    let user: GitHubUser

    var body: some View {
        VStack {

            UserImageView(url: user.avatarUrl, width: 150, height: 150)

            Text(user.login)
                .font(.largeTitle)

            Text(user.name ?? "No name available")

            Text(user.company ?? "No company available")

            Text("Repositories: \(user.public_repos ?? 0)")

            Text(user.hireable == true ? "Hireable" : "Not Hireable")

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: UIColor(red: 0.48, green: 0.77, blue: 0.98, alpha: 1.00)))
    }
}
