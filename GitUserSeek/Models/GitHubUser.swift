import Foundation

struct GitHubUser: Identifiable, Decodable {
    let id: Int
    let login: String
    private let avatar_url: String
    let name: String?
    let company: String?
    let public_repos: Int?
    let hireable: Bool?
}

// MARK: - Convenient Computed Props

extension GitHubUser {
    var avatarUrl: URL? {
        URL(string: self.avatar_url)
    }
}
