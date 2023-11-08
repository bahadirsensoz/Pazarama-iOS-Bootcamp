//
//  MovieHouseUITests.swift
//  MovieHouseUITests
//
//  Created by Ali Bahadir Sensoz on 6.11.2023.
//

import XCTest

@testable import MovieHouse

class HomePageUITests: XCTestCase {
    var viewController: HomePageVC!

    override func setUp() {
        super.setUp()
        viewController = HomePageVC()
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testSearchMovies() {
        viewController.loadView()
        viewController.viewDidLoad()

        let searchText = "Batman"
        viewController.searchBar.text = searchText
        viewController.performSearch()

        // Add a delay here to allow the search to complete
        let expectation = XCTestExpectation(description: "Search completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // Adjust the delay time as needed
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10) // Adjust the timeout as needed

        // Assert the results after the delay
        XCTAssertNotNil(viewController.movie)
        XCTAssertTrue(viewController.movie?.search.count ?? 0 > 0)
    }

    func testSelectMovie() {
        viewController.loadView()
        viewController.viewDidLoad()

        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(viewController.movieTable, didSelectRowAt: indexPath)

        XCTAssertTrue(viewController.navigationController?.topViewController is MovieDetailsVC)
    }



    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}


