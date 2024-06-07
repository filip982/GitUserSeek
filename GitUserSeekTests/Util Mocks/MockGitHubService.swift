import Foundation
import Combine
@testable import GitUserSeek

class MockGitHubService: GitHubService {
    var result: Result<[GitHubUser], GitHubServiceError>

    init(result: Result<[GitHubUser], GitHubServiceError>) {
        self.result = result
    }

    func fetchUsers(for keyword: String) -> AnyPublisher<[GitHubUser], GitHubServiceError> {
        return result.publisher.eraseToAnyPublisher()
    }
}
