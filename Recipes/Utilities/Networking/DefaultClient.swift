//
//  DefaultClient.swift
//  Recipes
//
//  Created by Kyle Begeman on 11/14/23.
//

import Foundation

struct DefaultClient: Client {
    
    /// Local session object for custom configuration.
    private let session: URLSession
    
    init() {
        // Set the configuration up with our new cache and policy selection.
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = URLCache(memoryCapacity: 50 * 1024 * 1024, // 50 MB
                                          diskCapacity: 100 * 1024 * 1024,  // 100 MB,
                                          diskPath: "client_response_cache")
        
        // Initialize our session with the configuration.
        self.session = URLSession(configuration: configuration)
    }
    
    /// Default implementation of the `load` method in the `Client` protocol.
    func load<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.request else { throw ClientError.requestError }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Check for HTTP error responses.
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw ClientError.serverError(statusCode: httpResponse.statusCode)
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as URLError {
            throw ClientError.urlError(error)
        } catch let decodingError as DecodingError {
            throw ClientError.decodingError(decodingError)
        } catch {
            // Catch all other errors.
            throw ClientError.unknownError(error)
        }
    }
}
