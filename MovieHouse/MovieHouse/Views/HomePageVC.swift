//
//  ViewController.swift
//  MovieHouse
//
//  Created by Ali Bahadir Sensoz on 6.11.2023.
//

import UIKit

class HomePageVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var movie: Movie?
    let movieCell = UITableViewCell()
    var movieTable = UITableView()
    let searchBar = UISearchBar()
    var selectedMovieTitle: String?
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let noMoviesLabel: UILabel = {
        let label = UILabel()
        label.text = "No movies found."
        label.textColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        movieTable.addGestureRecognizer(tapGesture)

        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        view.backgroundColor = UIColor.black

        searchBar.frame = CGRect(x: 0, y: barHeight + 30, width: displayWidth, height: 44)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search Movies"
        searchBar.delegate = self
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
        }
        searchBar.barStyle = .black
        view.addSubview(searchBar)

        movieTable = UITableView(frame: CGRect(x: 0, y: barHeight + 30 + searchBar.frame.size.height, width: displayWidth, height: displayHeight - barHeight - searchBar.frame.size.height))
        
        movieTable.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        movieTable.dataSource = self
        movieTable.delegate = self
        movieTable.backgroundColor = .black
        movieTable.backgroundView = nil
        movieTable.rowHeight = 240
        self.view.addSubview(movieTable)
        testWebService(query: "batman")
        view.addSubview(noMoviesLabel)
        noMoviesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noMoviesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        view.addSubview(loadingIndicator)
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.hidesWhenStopped = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(performSearch), object: nil)
        perform(#selector(performSearch), with: nil, afterDelay: 0.5)
    }
    @objc func performSearch() {
        let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !searchText.isEmpty && searchText.count >= 3 {
            testWebService(query: searchText)
        } else {
            movie = nil
            movieTable.reloadData()
            
            testWebService(query: "batman")
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = movie {
            let searchResult = movie.search[indexPath.row]
            selectedMovieTitle = searchResult.title
            print("Selected Film: ", selectedMovieTitle ?? "film")

            loadingIndicator.startAnimating()

            DispatchQueue.main.async { [weak self] in
                let movieDetailsVC = MovieDetailsVC()
                movieDetailsVC.movieTitleText = self?.selectedMovieTitle
                self?.navigationController?.pushViewController(movieDetailsVC, animated: false)

                self?.loadingIndicator.stopAnimating()
            }
        }
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movie = movie {
            return movie.search.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell

        if let movie = movie {
            let searchResult = movie.search[indexPath.row]
            cell.titleLabel.text = searchResult.title
            cell.yearLabel.text = searchResult.year

            if let imageURL = URL(string: searchResult.poster) {
                Utils.shared.loadImage(fromURL: imageURL) { image in
                    if let image = image {
                        cell.movieImageView.image = image
                    } else {
                        cell.movieImageView.image = UIImage(named: "defaultImage")
                    }
                }
            } else {
                cell.movieImageView.image = UIImage(named: "defaultImage")
            }
        } else {
            cell.movieImageView.image = UIImage(named: "defaultImage")
        }

        return cell
    }
    
    func testWebService(query: String) {
            loadingIndicator.startAnimating()

            let webService = WebService.shared

            // Mock page
            let page = 1

            webService.searchMovie(query: query, page: page) { [self] result in
            switch result {
            case .success(let fetchedMovie):
                self.movie = fetchedMovie

                DispatchQueue.main.async {
                    
                    self.loadingIndicator.stopAnimating()
                    self.movieTable.reloadData()

                    if fetchedMovie.search.isEmpty {
                        self.noMoviesLabel.isHidden = false
                        self.movieTable.isHidden = true
                        self.movieCell.isHidden = true
                    } else {
                        self.noMoviesLabel.isHidden = true
                        self.movieTable.isHidden = false
                        self.movieCell.isHidden = false
                    }
                }

                print("Movie search result:")
                print("Total Results: \(fetchedMovie.totalResults)")
                for searchResult in fetchedMovie.search {
                    print("Title: \(searchResult.title), Year: \(searchResult.year)")
                }
            case .failure(let error):
                movieTable.isHidden = true
                movieCell.isHidden = true
                print("Search error: \(error.localizedDescription)")
                self.noMoviesLabel.isHidden = false
            }
        }
    }

}


extension HomePageVC: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // Dismiss the keyboard only if the tap occurs outside of the search bar
        if touch.view is UISearchBar {
            return false
        }
        return true
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true) // Dismiss the keyboard when scrolling begins
    }
}

