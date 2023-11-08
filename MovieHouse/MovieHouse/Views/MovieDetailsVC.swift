//
//  MovieDetailsVC.swift
//  MovieHouse
//
//  Created by Ali Bahadir Sensoz on 7.11.2023.
//

import Foundation
import UIKit


class MovieDetailsVC: UIViewController {
    var movie: MovieDetails?
    var movieTitleText: String?


    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let actorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let countryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let directorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imdbRatingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetails()
        
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(movieTitle)
        view.addSubview(yearLabel)
        view.addSubview(actorsLabel)
        view.addSubview(countryLabel)
        view.addSubview(directorLabel)
        view.addSubview(imdbRatingLabel)

        let margin: CGFloat = 16

        let labelWidth = CGFloat(50)
        _ = CGFloat(25)

        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imdbRatingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actorsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            directorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            

            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 270),

            movieTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            movieTitle.widthAnchor.constraint(equalToConstant: labelWidth),
            movieTitle.heightAnchor.constraint(lessThanOrEqualToConstant: 100),


            yearLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: margin),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            yearLabel.widthAnchor.constraint(equalTo: movieTitle.widthAnchor),
            yearLabel.heightAnchor.constraint(equalTo: movieTitle.heightAnchor),

            actorsLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: margin),
            actorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            actorsLabel.widthAnchor.constraint(equalTo: movieTitle.widthAnchor),
            actorsLabel.heightAnchor.constraint(equalTo: movieTitle.heightAnchor),

            countryLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: margin),
            countryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            countryLabel.widthAnchor.constraint(equalTo: movieTitle.widthAnchor),
            countryLabel.heightAnchor.constraint(equalTo: movieTitle.heightAnchor),

            directorLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: margin),
            directorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            directorLabel.widthAnchor.constraint(equalTo: movieTitle.widthAnchor),
            directorLabel.heightAnchor.constraint(equalTo: movieTitle.heightAnchor),

            imdbRatingLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: margin),
            imdbRatingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            imdbRatingLabel.widthAnchor.constraint(equalTo: movieTitle.widthAnchor),
            imdbRatingLabel.heightAnchor.constraint(equalTo: movieTitle.heightAnchor),
        ])
        
        if let movie = movie {
            movieTitle.text = movie.title
            yearLabel.text = "Year: \(movie.year)"
            actorsLabel.text = "Actors: \(movie.actors)"
            countryLabel.text = "Origin: \(movie.country)"
            directorLabel.text = "Director: \(movie.director)"
            imdbRatingLabel.text = "IMDb Rating: \(movie.imdbRating)"

            if let imageURL = URL(string: movie.poster) {
                Utils.shared.loadImage(fromURL: imageURL) { [weak self] image in
                    if let image = image {
                        self?.imageView.image = image
                    } else {
                        // Set a default image when loading fails
                        self?.imageView.image = UIImage(named: "defaultImage")
                    }
                }
            } else {
                // Set a default image if the URL is invalid
                imageView.image = UIImage(named: "defaultImage")
            }
        } else {
            // Set a default image if movie data is nil
            imageView.image = UIImage(named: "defaultImage")
        }
    }
    
    private func fetchMovieDetails() {
        guard let movieTitle = movieTitleText else {
            print("Movie Title Bulunamadı")
            return
        }
        
        WebService.shared.fetchMovie(title: movieTitle) { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movie = movie
                self?.setupUI()
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
}

