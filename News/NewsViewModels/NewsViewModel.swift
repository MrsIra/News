import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news: [News] = []
    private var newsService = NewsService()
    private var cancellables = Set<AnyCancellable>()

    func fetchNews(searchQuery: String) {
        newsService.fetchNews(searchQuery: searchQuery) { [weak self] news in
            self?.news = news
        }
    }
}
