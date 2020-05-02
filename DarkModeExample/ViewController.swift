//
//  ViewController.swift
//  DarkModeExample
//
//  Created by mukesh on 1/5/20.
//  Copyright © 2020 mandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties

    fileprivate let reuseIdentifier = "CustomCell"
    fileprivate let dataSourceArr = ["Hello", "I", "am", "Groot", ":)"]

    lazy var leftBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dark mode"),
                        for: .normal)
        button.setImage(UIImage(named: "light mode"),
                        for: .selected)
        button.frame = CGRect(x: 0,
                              y: 0,
                              width: 35,
                              height: 35)
        button.tintColor = UIColor.white
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.addTarget(self,
                         action: #selector(toogleDarkMode),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - IBOutlets

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: "CustomCell",
                                     bundle: nil),
                               forCellReuseIdentifier: reuseIdentifier)
        }
    }

    // MARK: - Life cycle

    // MARK: - Set up

    // MARK: - IBActions

    // MARK: - Actions
    // Implement this method only for iOS version less than 13
    @objc func toogleDarkMode() {
        // Toggle Theme Logic
        leftBarButton.isSelected = !leftBarButton.isSelected
        ThemeManager.isDarkModeEnabled = !ThemeManager.isDarkModeEnabled
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "themeChange"),
                                        object: nil)
    }

    // MARK: - Navigation

    // MARK: - Network Manager calls

    // MARK: - Extensions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isTranslucent = false
        if #available(iOS 13, *) {
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        }

        // Theme
        addThemeChangeObserver()
        configureSubviewsColors()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CustomCell else {
            return UITableViewCell()
        }
        cell.backgroundColor = UIColor.background
        cell.titleLabel.text = dataSourceArr[indexPath.row]
        cell.titleLabel.textColor = UIColor.primaryText
        return cell
    }
}

extension ViewController: ThemeProtocol {
    func configureSubviewsColors() {
        tableView.backgroundColor = UIColor.background
        tableView.reloadData()
        navigationController?.navigationBar.barTintColor = UIColor.navBar
    }
}
    
