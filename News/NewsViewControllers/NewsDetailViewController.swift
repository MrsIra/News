import UIKit

class NewsDetailViewController: UIViewController {
    var news: News?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = UIColor.darkGray
        label.textAlignment = .left
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.borderWidth = 1.0
        return label
    }()
    
    private lazy var intervalView: UIView = {
        let intervalView = UIView()
        intervalView.backgroundColor = .lightGray
        return intervalView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubview()
        setupConstraints()
        displayNews()
    }
}

private extension NewsDetailViewController {
    func addSubview() {
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(contentLabel)
        view.addSubview(intervalView)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        intervalView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            intervalView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            intervalView.leftAnchor.constraint(equalTo: view.leftAnchor),
            intervalView.rightAnchor.constraint(equalTo: view.rightAnchor),
            intervalView.heightAnchor.constraint(equalToConstant: 1),

            authorLabel.topAnchor.constraint(equalTo: intervalView.bottomAnchor, constant: 10),
            authorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            authorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            contentLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            contentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }

    func displayNews() {
        titleLabel.text = news?.title
        authorLabel.text = "Author: \(news?.author ?? "Unknown")"
        contentLabel.text = news?.content ?? "No content available"
    }
}
