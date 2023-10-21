

import UIKit
import SnapKit

class ViewController: UIViewController {

    let numberTextField = UITextField()
    let convertButton = UIButton()
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        createUI()
    }
    
    
}


