//
//  ApiRequest.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 03/09/21.
//

import Foundation

class ApiProvider {
    private var session: URLSession

    init(using session: URLSession = URLSession.shared) {
        self.session = session
    }

    public func get(url: String, completionHandler: @escaping (Dictionary<String, AnyObject>?, ApiProviderError?) -> Void) -> Void {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = self.session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    completionHandler(json, nil)
                } catch {
                    completionHandler(nil, ApiProviderError.deserializationError)
                }
            }
            else {
                completionHandler(nil, ApiProviderError.serverUnreachable)
            }
        })

        task.resume()
    }
}

enum ApiProviderError: Error {
    case clientOffline
    case deserializationError
    case serverUnreachable
}
