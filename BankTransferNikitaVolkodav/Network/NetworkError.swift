import Foundation

enum NetworkError: Error {
    case badStatusCode
    case badURL
    case badServerResponse
    case noDataError
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badStatusCode:
            return NSLocalizedString("networkError_badStatusCode", comment: "")
        case .badURL:
            return NSLocalizedString("networkError_badURL", comment: "")
        case .badServerResponse:
            return NSLocalizedString("networkError_badServerResponse", comment: "")
        case .noDataError:
            return NSLocalizedString("networkError_noDataError", comment: "")
        case .unknownError:
            return NSLocalizedString("networkError_unknownError", comment: "")
        }
    }
}
