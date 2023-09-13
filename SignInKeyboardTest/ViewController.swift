//
//  ViewController.swift
//  SignInKeyboardTest
//
//  Created by David Ruvinskiy on 8/17/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.setLeftPaddingPoints(10)
        textField.tintColor = .label
        textField.backgroundColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.returnKeyType = .next
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.setLeftPaddingPoints(10)
        textField.tintColor = .label
        textField.backgroundColor = .gray
//        textField.isSecureTextEntry = true // If I comment this out, the jerking stops
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.returnKeyType = .done
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    let graphicImageView: UIImageView = {
        let graphicImageView = UIImageView(image: UIImage(named: "Illustration_SingIn"))
        graphicImageView.contentMode = .scaleAspectFit
        graphicImageView.translatesAutoresizingMaskIntoConstraints = false
        graphicImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        graphicImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return graphicImageView
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["One", "Two"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.setContentCompressionResistancePriority(.required, for: .vertical)
        segmentedControl.setContentHuggingPriority(.required, for: .vertical)
        return segmentedControl
    }()
    
    var textFields: [UITextField] {
        return [usernameTextField, passwordTextField]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(segmentedControl)
        view.addSubview(graphicImageView)
        view.addSubview(button)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            graphicImageView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            graphicImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            graphicImageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.7),
            graphicImageView.heightAnchor.constraint(equalTo: graphicImageView.widthAnchor),
            
            usernameTextField.topAnchor.constraint(equalTo: graphicImageView.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            button.heightAnchor.constraint(equalToConstant: 44),

            button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let selectedTextFieldIndex = textFields.firstIndex(of: textField), selectedTextFieldIndex < textFields.count - 1 {
            textFields[selectedTextFieldIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder() // last textfield, dismiss keyboard directly
        }
        return true
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
