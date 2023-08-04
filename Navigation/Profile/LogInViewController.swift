import UIKit

final class LoginViewController: UIViewController {
    
    let colorSet = UIColor(hex: "#d3d3d3")
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let loginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logoLogin: UIView = {
        let image = UIView()
        image.layer.contents = UIImage(named: "logo")?.cgImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let authorizationViewGroup: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var  loginText: UITextField = {
        let text = UITextField()
        text.placeholder = "Email or phone"
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        return text
    }()
    
    private lazy var passwordText: UITextField = {
        let text = UITextField()
        text.placeholder = "Password"
        text.backgroundColor = .systemGray6
        text.textColor = .black
        text.autocapitalizationType = .none
        text.indent(size: 16)
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.delegate = self
        return text
    }()
    
    private let warningPassword: UITextView = {
        let text = UITextView()
        text.text = "Внимание!\nДопускаются пароли от шести символов и длинее!"
        text.isEditable = false
        text.textAlignment = .center
        text.textColor = .red
        text.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.alpha = 0.0
        return text
    }()
    
    private let btLogIN: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        let title = "Log In"
        let attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)])
        button.setAttributedTitle(attributedText, for: .normal)
        let buttonNoNormalColor: UIColor = .white.withAlphaComponent(0.8)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(buttonNoNormalColor, for: .selected)
        button.setTitleColor(buttonNoNormalColor, for: .highlighted)
        button.setTitleColor(buttonNoNormalColor, for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(authorization), for: .touchUpInside)
        return button
    }()
    
    var user: Users {Users.craeteUser(login: "Admin", password: "Qaz123")}
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(loginView)
        loginView.addSubview(logoLogin)
        loginView.addSubview(authorizationViewGroup)
        loginView.addSubview(warningPassword)
        
        authorizationViewGroup.addArrangedSubview(loginText)
        authorizationViewGroup.addArrangedSubview(separatorView)
        authorizationViewGroup.addArrangedSubview(passwordText)
        loginView.addSubview(btLogIN)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func willShowKeyboard(notification: NSNotification) {
        if let keyboardSize: CGRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: keyboardSize.height,
                                                                    right: 0)
        }
        
    }
    
    @objc private func willHideKeyboard() {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func authorization() {
        warningPassword.alpha = 0.0
        
        guard (loginText.text != "" && passwordText.text != "") else  {
            authorizationViewGroup.layer.borderColor = UIColor.red.cgColor
            separatorView.backgroundColor = .red
            authorizationFaledAnimation()
            return
        }
        let isLongPassword: Bool = { (passwordText.text?.count) ?? 0 >= 6 }()
        guard isLongPassword else {
            warningPassword.alpha = 1.0
            authorizationViewGroup.layer.borderColor = UIColor.red.cgColor
            separatorView.backgroundColor = .red
            authorizationFaledAnimation()
            return
        }
        
        let isTruePassword: Bool = { user.login == loginText.text && user.password == passwordText.text}()
        
        guard isTruePassword else {
            authorizationViewGroup.layer.borderColor = UIColor.red.cgColor
            separatorView.backgroundColor = .red
            alertPassword()
            return
        }
        
        authorizationViewGroup.layer.borderColor = UIColor.lightGray.cgColor
        separatorView.backgroundColor = .lightGray
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func alertPassword(){
        let alert = UIAlertController(title: "Attention", message: "Wrong login or password", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default) { _ in self.loginText.text = ""
            self.passwordText.text = ""
        }
        alert.addAction(actionOk)
        present(alert, animated: false)
    }
    
    private func authorizationFaledAnimation(){
        let animatorRight = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.authorizationViewGroup.center.y += 10
        }
        let animatorLeft = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.authorizationViewGroup.center.y -= 20
        }
        let animatorCanter = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            self.authorizationViewGroup.center.y += 10
        }
        animatorRight.addCompletion{_ in
            animatorLeft.startAnimation(afterDelay: 0.0)
        }
        animatorLeft.addCompletion{_ in
            animatorCanter.startAnimation(afterDelay: 0.0)
        }
        animatorRight.startAnimation(afterDelay: 0.0)
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            loginView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            loginView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoLogin.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            logoLogin.topAnchor.constraint(equalTo:  loginView.topAnchor, constant: 120),
            logoLogin.widthAnchor.constraint(equalToConstant: 100),
            logoLogin.heightAnchor.constraint(equalTo: logoLogin.widthAnchor),
            
            authorizationViewGroup.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16),
            authorizationViewGroup.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16),
            authorizationViewGroup.topAnchor.constraint(equalTo: logoLogin.bottomAnchor, constant: 120),
            authorizationViewGroup.heightAnchor.constraint(equalToConstant: 100),
            
            warningPassword.bottomAnchor.constraint(equalTo: authorizationViewGroup.topAnchor, constant: -16),
            warningPassword.heightAnchor.constraint(equalToConstant: 50),
            warningPassword.widthAnchor.constraint(equalTo: loginView.widthAnchor),
            
            
            loginText.heightAnchor.constraint(equalToConstant: 49.5),
            passwordText.heightAnchor.constraint(equalToConstant: 49.5),
            
            btLogIN.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 16),
            btLogIN.trailingAnchor.constraint(equalTo: loginView.trailingAnchor, constant: -16),
            btLogIN.topAnchor.constraint(equalTo: authorizationViewGroup.bottomAnchor, constant: 16),
            btLogIN.heightAnchor.constraint(equalToConstant: 50),
            btLogIN.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),
        ])
    }
    
}
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        textCheck(textField)
        return true
    }
    func textCheck(_ textField: UITextField){
        if (textField == loginText || textField == passwordText) && textField.text == ""  {
            authorizationViewGroup.layer.borderColor = UIColor.red.cgColor
            separatorView.backgroundColor = .red
            
        } else {
            authorizationViewGroup.layer.borderColor = UIColor.lightGray.cgColor
            separatorView.backgroundColor = .lightGray
        }
        
    }
}
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

