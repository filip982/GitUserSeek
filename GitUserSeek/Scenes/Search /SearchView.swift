import SwiftUI
import JGProgressHUD

struct SearchView: View {
    @EnvironmentObject private var networkMonitor: NetworkMonitor
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        NavigationView {
            VStack {
                
                // Input Field for Search
                TextField("Search users...", text: $viewModel.searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

                // Result list of users
                List(viewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        HStack {

                            UserImageView(url: user.avatarUrl, width: 50, height: 50)

                            Text(user.login)
                        }
                    }
                }
            }
            .background(Color(uiColor: UIColor(red: 0.48, green: 0.77, blue: 0.98, alpha: 1.00)))
            .navigationBarTitle("GitHub Users")
            // Loading Indicator
            .overlay(
                Group {
                    if viewModel.isLoading {
                        ProgressHUD(isShowing: $viewModel.isLoading, text: "Loading...")
                    }
                }
            )
            // Network status indicator in case the grid is off
            .onChange(of: viewModel.isConnected) {
                MessageManager.showNetworkStatus(isConnected: viewModel.isConnected)
            }
            // General error messages
            .onChange(of: viewModel.errorMessage) {
                MessageManager.showErrorMessage("Failed to fetch users: \(viewModel.errorMessage ?? "")")
            }
        }
    }
}

#Preview {
    SearchView()
}
