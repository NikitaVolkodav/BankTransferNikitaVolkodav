import UIKit

final class ViewController: UIViewController {
    
    private let currencyCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let investorInfornationCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        registerCurrencyCell()
        registerInvestorCell()
        configurationCurrencyCollection()
        updateCurrencyCollectionConstraints()
        configurationInvestorInfornationCollection()
        updateInvestorInfornationCollectionConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(currencyCollection)
        view.addSubview(investorInfornationCollection)
    }
    
    private func configurationCurrencyCollection() {
        currencyCollection.backgroundColor = .red
        currencyCollection.showsVerticalScrollIndicator = false
        currencyCollection.showsHorizontalScrollIndicator = false
        currencyCollection.dataSource = self
        currencyCollection.delegate = self
    }
    
    private func configurationInvestorInfornationCollection() {
        investorInfornationCollection.backgroundColor = .systemGray
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
    
    @objc private func cellTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? CurrencyCell {
            cell.cellTapped()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == currencyCollection {
            return 1 // Логика для currencyCollection
        } else if collectionView == investorInfornationCollection {
            return 10 // Логика для investorInfornationCollection
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let currencyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else { return UICollectionViewCell() }
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
//        tapGesture.numberOfTapsRequired = 1
//        currencyCell.addGestureRecognizer(tapGesture)
//        return currencyCell
        
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
            // Здесь настройте ячейку InvestorCell
            
            return investorCell
        }
        
        return UICollectionViewCell()
        
        
        
    }
    
}

    extension ViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width - 8, height: 80)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            if collectionView == currencyCollection {
                return CGSize()
            } else {
               return CGSize(width: collectionView.bounds.width, height: 16)
            }
        }
    }
    


final class CurrencyCell: UICollectionViewCell {
    
    let euroImageView = UIImageView()
    let constantCurrencyLabel = ConstantCurrencyLabek(labelText: "Currency")
    let typeCurrenceLabel = UILabel()
    let switchImageView = UIImageView()
    
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
    
    func addSubviews() {
        addSubview(euroImageView)
        addSubview(constantCurrencyLabel)
        addSubview(typeCurrenceLabel)
        addSubview(switchImageView)
    }
    
    func configurationEuroImageView() {
        euroImageView.image = UIImage(systemName: "eurosign.circle")
        euroImageView.clipsToBounds = true
        euroImageView.contentMode = .scaleAspectFit
    }
    
    func configurationTypeCurrenceLabel() {
        typeCurrenceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        typeCurrenceLabel.textColor = .black
        typeCurrenceLabel.text = "EUR"
        typeCurrenceLabel.numberOfLines = 0
    }
    
    func configurationSwitchImageView() {
        switchImageView.image = UIImage(systemName: "arrow.down")
        switchImageView.clipsToBounds = true
        switchImageView.contentMode = .scaleAspectFit
        switchImageView.tintColor = .systemGray
        switchImageView.isHidden = true
    }
    
     func updateEuroImageViewConstraints() {
         euroImageView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            euroImageView.widthAnchor.constraint(equalToConstant: 60),
            euroImageView.heightAnchor.constraint(equalToConstant: 60),
            euroImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            euroImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
         ])
    }
    
    func updateConstantCurrencyLabelConstraints() {
        constantCurrencyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            constantCurrencyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            constantCurrencyLabel.leadingAnchor.constraint(equalTo: euroImageView.trailingAnchor, constant: 16)
        ])
    }
    
    func updateTypeCurrenceLabelConstraints() {
        typeCurrenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeCurrenceLabel.topAnchor.constraint(equalTo: constantCurrencyLabel.bottomAnchor, constant: 4),
            typeCurrenceLabel.leadingAnchor.constraint(equalTo: euroImageView.trailingAnchor, constant: 16)
        ])
    }
    
    func updateSwitchImageViewConstraints() {
        switchImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchImageView.widthAnchor.constraint(equalToConstant: 16),
            switchImageView.heightAnchor.constraint(equalToConstant: 16),
            switchImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            switchImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

final class InvestorCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
