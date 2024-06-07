import Foundation
import Combine
import Alamofire

enum GitHubServiceError: Error, LocalizedError {
    case invalidURL
    case network(Error)
    case server
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .network(let error):
            return error.localizedDescription
        case .server:
            return "A server error occurred. Please try again later."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

class GitHubService {
    
    func fetchUsers(for keyword: String) -> AnyPublisher<[GitHubUser], GitHubServiceError> {
    
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.github.com/search/users?q=\(encodedKeyword)") else {
            return Fail(error: GitHubServiceError.invalidURL).eraseToAnyPublisher()
        }

        return Future { promise in
            AF.request(url).validate().responseDecodable(of: GitHubUserSearchResponse.self) { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data.items))
                case .failure(let error):
                    if let httpStatusCode = response.response?.statusCode, (400...499).contains(httpStatusCode) {
                        promise(.failure(.server))
                    } else if let httpStatusCode = response.response?.statusCode, (500...599).contains(httpStatusCode) {
                        promise(.failure(.server))
                    } else {
                        promise(.failure(.network(error)))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


struct GitHubUserSearchResponse: Decodable {
    let items: [GitHubUser]
}

