//
//  HomeViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    var user: User!
    
    //Set the newInstance method
    static func newInstance(user : User) -> HomeViewController
    {
        let controller = HomeViewController()
        controller.user = user
        return controller
    }

    override func viewDidLoad() {        
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = true;
        
        self.title = "Home"
        let proposedCourseVC = UINavigationController(rootViewController: ProposedCourseViewController())
        let validatedCourseVC = UINavigationController(rootViewController: ValidatedCourseViewController.newInstance(user: user))
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        
        super.viewDidLoad()
        
        proposedCourseVC.title = "Liste des cours proposés"
        validatedCourseVC.title = "Liste des cours validés"
    
        //We could set images for each items in the tab bar
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([
        proposedCourseVC,
        validatedCourseVC]
        , animated: false)
        
        tabBarVC.modalPresentationStyle = .fullScreen
        
        present(tabBarVC,animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

}


