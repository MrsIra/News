import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var news: [News] = []
    private var newsService = NewsService()
    private var cancellables = Set<AnyCancellable>()
    var searchPublisher = PassthroughSubject<String, Never>()
    
    init() {
        searchPublisher
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.fetchNews(searchQuery: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchNews(searchQuery: String) {
        newsService.fetchNews(searchQuery: searchQuery)
            .assign(to: &$news)
    }
}
