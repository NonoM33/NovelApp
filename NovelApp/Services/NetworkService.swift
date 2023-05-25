//
//  NetworkService.swift
//  NovelApp
//
//  Created by renaud on 25/05/2023.
//

import Foundation

class NetworkService {
    var session: URLSession
    var task: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func execute<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        task?.cancel()
        task = session.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(.failure(.nodata))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    print(error)
                    completion(.failure(.parsingError))
                }
                self?.task = nil
            }
        }
        task?.resume()
    }

    func getKeys() -> [Keys: String]? {
        var result = [Keys: String]()
        guard let clientId = Bundle.main.object(forInfoDictionaryKey: CLIENT_API_ID) as? String,
              let clientSecret = Bundle.main.object(forInfoDictionaryKey: CLIENT_API_SECRET) as? String
        else {
            return nil
        }
        result[.clientID] = clientId
        result[.clientSecret] = clientSecret
        return result
    }
}
