import Foundation
import UIKit

final class CurrencyCell: UICollectionViewCell {
    
    private let euroImageView = UIImageView()
    private let constantCurrencyLabel = ConstantCurrencyLabel(labelText: "Currency")
    private let typeCurrenceLabel = UILabel()
    private let switchImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubviews()
        configurationEuroImageView()
        updateEuroImageViewConstraints()
        updateConstantCurrencyLabelConstraints()
        configurationTypeCurrenceLabel()
        updateTypeCurrenceLabelConstraints()
        configurationSwitchImageView()
        updateSwitchImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cellTapped() {
        switchImageView.isHidden = !switchImageView.isHidden
    }
    
   private func addSubviews() {
        addSubview(euroImageView)
        addSubview(constantCurrencyLabel)
        addSubview(typeCurrenceLabel)
        addSubview(switchImageView)
    }
    
   private func configurationEuroImageView() {
        euroImageView.image = UIImage(systemName: "eurosign.circle")
        euroImageView.clipsToBounds = true
        euroImageView.contentMode = .scaleAspectFit
    }
    
   private func configurationTypeCurrenceLabel() {
        typeCurrenceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        typeCurrenceLabel.textColor = .black
        typeCurrenceLabel.text = "EUR"
        typeCurrenceLabel.numberOfLines = 0
    }
    
    private func configurationSwitchImageView() {
        switchImageView.image = UIImage(systemName: "arrow.down")
        switchImageView.clipsToBounds = true
        switchImageView.contentMode = .scaleAspectFit
        switchImageView.tintColor = .systemGray
        switchImageView.isHidden = true
    }
    
    private func updateEuroImageViewConstraints() {
         euroImageView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            euroImageView.widthAnchor.constraint(equalToConstant: 60),
            euroImageView.heightAnchor.constraint(equalToConstant: 60),
            euroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            euroImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
         ])
    }
    
    private func updateConstantCurrencyLabelConstraints() {
        constantCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            constantCurrencyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            constantCurrencyLabel.leadingAnchor.constraint(equalTo: euroImageView.trailingAnchor, constant: 16)
        ])
    }
    
    private func updateTypeCurrenceLabelConstraints() {
        typeCurrenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeCurrenceLabel.topAnchor.constraint(equalTo: constantCurrencyLabel.bottomAnchor, constant: 4),
            typeCurrenceLabel.leadingAnchor.constraint(equalTo: euroImageView.trailingAnchor, constant: 16)
        ])
    }
    
    private func updateSwitchImageViewConstraints() {
        switchImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchImageView.widthAnchor.constraint(equalToConstant: 16),
            switchImageView.heightAnchor.constraint(equalToConstant: 16),
            switchImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            switchImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
