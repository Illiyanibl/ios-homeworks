import UIKit

class InfoViewController: UIViewController{
    var btCloseInfo = UIButton()
    var btShowAlert = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.alpha = 0.85
        title = "Info"

        setupView()
        addSubView()
    }

    private func setupView() {

        btCloseInfo = {
            let button = UIButton(type: .system)
            button.isUserInteractionEnabled = true
            button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 100, height: 20))
            button.setTitle("Close", for: .normal)
            button.backgroundColor = .systemYellow
            button.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)
            return button
        }()

        btShowAlert = {
            let button = UIButton(type: .system)
            button.frame = CGRect(origin: CGPoint(x: 0, y: 28), size: CGSize(width: 100, height: 20))
            button.setTitle("Allert", for: .normal)
            button.backgroundColor = .systemYellow
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
            return button
        }()

    }
    private func addSubView(){
        view.addSubview(btCloseInfo)
        view.addSubview(btShowAlert)
    }

    @objc func closeInfo(){
        self.dismiss(animated: true, completion: nil)
    }

    @objc func showAlert(){
        let alert = UIAlertController(title: "It's alert", message: "All is Ok", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in print("Pressed Cancel")}
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in print("Pressed Ok")}
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        present(alert, animated: false)
    }
}
