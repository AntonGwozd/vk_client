//
//  ViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 10/09/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text else {
            titleLabel.text = "wrong login! try again."
            return }
        guard let password = passwordTextField.text else {
            titleLabel.text = "wrong password! try again."
            return }
        
        // если текста нет совсем возвращает string "" а не nil
        // делаем бордюры красным подсвечивая не заполненные поля и убираем подсветку если поля заполнены.
        if login == "" {
            loginTextField.layer.borderColor = UIColor.red.cgColor
            loginTextField.layer.borderWidth = 1.0
            loginTextField.placeholder = "wrong login!"
        } else {
            loginTextField.layer.borderColor = UIColor.black.cgColor
            loginTextField.layer.borderWidth = 0.0
        }
        
        if password == "" {
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.placeholder = "wrong pasword!"
        } else {
            passwordTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderWidth = 0.0
        }
        //Конец области подсветки
        
        if login == "AntonGwozd" && password == "123456" {
            titleLabel.text = "accept"
            
        } else {
            titleLabel.text = "wrong! try again."
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Enter your account"
        loginLabel.text = "Login:"
        passwordLabel.text = "Password:"
        loginTextField.placeholder = "login"
        passwordTextField.placeholder = "password"
        loginButton.setTitle("Log In", for: .normal)
        
        //Распознователь жестов
        let hideKeyboardGestute = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //добавляем распознователь в скрол вью
        scrollView.addGestureRecognizer(hideKeyboardGestute)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //Метод изменения высоты скрол вью по размеру клавиатуры
    @objc func keyboardWasShow (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    //Метод убирания отступов
    @objc func keyboardWillHide (notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    //Метод скрытия клавиатуры
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}

