//
//  DetailViewController.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/28/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel
    private let detailId: String
    
    // MARK: - Init
    init(detailId: String) {
        self.viewModel = DetailViewModel()
        self.detailId = detailId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBackground
        return scroll
    }()
    
    private let detailView = DetailView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        self.viewModel.viewState.bind { state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.showActivityIndicator()
                case .loaded:
                    self.hideActivityIndicator()
                    self.configureDetailData()
                case .error(let message):
                    self.hideActivityIndicator()
                    self.displayErrorAlert(message: state?.message ?? message)
                default: break
                }
            }
        }
        viewModel.fetchDetailInfo(id: detailId)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(detailView)
        
        detailView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            detailView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            detailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func configureDetailData() {
        guard let detail = viewModel.viewState.value?.data else {
            return
        }
        
        detailView.titleLabel.text = detail.title
        detailView.priceLabel.text = detail.price
        detailView.locationLabel.text = detail.location
        detailView.createdDateLabel.text = detail.createdDate
        detailView.descriptionLabel.text = detail.description
        detailView.emailLabel.text = detail.email
        detailView.phoneNumberLabel.text = detail.phoneNumber
        detailView.addressLabel.text = detail.address
        
        if let imageURL = URL(string: detail.imageURL) {
            detailView.imageView.sd_setImage(with: imageURL, completed: nil)
        }
    }
    
    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func showActivityIndicator() {
        spinner = UIActivityIndicatorView(style: .large)
        spinner.center = self.view.center
        self.view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func hideActivityIndicator(){
        self.spinner.stopAnimating()
    }
}
