//
//  ViewController.swift
//  KriptoParaUygulamasi
//
//  Created by Ali Bahadir Sensoz on 21.10.2023.
//  

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    let cryptoVM = CryptoViewModel()
    
    var tableView: UITableView!
    let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        cryptoVM.requestData()
    }
    
    private func setupUI() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupBindings() {
        cryptoVM.loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] bool in
                if bool {
                    self?.loadingIndicator.startAnimating()
                    print("Loading indicator started")
                } else {
                    self?.loadingIndicator.stopAnimating()
                    print("Loading indicator stopped")
                }
            }
            .disposed(by: disposeBag)
        
        cryptoVM.cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] cryptos in
                self?.cryptoList = cryptos
                self?.tableView.reloadData()
                self?.loadingIndicator.stopAnimating()
            }
            .disposed(by: disposeBag)
        
        cryptoVM.error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "CryptoCell")
        let crypto = cryptoList[indexPath.row]

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemGray4
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOpacity = 0.2
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 2)
        backgroundView.layer.shadowRadius = 4
        cell.backgroundView = backgroundView

        cell.textLabel?.text = crypto.currency
        cell.detailTextLabel?.text = "Price: \(crypto.price)"
        cell.textLabel?.textColor = UIColor.systemBlue // Text color
        cell.detailTextLabel?.textColor = UIColor.systemGreen // Detail text color
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16) // Custom font for currency
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14) // Custom font for price

        return cell
    }
}
