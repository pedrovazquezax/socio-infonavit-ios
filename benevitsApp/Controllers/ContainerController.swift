//
//  ContainerController.swift
//  ednienksnkuesnf
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    var menuController: UIViewController!
    var centerController:UIViewController!
    var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureHomeController()
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func configureHomeController(){
        let mainController = MainCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        mainController.delegate = self
        centerController = UINavigationController(rootViewController: mainController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent:self)
    }
    
    func configureMenuController(){
        if menuController == nil{
             menuController =  MenuViewController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    func showMenuController(shoudExpand:Bool){
        if shoudExpand {
            UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width/2
            }, completion: nil)
        }else{
            UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: nil)
        }
        
    }

}
extension ContainerController: HomeControllerDelegate{
    func handleMenuToogle() {
        if !isExpanded{
            configureMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shoudExpand: isExpanded )
    }
}
