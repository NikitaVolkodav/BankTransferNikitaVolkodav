import Foundation

class InvestorIDFormatterService {
    func formatInvestorIDString(investorIDString: String) -> String {
        // Разделите строку по двоеточию и возьмите вторую часть
        let parts = investorIDString.components(separatedBy: ":")
        let result = parts[1].trimmingCharacters(in: .whitespaces)
        return result
    }
}
