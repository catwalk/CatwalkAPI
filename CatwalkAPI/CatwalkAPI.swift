//
//  CatwalkAPI.swift
//  Copyright © 2021 CATWALK. All rights reserved.
//

public class CTWAPIClient {
    
    public var apiToken: String?
    private let CTW_API_ROOT: String = "https://app.mycatwalk.com/mobile"
    private let bundle: String? = Bundle.main.bundleIdentifier
    
    public enum CTWAPIServiceError: Error {
        case apiError
        case invalidResponse
        case decodeError
    }
    
    public static let shared = CTWAPIClient()
    
    public func fetchLooks(for sku: String, result: @escaping (Result<[[String]], CTWAPIServiceError>) -> Void) {
        guard let apiToken = apiToken else { return }
        let url = URL(string: "\(CTW_API_ROOT)/combinations")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiToken, forHTTPHeaderField: "apiToken")
        request.setValue(bundle, forHTTPHeaderField: "bundle")
        request.setValue(sku, forHTTPHeaderField: "sku")
        
        fetchResources(urlRequest: request, completion: result)
    }
    
    public func fetchSimilars(for sku: String, result: @escaping (Result<[String], CTWAPIServiceError>) -> Void) {
        guard let apiToken = apiToken else { return }
        let url = URL(string: "\(CTW_API_ROOT)/similars")!

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiToken, forHTTPHeaderField: "apiToken")
        request.setValue(bundle, forHTTPHeaderField: "bundle")
        request.setValue(sku, forHTTPHeaderField: "sku")
        
        fetchResources(urlRequest: request, completion: result)
    }
    
    private func fetchResources<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, CTWAPIServiceError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (result) in
            switch result {
                case .success(let (response, data)):
                    guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    do {
                        let values = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(values))
                    } catch {
                        completion(.failure(.decodeError))
                    }
                case .failure( _):
                    completion(.failure(.apiError))
                }
         }.resume()
    }
    
}

extension URLSession {
    func dataTask(with urlRequest: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
