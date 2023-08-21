import UIKit

final class MainViewController: UIViewController {
    
    private let currencyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let investorInfornationCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        return collectionView
    }()
    
    private let networkManager: NetworkManagerProtocol = NetworkManager()
    private let investorIDFormatterService = InvestorIDFormatterService()
    private var paymentInformation: PaymentInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        registerCurrencyCell()
        registerInvestorCell()
        registerBankTransferHeader()
        configurationCurrencyCollection()
        updateCurrencyCollectionConstraints()
        configurationInvestorInfornationCollection()
        updateInvestorInfornationCollectionConstraints()
        fetchData()
        view.backgroundColor = .systemGray6
        AlertService.turnOnInternet(self)
    }
    
    private func addSubviews() {
        view.addSubview(currencyCollection)
        view.addSubview(investorInfornationCollection)
    }
    
    private func configurationCurrencyCollection() {
        currencyCollection.backgroundColor = .systemGray6
        currencyCollection.showsVerticalScrollIndicator = false
        currencyCollection.showsHorizontalScrollIndicator = false
        currencyCollection.dataSource = self
        currencyCollection.delegate = self
    }
    
    private func configurationInvestorInfornationCollection() {
        investorInfornationCollection.backgroundColor = .systemGray6
        investorInfornationCollection.showsVerticalScrollIndicator = false
        investorInfornationCollection.showsHorizontalScrollIndicator = false
        investorInfornationCollection.dataSource = self
        investorInfornationCollection.delegate = self
    }
    
    private func registerCurrencyCell() {
        currencyCollection.register(CurrencyCell.self, forCellWithReuseIdentifier: "CurrencyCell")
    }
    
    private func registerInvestorCell() {
        investorInfornationCollection.register(InvestorCell.self, forCellWithReuseIdentifier: "InvestorCell")
    }
    
    private func registerBankTransferHeader() {
        investorInfornationCollection.register(BankTransferHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BankTransferHeader")
    }
    
    private func updateCurrencyCollectionConstraints() {
        currencyCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyCollection.topAnchor.constraint(equalTo: view.topAnchor),
            currencyCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100)
        ])
    }
    
    private func updateInvestorInfornationCollectionConstraints() {
        investorInfornationCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            investorInfornationCollection.topAnchor.constraint(equalTo: currencyCollection.bottomAnchor),
            investorInfornationCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            investorInfornationCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            investorInfornationCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        networkManager.getPaymentInformation { [weak self] model, _ in
            guard let self = self, let model = model else { return }
            self.paymentInformation = model
            DispatchQueue.main.async {
                self.currencyCollection.reloadData()
                self.investorInfornationCollection.reloadData()
            }
        }
    }
    
    
    @objc private func cellTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? CurrencyCell {
            cell.cellTapped()
            investorInfornationCollection.isHidden = !investorInfornationCollection.isHidden
        }
    }
    
    @objc private func copyCellTap(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? InvestorCell {
            if let textToCopy = cell.investorDetailsLabel.text {
                UIPasteboard.general.string = textToCopy
                AlertService.copiedtoClipboard(self)
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == currencyCollection {
            return 1
        } else {
            if let paymentInformation = paymentInformation, !paymentInformation.response.items.isEmpty {
                
                if section == 0 {
                    // В первой секции одна ячейка
                    return 1
                } else {
                    // Во второй секции четыре ячейки
                    return 4
                }
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == currencyCollection {
            guard let currencyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
                return UICollectionViewCell()
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            currencyCell.addGestureRecognizer(tapGesture)
            
            return currencyCell
            
        } else if collectionView == investorInfornationCollection {
            guard let investorCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvestorCell", for: indexPath) as? InvestorCell else {
                return UICollectionViewCell()
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(copyCellTap(_:)))
            tapGesture.numberOfTapsRequired = 1
            investorCell.addGestureRecognizer(tapGesture)
            
            if let paymentInformation = paymentInformation, !paymentInformation.response.items.isEmpty {
                let item = paymentInformation.response.items[0]
                
                switch indexPath.section {
                case 0:
                    investorCell.descriptionDetailsLabel.text = "Add this information to payment details"
                    investorCell.investorDetailsLabel.text =
                    (investorIDFormatterService.formatInvestorIDString(investorIDString: paymentInformation.response.paymentDetails)) + " - Investor"
                case 1:
                    
                    switch indexPath.item {
                    case 0:
                        investorCell.descriptionDetailsLabel.text = "Beneficiary bank account number / IBAN"
                        investorCell.investorDetailsLabel.text = item.iban
                    case 1:
                        investorCell.descriptionDetailsLabel.text = "Beneficiary bank SWIFT / BIC code"
                        investorCell.investorDetailsLabel.text = item.swift
                    case 2:
                        investorCell.descriptionDetailsLabel.text = "Beneficiary name"
                        investorCell.investorDetailsLabel.text = item.beneficiaryName
                    case 3:
                        investorCell.descriptionDetailsLabel.text = "Beneficiary bank address"
                        investorCell.investorDetailsLabel.text = item.beneficiaryBankAddress
                    default:
                        break
                    }
                    
                default:
                    break
                }
            }
            return investorCell
        }
        return UICollectionViewCell()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 8, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == currencyCollection {
            return CGSize()
        } else {
            if section == 0 {
                return CGSize(width: collectionView.bounds.width, height: 120)
            } else {
                return CGSize.zero
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        guard let imageHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BankTransferHeader", for: indexPath) as? BankTransferHeader else {
            return UICollectionReusableView()
        }
        return imageHeader
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == currencyCollection {
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == investorInfornationCollection {
            if section == 1 {
                return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
            }
        }
        return UIEdgeInsets.zero
    }
}
