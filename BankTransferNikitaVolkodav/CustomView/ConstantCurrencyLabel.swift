import UIKit

class ConstantCurrencyLabel: UILabel {
    private var labelText = ""

    required init(labelText: String) {
        super.init(frame: .zero)

        self.labelText = labelText

        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    private func setup() {
        font = UIFont.systemFont(ofSize: 16, weight: .light)
        textColor = .systemGray
        text = labelText
        numberOfLines = 0
    }
}
