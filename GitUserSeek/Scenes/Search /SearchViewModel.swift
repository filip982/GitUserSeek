import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var isConnected = true
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var users: [GitHubUser] = []
    @Published var errorMessage: String?

    private var networkMonitor = NetworkMonitor()
    private let gitHubService: GitHubService
    private var cancellables = Set<AnyCancellable>()

    init(
        gitHubService: GitHubService = GitHubServiceImpl()
    ) {
        self.gitHubService = gitHubService

        networkMonitor.$isConnected
                   .receive(on: RunLoop.main)
                   .assign(to: \.isConnected, on: self)
                   .store(in: &cancellables)

        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count > 1 }
            .sink(receiveValue: { [weak self] keyword in
                self?.fetchUsers(for: keyword)
            })
            .store(in: &cancellables)
    }

    func fetchUsers(for keyword: String) {
        guard isConnected, !keyword.isEmpty else {
            errorMessage = "No network connection or keyword is empty"
            return
        }
        isLoading = true
        gitHubService.fetchUsers(for: keyword)
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { users in
                self.users = users
            })
            .store(in: &cancellables)
    }
}
