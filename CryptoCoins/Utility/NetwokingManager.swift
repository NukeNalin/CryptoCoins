//
//  NetwokingManager.swift
//  CryptoCoins
//
//  Created by Nalin Porwal on 10/06/21.
//

import Foundation
import Combine
class NetworkingManager {
    
    enum NetworkingError: LocalizedError,Error {
        
        case badURLResponse(url: URL)
        case decodeError(error: String)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "[🔥] Bad response from URL: \(url)"
            case .unknown:
                return "[⚠️] Unknown error occured"
            case .decodeError(error: let error):
                return "[🔥] Data Can not convert Discription: \(error)"
            
            }
        }
    }
    
    static func download(_ url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse($0,url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    static func downloadWithDecoder<DataModel:Codable>(_ url: URL,_ model: DataModel.Type) -> AnyPublisher<DataModel,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({try handleURLResponse($0,url)})
            .decode(type: model.self, decoder: JSONDecoder())
            .mapError({_ in NetworkingError.badURLResponse(url: url)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static private func handleURLResponse(_ output: URLSession.DataTaskPublisher.Output,_ url: URL) throws -> Data {
         guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
            throw NetworkingError.badURLResponse(url: url)
         }
         return output.data
     }
    
    
    static func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleCompletion(_ completion: Subscribers.Completion<Error>,_ faliuerCompletion: ()->Void) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            faliuerCompletion()
            print(error.localizedDescription)
        }
    }
    
}


