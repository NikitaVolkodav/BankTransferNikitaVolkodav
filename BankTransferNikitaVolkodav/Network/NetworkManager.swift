import Foundation

protocol NetworkManagerProtocol {
    func getPaymentInformation(completion: @escaping (PaymentInformation?, NetworkError?) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    
    func getPaymentInformation(completion: @escaping (PaymentInformation?, NetworkError?) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "mintos-mobile.s3.eu-central-1.amazonaws.com"
        urlComponents.path = "/bank-accounts.json"

        guard let url = urlComponents.url else {
            completion(nil, NetworkError.badURL)
            return
        }
        performDataTask(with: url, completion: completion)
    }
    
    private func performDataTask(with url: URL, completion: @escaping (PaymentInformation?, NetworkError?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data else {
                completion(nil, NetworkError.noDataError)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, NetworkError.badServerResponse)
                return
            }
            guard error == nil else {
                completion(nil, NetworkError.unknownError)
                return
            }
             self.handleResponse(data: data, httpResponse: httpResponse, completion: completion)
        }
        .resume()
    }
    
    private func handleResponse(data: Data, httpResponse: HTTPURLResponse, completion: @escaping (PaymentInformation?, NetworkError?) -> Void) {
        if httpResponse.statusCode == 200 {
            do {
                let parsingData = try JSONDecoder().decode(PaymentInformation.self, from: data)
                completion(parsingData, nil)
            } catch {
                completion(nil, NetworkError.badServerResponse)
            }
        } else {
            completion(nil, NetworkError.badStatusCode)
        }
    }
}
