//
//  SearchListService.swift
//  SimpleRIBApp
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import SimpleRIBNetworking

struct SearchListModel: Decodable {
    let events: [Event]
}

// MARK: - Event
struct Event: Decodable {
    let id: Int
    let datetimeUtc: String
    let venue: Venue
    let performers: [Performer]
    let title: String
}

extension Event {
    var dateTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: datetimeUtc) {
            formatter.dateFormat = "E, d MMM yyyy h:mm a"
            return formatter.string(from: date)
        }

        return datetimeUtc
    }
}

struct Performer: Decodable {
    let image: String?
}

struct Venue: Decodable {
    let displayLocation: String
}

protocol SearchListServiceable {
    func execute(for query: String) -> AnyPublisher<SearchListModel, NetworkingError>
}

public struct SearchListService {
    
    struct Service: NetworkService {
        let networkClient: NetworkClient
    }
    
    public struct SearchQueryModel: Encodable {
        let clientId: String
        let q: String
    }
}

extension SearchListService: SearchListServiceable {
    
    func execute(for query: String) -> AnyPublisher<SearchListModel, NetworkingError> {
        
        let clientId = AppConfiguration.clientID()!
        let requestParams = SearchQueryModel(clientId: clientId, q: query)
        
        let networkModel = NetworkModel(route: "/2/events",
                                        httpMethod: .get,
                                        parameters: requestParams)
        
        let networkClient = NetworkClient(networkModel: networkModel)
        
        let service = Service(networkClient: networkClient)
        
        return service.execute()
    }
}

