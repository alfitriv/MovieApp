//
//  ResultsPresenter.swift
//  iTunesApp
//
//  Created by Mila on 08/03/22.
//

import Foundation

protocol ResultsPresenterDelegate: AnyObject {
    func fetchMovieResults(keyword: String)
}

class ResultsPresenter: ResultsPresenterDelegate {
    weak var delegate: ResultsViewControllerDelegate?
    private let movieService: MovieService
    
    init(service: MovieService) {
        self.movieService = service
    }
    
    func fetchMovieResults(keyword: String) {
        self.movieService.fetchResults(searchText: keyword) { [weak self] response in
            self?.delegate?.displayResults(movies: response.results)
        } errorHandler: { error in
            print(error)
        }

    }
}
