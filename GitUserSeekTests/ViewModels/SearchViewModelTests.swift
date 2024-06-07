import XCTest
import Combine
@testable import GitUserSeek

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var mockGitHubService: MockGitHubService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        // Setup mock data and errors as needed
        let mockUsers = [
            GitHubUser(
                id: 1,
                login: "testuser",
                avatar_url: "http://example.com/avatar.jpg",
                name: "Test User",
                company: "Test Corp",
                public_repos: 10,
                hireable: true)
        ]
        mockGitHubService = MockGitHubService(result: .success(mockUsers))
        viewModel = SearchViewModel(gitHubService: mockGitHubService)
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        mockGitHubService = nil
        super.tearDown()
    }

    func testFetchSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetching users successfully.")

        viewModel.$users.dropFirst().sink(receiveValue: { users in
            // Then
            XCTAssertNotNil(users)
            XCTAssertEqual(users.count, 1)
            XCTAssertEqual(users.first?.login, "testuser")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        // When
        viewModel.searchText = "test" 

        wait(for: [expectation], timeout: 1.0)
    }

    func testHandleError() {
        // Given
        let expectedError = URLError(.notConnectedToInternet)
        mockGitHubService.result = .failure(.network(expectedError))

        let expectation = XCTestExpectation(description: "Handling an error while fetching users.")

        viewModel.$errorMessage.dropFirst().sink(receiveValue: { errorMessage in
            // Then
            XCTAssertNotNil(errorMessage, "Error message should not be nil.")
            XCTAssertEqual(errorMessage, expectedError.localizedDescription, "Error message should match the expected error.")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        // When
        viewModel.searchText = "test"

        wait(for: [expectation], timeout: 2.0)
    }
}
