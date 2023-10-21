

import Foundation
import UIKit

extension ViewController {
    func createUI() {
        view.addSubview(numberTextField)
        view.addSubview(convertButton)
        
        numberTextField.placeholder = "Please enter some roman numbers"
        numberTextField.borderStyle = .roundedRect
        numberTextField.autocapitalizationType = .allCharacters
        numberTextField.layer.borderWidth = 1
        numberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-70)
        }
        
        convertButton.setTitle("Convert", for: .normal)
        convertButton.configuration = .filled()
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(50)
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
        }
        convertButton.addTarget(self, action: #selector(convertNumber), for: .touchUpInside)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gesture)
        
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @objc func convertNumber() {
        if let text = numberTextField.text {
            let number = RomanNumbers(number: text)
            let result = number.romanToInt(number.number)
            
            if result == -1 {
                makeAlert(title: "Error",message: "Hatalı çevrim", result: result)
            }
            makeAlert(title: "Success", result: result)
        }
    }
    
    func makeAlert(title: String, message: String? = nil, result: Int) {
        let alert = UIAlertController(title: title, message: "Decimal number is \(result)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        let favoriteAction = UIAlertAction(title: "Save", style: .default) { action in
            let key = self.numberTextField.text!
            self.userDefaults.set(result, forKey: key)
        }
        if message != nil {
            alert.message = message
        } else {
            alert.addAction(favoriteAction)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
}
