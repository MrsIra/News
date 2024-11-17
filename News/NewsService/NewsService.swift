import Foundation
import Combine

class NewsService {
    private let apiKey = "9f06601014ff4d8b805692367e0e6ab9"
    private var cancellables = Set<AnyCancellable>()

    func fetchNews(searchQuery: String, completion: @escaping ([News]) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=\(searchQuery)&apiKey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }

        print("\(urlString)")
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { news in
                completion(news)
            })
            .store(in: &cancellables)
    }
}
