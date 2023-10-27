//
//  ViewController.swift
//  RealMonkeyFood
//
//  Created by Ali Bahadir Sensoz on 25.10.2023.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollViewContainer = UIScrollView()
        scrollViewContainer.frame = view.bounds
        scrollViewContainer.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 4)
        view.addSubview(scrollViewContainer)

        let padding: CGFloat = 20
        let spacing: CGFloat = 10
        let _: CGFloat = 30

        // MARK: variables.
        let imageNames1 = ["asya.jpeg", "hambuger.jpeg", "pidelahmac.jpeg", "pizza.jpeg", "tatli.jpeg"]
        let titles2 = ["Restaurant 1", "Hamburger Place", "Pide Restaurant", "Pizza Shop", "Dessert Place"]
        let titles1 = ["Asya", "Hamburger", "Pide&Lahmacun", "Pizza", "Tatli"]

        // MARK: searchbar
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 20, y: padding, width: view.bounds.width - 40, height: 44)
        searchBar.placeholder = "Search"
        scrollViewContainer.addSubview(searchBar)

        // Horizontal Scroll View 1
        let horizontalScrollView1 = createHorizontalScrollView(y: searchBar.frame.maxY + spacing, imageNames: imageNames1, titles: titles1)
        scrollViewContainer.addSubview(horizontalScrollView1)

        // Title for Vertical Scroll View 1
        let titleVertical1 = createTitleLabel(text: "Popular Restaurants", y: horizontalScrollView1.frame.maxY + spacing)
        scrollViewContainer.addSubview(titleVertical1)

        let verticalScrollView1 = createVerticalScrollView(y: titleVertical1.frame.maxY + spacing)
        scrollViewContainer.addSubview(verticalScrollView1)

        // Title for Horizontal Scroll View 2
        let titleHorizontal2 = createTitleLabel(text: "Most Popular", y: verticalScrollView1.frame.maxY + spacing)
        scrollViewContainer.addSubview(titleHorizontal2)

        let imageNames2 = ["asya.jpeg", "hambuger.jpeg", "pidelahmac.jpeg", "pizza.jpeg", "tatli.jpeg"]
        let horizontalScrollView2 = createHorizontalScrollView(y: titleHorizontal2.frame.maxY + spacing, imageNames: imageNames2, titles: titles2)
        scrollViewContainer.addSubview(horizontalScrollView2)

        // Title for Vertical Scroll View 2
        let titleVertical2 = createTitleLabel(text: "Recent Items", y: horizontalScrollView2.frame.maxY + spacing)
        scrollViewContainer.addSubview(titleVertical2)

        let verticalScrollView2 = createVerticalScrollView(y: titleVertical2.frame.maxY + spacing)
        scrollViewContainer.addSubview(verticalScrollView2)

        scrollViewContainer.contentSize = CGSize(width: view.bounds.width, height: verticalScrollView2.frame.maxY + padding)
    }
    
    func createHorizontalScrollView(y: CGFloat, imageNames: [String], titles: [String]) -> UIScrollView {
        let horizontalScrollView = UIScrollView()
        horizontalScrollView.frame = CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 200)
        horizontalScrollView.backgroundColor = UIColor.white

        let horizontalContentView = UIView()
        horizontalContentView.frame = CGRect(x: 0, y: 0, width: (CGFloat(imageNames.count) * 150.0) + CGFloat((imageNames.count - 1) * 10), height: 200)
        horizontalScrollView.addSubview(horizontalContentView)

        var xOffset: CGFloat = 0

        for i in 0..<imageNames.count {
            let imageView = UIImageView(frame: CGRect(x: xOffset, y: 10, width: 150, height: 100))
            imageView.image = UIImage(named: imageNames[i])
            
            imageView.layer.cornerRadius = 10
            imageView.layer.masksToBounds = true
            
            horizontalContentView.addSubview(imageView)

            let titleLabel = UILabel(frame: CGRect(x: xOffset, y: 120, width: 150, height: 30))
            titleLabel.text = titles[i]
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 2
            horizontalContentView.addSubview(titleLabel)

            xOffset += 150.0 + 10.0
        }

        horizontalContentView.frame.size = CGSize(width: xOffset, height: 200)
        horizontalScrollView.contentSize = horizontalContentView.frame.size

        return horizontalScrollView
    }


    func createVerticalScrollView(y: CGFloat) -> UIScrollView {
        let verticalScrollView = UIScrollView()
        verticalScrollView.frame = CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 300)
        verticalScrollView.backgroundColor = UIColor.white

        let verticalContentView = UIView()
        verticalContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 40, height: 600)
        verticalScrollView.addSubview(verticalContentView)

        for i in 0..<10 {
            let label = UILabel(frame: CGRect(x: 20, y: 60 * i, width: Int(view.bounds.width) - 80, height: 50))
            label.text = "Item \(i)"
            verticalContentView.addSubview(label)
        }

        verticalContentView.frame.size = CGSize(width: view.bounds.width - 40, height: 60 * 10)
        verticalScrollView.contentSize = verticalContentView.frame.size

        return verticalScrollView
    }
    
    func createTitleLabel(text: String, y: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: 20, y: y, width: view.bounds.width - 40, height: 30))
        label.text = text
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        
        return label
    }
}
