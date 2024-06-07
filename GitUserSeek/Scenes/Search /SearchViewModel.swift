import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var users: [GitHubUser] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let gitHubService = GitHubService()

    init() {
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
        guard keyword.count > 1 else { return }
        isLoading = true
        gitHubService.fetchUsers(for: keyword)
            .throttle(for: .seconds(1), scheduler: RunLoop.main, latest: true)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { users in
                self.users = users
                self.errorMessage = nil
            })
            .store(in: &cancellables)
    }
}

