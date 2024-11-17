import UIKit
import Combine

class NewsViewController: UIViewController, UISearchBarDelegate {
    private var viewModel = NewsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск новостей..."
        searchBar.delegate = self
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBar
        
        setupTableView()
        
        viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] news in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

private extension NewsViewController {
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let news = viewModel.news[indexPath.row]
        //        var publishedAt = String(news.publishedAt.prefix(10))
        //
        //        let dateFormatter = DateFormatter()
        //
        //        dateFormatter.dateFormat = "yyyy-mm-dd"
        //
        //        if let date = dateFormatter.date(from: publishedAt) {
        //            dateFormatter.dateFormat = "dd.mm.yyyy"
        //            publishedAt = dateFormatter.string(from: date)
        //        }
        
        cell.textLabel?.text = "\(news.publishedAt) - \(news.title)"
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.news = []
            return
        }
        viewModel.fetchNews(searchQuery: searchText)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = NewsDetailViewController()
        newsDetailVC.news = viewModel.news[indexPath.row]
        navigationController?.pushViewController(newsDetailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

