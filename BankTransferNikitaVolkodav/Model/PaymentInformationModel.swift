import Foundation

struct PaymentInformation: Codable {
    let response: Response
}

struct Response: Codable {
    let paymentDetails: String
    let items: [Item]
}

struct Item: Codable {
    let bank, swift, currency, beneficiaryName: String
    let beneficiaryBankAddress, iban: String
}
