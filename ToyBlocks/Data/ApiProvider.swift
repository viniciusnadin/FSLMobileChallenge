//
//  ApiRequest.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 03/09/21.
//

import Foundation

class ApiProvider {
    public func get(url: String, onComplete: @escaping (Dictionary<String, AnyObject>?, ApiProviderError?) -> Void) -> Void {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    onComplete(json, nil)
                } catch {
                    onComplete(nil, ApiProviderError.deserializationError)
                }
            }
            else {
                onComplete(nil, ApiProviderError.serverUnreachable)
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
