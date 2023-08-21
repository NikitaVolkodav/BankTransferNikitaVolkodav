import UIKit

struct AlertService {
    
    static func turnOnInternet(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "Turn On Internet", message: "To display data, turn on Wi-Fi or mobile internet.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func copiedtoClipboard(_ viewController: UIViewController) {
        let alertController = UIAlertController(title: "Copied to Clipboard", message: "The text has been copied to the clipboard.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
