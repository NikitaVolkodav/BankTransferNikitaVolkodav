import Foundation
import UIKit

final class BankTransferHeader: UICollectionReusableView {
    
    private let bankTransferLabel = UILabel()
    private let transferMoneyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bankTransferLabel)
        addSubview(transferMoneyLabel)
        updateBankTransferLabel()
        updateTransferMoneyLabel()
        addConstraintsBankTransferLabel()
        addConstraintsTransferMoneyLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateBankTransferLabel() {
        bankTransferLabel.font = UIFont.boldSystemFont(ofSize: 20)
        bankTransferLabel.textColor = .black
        bankTransferLabel.text = "Bank transfer"
        bankTransferLabel.numberOfLines = 0
    }
    
    private func updateTransferMoneyLabel() {
        transferMoneyLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        transferMoneyLabel.textColor = .systemGray
        transferMoneyLabel.text = "Transfer money from your bank account to your Mintos account"
        transferMoneyLabel.numberOfLines = 2
    }
    
    private func addConstraintsBankTransferLabel() {
        bankTransferLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bankTransferLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            bankTransferLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bankTransferLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func addConstraintsTransferMoneyLabel() {
        transferMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            transferMoneyLabel.topAnchor.constraint(equalTo: bankTransferLabel.bottomAnchor, constant: 8),
            transferMoneyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transferMoneyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            transferMoneyLabel.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
}
