//
//  NameControll.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 06/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

class NameControll: UIControl {
    var letters: [String] = []
    var selectedLetter: Character? = nil {
        didSet {
            self.updateSelectedLetter()
            self.sendActions(for: .valueChanged)
        }
    }
    private var buttons: [UIButton] = []
    private var stakView: UIStackView!
    
    
    func createArray(inArray: [VKUser]) {
        var tempSet = Set<Character>()
        letters.removeAll()
        for user in inArray {
            tempSet.insert(user.userName[user.userName.startIndex])
        }
        for tempLet in tempSet {
            letters.append(String(tempLet))
        }
        //вызываем не из инициализаторов, а после создания массива
        self.setupView()
    }
    
    private func setupView() {
        for letter in letters {
            let button = UIButton(type: .system)
            button.setTitle(String(letter), for: .normal)
            button.setTitleColor(UIColor.red, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleShadowColor(UIColor.black, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        stakView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stakView)
        stakView.spacing = 8
        stakView.axis = .horizontal
        stakView.alignment = .center
        stakView.distribution = .fillEqually
    }
    
    private func updateSelectedLetter() {
        //здесь код для выполнения нажатия.
    }
    
    //Размеры
    override func layoutSubviews() {
        super.layoutSubviews()
        stakView.frame = bounds
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        let letter = letters[index]
        self.selectedLetter = Character(letter)
    }
}



