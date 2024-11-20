import Foundation
import Combine

class NewsService {
    private let apiKey = "9f06601014ff4d8b805692367e0e6ab9"
    private var cancellables = Set<AnyCancellable>()

    func fetchNews(searchQuery: String) -> AnyPublisher<[News], Never> {
        let urlString = "https://newsapi.org/v2/everything?q=\(searchQuery)&apiKey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return Just([]).eraseToAnyPublisher() }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
