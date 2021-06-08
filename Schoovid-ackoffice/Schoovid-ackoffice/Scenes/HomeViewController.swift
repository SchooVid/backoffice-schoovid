//
//  HomeViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController, MenuControllerDelegate {
    
    private var sideMenu: SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton))
        
        // Do any additional setup after loading the view.
        
        let menu =  MenuController(with: [
            NSLocalizedString("home.controller.title", comment: "")
        ])
              menu.delegate = self
              sideMenu = SideMenuNavigationController(rootViewController: menu)
              sideMenu?.leftSide = true
              SideMenuManager.default.leftMenuNavigationController = sideMenu
              SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.setNavigationBarHidden(false,animated:animated)
    }
    
    @objc func didTapMenuButton() {
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
            sideMenu?.dismiss(animated: true, completion: {
                if named == NSLocalizedString("home.controller.title", comment: "") {
                    print("ok")
                }
            })
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named:String)
}

class MenuController: UITableViewController{
    private let menuItems: [String]
    public var delegate:MenuControllerDelegate?
    private let darkerGray = UIColor(red:33/255.0,green:33/255.0,blue:33/255.0, alpha :1)
    
    init(with menuItems : [String]){
        self.menuItems = menuItems
        super.init(nibName : nil,bundle:nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Table View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = darkerGray
        tableView.backgroundColor = darkerGray
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkerGray
        cell.contentView.backgroundColor = darkerGray
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Lien
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
        
    }
}
