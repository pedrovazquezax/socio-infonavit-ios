//
//  MainCollectionViewController.swift
//  ednienksnkuesnf
//
//  Created by Pedro Antonio Vazquez Rodriguez on 08/09/20.
//  Copyright © 2020 Pedro Antonio Vazquez Rodriguez. All rights reserved.
//

import UIKit
import SkeletonView
private let identifier = "rowCell"

class MainCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    weak var delegate:HomeControllerDelegate?

    var wallets = [Wallet]()
    
    var benevits : AllBenevits? = nil

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        configureNavigationBar()
        collectionView.backgroundColor = .systemGray5
        self.collectionView!.register(UINib(nibName: "RowCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: identifier)
               collectionView.delegate = self
               collectionView.dataSource = self
               
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                 let service = Service()
            service.getLandingBenevits(Autorization: UserDefaults.standard.object(forKey: "Authorization") as! String)
                   service.getMemberWallets(Autorization:  UserDefaults.standard.object(forKey: "Authorization") as! String)
                service.walletCompletitionHandler{ [weak self](wallets,status,message) in
                    if status{
                        guard let self = self else{return}
                        guard let wallet =  wallets else {return}
                        self.wallets = wallet
                       
                        self.manageData()
                        
                    }else{
                        debugPrint(message)
                    }
                    
                }
                service.benevitsCompletitionHandler{ [weak self](benevits,status,message) in
                    if status{
                        guard let self = self else{return}
                        guard let benevit =  benevits else {return}
                        self.benevits = benevit
                        self.manageData()
                    }else{
                        debugPrint(message)
                    }
                    
                }
                    
                
                   
                }
    
        }
    func manageData(){
        guard let benevit = benevits else {return}
        if  wallets.count != 0{
            for a in 0..<wallets.count{
                for b in 0..<benevit.Locked.count{
                    if wallets[a].id == benevit.Locked[b].wallet.id{
                        var aux = benevit.Locked[b]
                        aux.locked = true
                        if wallets[a].benevits == nil{
                            wallets[a].benevits = [aux]
                        }else{
                            wallets[a].benevits!.append(aux)
                        }
                        
                        
                    }
                }
            }
            for a in 0..<wallets.count{
                for b in 0..<benevit.Unlocked.count{
                    if wallets[a].id == benevit.Unlocked[b].wallet.id{
                        var aux = benevit.Unlocked[b]
                        aux.locked = false
                        if wallets[a].benevits == nil{
                            wallets[a].benevits = [aux]
                        }else{
                            wallets[a].benevits!.append(aux)
                        }
                    }
                }
            }
        self.collectionView.stopSkeletonAnimation()
        self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        self.collectionView.reloadData()
        }
    }

   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.isSkeletonable = true
        collectionView.showSkeleton(usingColor: .white, transition: .crossDissolve(0.25))
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return wallets.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:identifier, for: indexPath) as! RowCollectionViewCell
        // Configure the cell
        if !wallets.isEmpty{
            cell.titleLabel.text = wallets[indexPath.item].name
            cell.benevits = wallets[indexPath.item].benevits ?? []
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
    func configureNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor(named: "rojoInfonavit")
        navigationController?.navigationBar.barStyle = .black
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(handleMenuShow))
        menuBarButton.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBarButton
    }
    @objc func handleMenuShow(){
        delegate?.handleMenuToogle()
    }
}

extension MainCollectionViewController: SkeletonCollectionViewDataSource{
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return identifier
    }
    
    
}
