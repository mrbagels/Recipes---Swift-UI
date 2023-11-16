//
//  MockClient.swift
//  RecipesTests
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

class MockClient: Client {
    
    func load<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard
            let endpoint = endpoint as? MockEndpoint, // Brute force for testing only.
            let mockData = endpoint.mockData
        else {
            throw ClientError.urlError(NSError(domain: "", code: 0))
        }
        
        // Duplicated logic from our URLSessionService. In a production environment, we would have
        // individual test suites for each of our services. For this example, we will duplicate.
        do {
            return try JSONDecoder().decode(T.self, from: mockData)
        } catch {
            throw ClientError.decodingError(error)
        }
    }
}
