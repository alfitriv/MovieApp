//
//  MockMovieService.swift
//  iTunesAppTests
//
//  Created by Mila on 08/03/22.
//

import Foundation
@testable import iTunesApp

class MockMovieService: MovieService {
    var isFetchMovieInvoked = false
    
    func fetchResults(searchText: String, successHandler: @escaping (Results) -> Void, errorHandler: @escaping (Error) -> Void) {
        isFetchMovieInvoked = true
    }
}
