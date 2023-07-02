//
//  MockURLProtocol.swift
//  PipedriveTakeHomeTests
//
//  Created by Ahmer Akhter on 02/07/2023.
//

import Foundation

class MockURLProtocol : URLProtocol{
    
    static var mockData : Data?
    static var mockHTTPResponse : HTTPURLResponse?
    static var mockError : URLError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        
        if let mockError = MockURLProtocol.mockError{
            self.client?.urlProtocol(self, didFailWithError: mockError)
        } else {
            if let mockHTTPResponse = MockURLProtocol.mockHTTPResponse{
                self.client?.urlProtocol(self, didReceive: mockHTTPResponse, cacheStoragePolicy: .notAllowed)
            }

            if let mockData = MockURLProtocol.mockData{
                self.client?.urlProtocol(self, didLoad: mockData)
            }
            
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    
    override func stopLoading() {
        
    }
}
