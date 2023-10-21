

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate {

    let tableView = UITableView()
    let userDefaults = UserDefaults.standard
    var keyArray: [String] = []
    var valueArray: [Int] = []
    let blacklisted_prefixes = ["Country", "NS", "com.apple", "com.omnigroup", "NavPanel", "WebAutomatic", "NSTableViewDefaultSizeMode", "sks_agent", "Apple", "PayloadUUID", "PKSecure", "_HI", "AK", "ContextMenu", "MultipleSession", "CSUI", "PKLogNotificationServiceResponsesKey", "AddingEmojiKeybordHandled"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        createUI()
    }
    
    private func createUI() {
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func fetchDefaults() {
        let dict = UserDefaults.standard.dictionaryRepresentation()
        let keys = dict.keys.filter { key in
          for prefix in blacklisted_prefixes {
            if key.hasPrefix(prefix) {
              return false
            }
          }
          return true
        }
        
        for key in keys {
            keyArray.append(key)
            valueArray.append(userDefaults.integer(forKey: key))
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        keyArray.removeAll(keepingCapacity: false)
        valueArray.removeAll(keepingCapacity: false)
        fetchDefaults()
        tableView.reloadData()
    }
    
}


