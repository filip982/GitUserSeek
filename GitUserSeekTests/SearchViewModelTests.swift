import XCTest
import Combine
@testable import GitUserSeek

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "Fetch users successfully")
        viewModel.$users
            .dropFirst()
            .sink { users in
                XCTAssertFalse(users.isEmpty)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchUsers(for: "apple")
        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchUsersFailure() {
        let expectation = XCTestExpectation(description: "Fetch users failure")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        viewModel.fetchUsers(for: "")
        wait(for: [expectation], timeout: 5.0)
    }
}
