//
//  Result.swift
//  iTunesApp
//
//  Created by Mila on 06/03/22.
//

import Foundation

struct Result: Codable, Equatable {
    var artistName: String?
    var trackName: String?
    var collectionName: String?
    var artworkUrl60: String?
    var artworkUrl100: String?
    var trackPrice: Double?
    var longDescription: String?
    var primaryGenreName: String?
    let uuid = UUID().uuidString
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case collectionName
        case artworkUrl60
        case artworkUrl100
        case trackPrice
        case longDescription
        case primaryGenreName
    }
    
    static func ==(lhs: Result, rhs: Result) -> Bool {
        return lhs.trackName == rhs.trackName && lhs.artistName == rhs.artistName
    }
}
