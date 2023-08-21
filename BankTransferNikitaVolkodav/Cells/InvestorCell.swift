import Foundation
import UIKit

final class InvestorCell: UICollectionViewCell {
    
    let descriptionDetailsLabel = ConstantCurrencyLabel()
    let investorDetailsLabel = UILabel()
    private let copyImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(descriptionDetailsLabel)
        addSubview(investorDetailsLabel)
        addSubview(copyImageView)
        configurationInvestorDetailsLabel()
        configurationCopyImageView()
        updateDescriptionDetailsLabelConstraints()
        updateInvestorDetailsLabelConstraints()
        updateCopyImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configurationInvestorDetailsLabel() {
        investorDetailsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        investorDetailsLabel.textColor = .black
        investorDetailsLabel.numberOfLines = 0
    }
    
    private func configurationCopyImageView() {
        copyImageView.image = UIImage(systemName: "doc.on.doc")
        copyImageView.contentMode = .scaleAspectFit
        copyImageView.clipsToBounds = true
        copyImageView.tintColor = .systemGray
    }
    
   private func updateDescriptionDetailsLabelConstraints() {
       descriptionDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        descriptionDetailsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        descriptionDetailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
       ])
    }
    
   private func updateInvestorDetailsLabelConstraints() {
        investorDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            investorDetailsLabel.topAnchor.constraint(equalTo: descriptionDetailsLabel.bottomAnchor, constant: 4),
            investorDetailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    private func updateCopyImageViewConstraints() {
        copyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            copyImageView.widthAnchor.constraint(equalToConstant: 30),
            copyImageView.heightAnchor.constraint(equalToConstant: 30),
            copyImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            copyImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
