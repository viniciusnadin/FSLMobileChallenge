//
//  URLSessionProtocol.swift
//  ToyBlocks
//
//  Created by FullStack Labs on 07/09/21.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
