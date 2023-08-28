//
//  DetailViewController.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/28/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    let id: String
    
    private let detailView = DetailView()
    private var viewModel: DetailPageViewViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        viewModel.fetchDetailInfo(with: id)
        viewModel.bindDetailPageViewModelToController = {
            self.detailView.config(with: self.viewModel.product)
            self.title = self.viewModel.product.title
        }
        viewModel.state.bind { state in
            DispatchQueue.main.async {
                switch state {
                case .loading:
                    self.setupLoadedIndicator(state: true)
                case .result:
                    self.setupLoadedIndicator(state: false)
                case .error:
                    self.setupLoadedIndicator(state: false)
                    self.errorAlert()
                default: break
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    init(id: String) {
        self.id = id
        self.viewModel = DetailPageViewViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let loadedIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false

        return loader
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isUserInteractionEnabled = true
        scroll.isExclusiveTouch = true
        scroll.delaysContentTouches = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .systemBackground
        return scroll
    }()
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        
        
        detailView.sendMessageButton.addTarget(self, action: #selector(sendMessageButtonTapped), for: .touchUpInside)
        detailView.callButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.heightAnchor.constraint(equalTo: view.heightAnchor),
            detailView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

}

extension DetailViewController {
    
    @objc func sendMessageButtonTapped(){
        let alert = UIAlertController(title: "Написать продавцу", message: viewModel.product.email, preferredStyle: .alert)
        let send = UIAlertAction(title: "Написать", style: .default) { action in
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
        }
        alert.addAction(send)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @objc func callButtonTapped(){
        let alert = UIAlertController(title: "Позвонить продавцу", message: viewModel.product.phone_number, preferredStyle: .alert)
        let send = UIAlertAction(title: "Позвонить", style: .default) { action in
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
        }
        alert.addAction(send)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    private func errorAlert() {
        let alertVC = UIAlertController(
            title: "Ошибка",
            message: "Не удалось загрузить информацию о товаре",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    private func setupLoadedIndicator(state: Bool) {
        if state {
            self.view.addSubview(self.loadedIndicator)
            self.loadedIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            self.loadedIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            self.loadedIndicator.startAnimating()
        }
        else {
            self.loadedIndicator.stopAnimating()
        }
    }
}

