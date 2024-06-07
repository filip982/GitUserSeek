import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Search users...", text: $viewModel.searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            HStack {
                
                                UserImageView(url: user.avatarUrl, width: 50, height: 50)
                                
                                Text(user.login)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("GitHub Users")
        }
    }
}

#Preview {
    SearchView()
}
