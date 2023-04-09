import SwiftUI
class InfoViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Info"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let btShowPost = UIButton(type: .system)
        btShowPost.isUserInteractionEnabled = true
        btShowPost.frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.top, y: view.safeAreaInsets.top), size: CGSize(width: 100, height: 20))
        btShowPost.setTitle("Close", for: .normal)
        btShowPost.backgroundColor = .systemYellow
        btShowPost.addTarget(self, action: #selector(closeInfo), for: .touchUpInside)

        let btShowAlert = UIButton(type: .system)
        btShowAlert.frame = CGRect(origin: CGPoint(x: view.safeAreaInsets.top, y: view.safeAreaInsets.top + 28), size: CGSize(width: 100, height: 20))
        btShowAlert.setTitle("Allert", for: .normal)
        btShowAlert.backgroundColor = .systemYellow
        btShowAlert.setTitleColor(.black, for: .normal)
        btShowAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        view.addSubview(btShowPost)
        view.addSubview(btShowAlert)

    }
    @objc func closeInfo(){

        self.dismiss(animated: true, completion: nil)

    }
    @objc func showAlert(){
        let alert = UIAlertController(title: "It's alert", message: "All is Ok", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let actionOk = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(actionOk)
        alert.addAction(actionCancel)
        present(alert, animated: false)
    }
}
