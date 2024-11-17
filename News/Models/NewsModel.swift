import Foundation

struct News: Codable {
    let title: String
    let publishedAt: String
    let author: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case publishedAt
        case author
        case content
    }
}

struct NewsResponse: Codable {
    let articles: [News]
}
