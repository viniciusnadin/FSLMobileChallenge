//
//  URLSessionProtocol.swift
//  toy-blocks-client-ios-uikit
//
//  Created by Thiago Galvani on 24/06/22.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
