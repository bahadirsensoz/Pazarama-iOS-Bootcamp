//
//  MovieHouseUITests.swift
//  MovieHouseUITests
//
//  Created by Ali Bahadir Sensoz on 6.11.2023.
//



import XCTest

@testable import MovieHouse

class MovieDetailsVCTests: XCTestCase {
    var viewController: MovieDetailsVC!

    override func setUp() {
        super.setUp()
        viewController = MovieDetailsVC()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testFetchMovieDetails() {
        let movieTitle = "Batman Begins"
        viewController.movieTitleText = movieTitle

        viewController.loadView()
        viewController.viewDidLoad()


        XCTAssertNotNil(viewController.movie)
        XCTAssertEqual(viewController.movieTitle.text, "Batman Begins")
    }

    func testFetchMovieDetailsWithoutTitle() {
        viewController.movieTitleText = nil

        viewController.loadView()
        viewController.viewDidLoad()

        XCTAssertNil(viewController.movie)
    }


    func testLaunchPerformance() throws {
        if #available(iOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
