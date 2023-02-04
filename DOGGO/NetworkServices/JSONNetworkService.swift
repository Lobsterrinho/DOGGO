//
//  JSONNetworkService.swift
//  DOGGO
//
//  Created by Lobster on 25.01.23.
//

import Foundation

final class JSONNetworkService {
    
    func loadDogs(completion: @escaping ([Dog]) -> Void) {
        
        let headers = [
            "x_api_key": "live_noeS7UpTRxlco4e0RJFkZbQOYDfAZax4VDqUqwTksns8MsTAfbOWI9bK39wuCGh5",
        ]
        
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds")
        else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { responseData, responce, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let jsonData = responseData {
                let dogs = try? JSONDecoder().decode([Dog].self, from: jsonData)
                DispatchQueue.main.async {
                    completion(dogs ?? [])
                }
            }
        }.resume()
    }
}

