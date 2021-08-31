//
//  NetworkRequest.swift
//  
//
//  Created by Prabin Kumar Datta on 31/08/21.
//

import Foundation
import Combine
import Alamofire
import Security

struct SessionManager {
    private let crtBase64 = "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"

    var AFSession: Session {
//        guard let publicKeysTrustEvaluator = self.trustEvaluator() else { return nil }
        let manager = ServerTrustManager(evaluators: ["api.seatgeek.com": self.trustEvaluator()])
        let configuration = URLSessionConfiguration.af.default

        return Session(configuration: configuration,
                       serverTrustManager: manager)
    }
    
    private func trustEvaluator() -> PublicKeysTrustEvaluator {
        if let certificateData = Data(base64Encoded: crtBase64, options: []),
            let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) {
            //  use certificate to initialize PinnedCertificatesTrustEvaluator, or ...
            
            var trust: SecTrust?
            let policy = SecPolicyCreateBasicX509()
            let status = SecTrustCreateWithCertificates(certificate, policy, &trust)
            
            if status == errSecSuccess, let trust = trust,
                let publicKey = SecTrustCopyPublicKey(trust) {
                //  ... use publicKey to initialize PublicKeysTrustEvaluator
                return PublicKeysTrustEvaluator(keys: [publicKey], performDefaultValidation: true, validateHost: true)
            }
        }
        
        return PublicKeysTrustEvaluator()
    }
}

class NetworkRequest {
    
    let urlSession: Alamofire.Session
    let url: URL
    let httpMethod: Alamofire.HTTPMethod
    let parameters: [String: Any]?
    
    required init(session: Session = SessionManager().AFSession,
                  url: URL,
                  method: Alamofire.HTTPMethod,
                  parameters: [String: Any]? = nil)
    {
        self.urlSession = session
        self.url = url
        self.httpMethod = method
        self.parameters = parameters
    }
}

protocol NetworkRequesting {
    
    func execute() -> AnyPublisher<Data, NetworkingError>
}

extension NetworkRequest: NetworkRequesting {
    
    func execute() -> AnyPublisher<Data, NetworkingError> {
        
        let adaptableInterceptors: RequestInterceptor? = nil
        
        return urlSession.request(url,
                                  method: httpMethod,
                                  parameters: parameters,
                                  encoding: URLEncoding.default,
                                  interceptor: adaptableInterceptors)
            .validate(statusCode: 200...299)
            .publishData()
            .tryMap {
                try self.mapDataResponse($0.data, response: $0.response, error: $0.error)
            }
            .mapError(mapError(_:))
            .eraseToAnyPublisher()
    }
}

extension NetworkRequest {
    
    func mapDataResponse(_ data: Data?, response: HTTPURLResponse?, error: Error?) throws -> Data {
        
        if let response = response, 200...299 ~= response.statusCode, let data = data { // Successful Response
            return data
        }
        
        // Error Response
        throw NetworkingError(statusCode: response?.statusCode,
                              error: error,
                              data: data)
    }
    
    func mapError(_ error: Error) -> NetworkingError {
        switch error {
        case is NetworkingError:
            return error as! NetworkingError
        default:
            return NetworkingError.unknown(message: "Unknown error: " + error.localizedDescription)
        }
    }
}

