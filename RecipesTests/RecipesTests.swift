//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Kyle Begeman on 11/14/23.
//

import XCTest
@testable import Recipes

final class RecipesTests: XCTestCase {

    /// Mock service for granular testing of core functionality.
    var client: Client!

    override func setUp() {
        super.setUp()
        client = MockClient()
    }

    override func tearDown() {
        client = nil
        super.tearDown()
    }

    /// Use mock service to test our filter model.
    func testSuccessfulFilterLoad() async throws {
        do {
            let response: RecipeResponse = try await client.load(endpoint: MockEndpoint.filter)
            XCTAssertEqual(response.recipes.count, 10)
            XCTAssertEqual(response.recipes.first?.id, 53049)
        } catch {
            XCTFail("Expected successful filter response, but received error: \(error)")
        }
    }
    
    /// Use mock service to test our detail model.
    func testSuccessfulDetailLoad() async throws {
        do {
            let mealDetail: RecipeResponse = try await client.load(endpoint: MockEndpoint.detail)
            XCTAssertEqual(mealDetail.recipes.count, 1)
            XCTAssertEqual(mealDetail.recipes.first?.id, 53049)
        } catch {
            XCTFail("Expected successful detail response, but received error: \(error)")
        }
    }
    
    /// Test forced URL error.
    func testURLError() async throws {
        do {
            let _: RecipeResponse = try await client.load(endpoint: MockEndpoint.invalidUrl)
            XCTFail("Expected URL error, but request succeeded")
        } catch ClientError.urlError {
            // Success, caught the expected error
        } catch {
            XCTFail("Expected URL error, but received a different error: \(error)")
        }
    }
    
    /// Test forced decoding errors.
    func testDecodingError() async throws {
        do {
            let _: RecipeResponse = try await client.load(endpoint: MockEndpoint.invalidData)
            XCTFail("Expected decoding error, but request succeeded")
        } catch ClientError.decodingError {
            // Success, caught the expected error
        } catch {
            XCTFail("Expected decoding error, but received a different error: \(error)")
        }
    }
}
