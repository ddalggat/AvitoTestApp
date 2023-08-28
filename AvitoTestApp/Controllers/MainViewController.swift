//
//  MainViewController.swift
//  AvitoTestApp
//
//  Created by Abdullabekov Dalgat on 8/28/23.
//

import UIKit

class MainViewController: UIViewController, CatalogViewDelegate {

    private let productView = CatalogView()
    private var viewModel: CatalogViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        productView.delegate = self
        if viewModel.state.value == .error {
            errorAlert()
        }
        
    }
    
    init() {
        self.viewModel = CatalogViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupView() {
        title = "Объявления"
        view.backgroundColor = .systemBackground
        view.addSubview(productView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            productView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            productView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController {
    private func errorAlert() {
        let alertVC = UIAlertController(
            title: "Ошибка",
            message: "Не удалось загрузить список товаров",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension MainViewController: CatalogViewDelegate {
    func productsView(_ productView: CatalogView, didSelect id: String) {
        let detailView = DetailViewController(id: id)
        navigationController?.pushViewController(detailView, animated: true)
    }
}

