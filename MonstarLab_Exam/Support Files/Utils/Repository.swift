//
//  Repository.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    func getDataFromServer(with endpoint: String,
                           successHandler: @escaping (([Item]) -> Void),
                           errorHandler: @escaping ((String?) -> Void)) 
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class Repository: RepositoryProtocol {
    
    static let shared = Repository()
    
    private init() {}
    
    func getDataFromServer(with endpoint: String,
                           successHandler: @escaping (([Item]) -> Void),
                           errorHandler: @escaping ((String?) -> Void)) {
        executeRequest(path: endpoint, succesHandler: { data, response in
            guard let items = self.decodeData(with: data, type: [Item].self) else {
                return
            }
            
            successHandler(items)
        }, errorHandler: { error in
            errorHandler(error.message)
        })
    }
    
    private func executeRequest(path: String,
                                httpMethod: HTTPMethod = .get,
                                succesHandler: @escaping SuccessTaskHandler,
                                errorHandler: @escaping ErrorHandler) {
        
        if let urlComponents = URLComponents(string: baseUrl + path) {
            URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
                if let response = response as? HTTPURLResponse {
                    guard (200...299).contains(response.statusCode) else {
                        let dict = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] ?? [:]
                        let errorResponse = ErrorResponse(code: response.statusCode,
                                                          message: dict?["message"] as? String ?? "",
                                                          userInfo: [:])
                        errorHandler(errorResponse)
                        return
                    }
                }
                
                if let error = error {
                    errorHandler(error.toResponse())
                    return
                }
                
                if let data = data {
                    succesHandler(data, response)
                    return
                }
                
            }.resume()
        }
    }
    
    // Private functions
    private func decodeData<T: Codable>(with data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(type.self, from: data)
            return decoded
        } catch (let e) {
            print(e)
        }
        
        return nil
    }
}
