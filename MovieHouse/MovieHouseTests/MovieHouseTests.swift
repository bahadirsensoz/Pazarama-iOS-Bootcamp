//
//  MovieHouseTests.swift
//  MovieHouseTests
//
//  Created by Ali Bahadir Sensoz on 6.11.2023.
//

import XCTest
@testable import MovieHouse

class WebServiceTests: XCTestCase {
    var webService: WebService!

    override func setUp() {
        super.setUp()
        webService = WebService.shared
    }

    override func tearDown() {
        webService = nil
        super.tearDown()
    }

    func testFetchMovie() {
        let movieTitle = "Batman"
        let expectation = XCTestExpectation(description: "Fetch Movie API call")

        webService.fetchMovie(title: movieTitle) { result in
            switch result {
            case .success(let movieDetails):
                XCTAssertNotNil(movieDetails)
            case .failure(let error):
                XCTFail("Fetch Movie API call failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testSearchMovie() {
        let query = "Batman"
        let page = 1

        let expectation = XCTestExpectation(description: "Search Movie API call")

        webService.searchMovie(query: query, page: page) { result in
            switch result {
            case .success(let movie):
                XCTAssertNotNil(movie)
            case .failure(let error):
                XCTFail("Search Movie API call failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10)
    }

    func testCalculateTotalPages() {
        let moviesPerPage = 10
        let totalResults = 513
        let calculate = webService.calculateTotalPages(totalResults: totalResults)
        XCTAssertEqual(calculate, 52)
    }
}
