//
//  ResultsPresenterTest.swift
//  iTunesAppTests
//
//  Created by Mila on 08/03/22.
//

import XCTest
@testable import iTunesApp

class ResultsPresenterTest: XCTestCase {
    var sut: ResultsPresenter!
    var mockMovieService: MockMovieService!
    
    override func setUp() {
        super.setUp()
        mockMovieService = MockMovieService()
        sut = ResultsPresenter(service: mockMovieService)
    }
    
    func testFetchMovies() {
        sut.fetchMovieResults(keyword: "Test")
        XCTAssertTrue(mockMovieService.isFetchMovieInvoked)
    }
    
    

}
