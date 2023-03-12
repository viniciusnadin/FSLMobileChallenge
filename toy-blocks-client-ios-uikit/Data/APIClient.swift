//
//  APIClient.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Vinicius Nadin on 12/03/23.
//

import Foundation

class API: HTTPClient {
    
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        let task = session.dataTask(with: url) { data, _ , error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data {
                    return data
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
    }
}
