//
//  MainPageViewController.swift
//  Storyboard VIPER
//
//  Created by Kemal Sanli on 14.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var MainPresenter: ViewToPresenterMainProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewAttributes()
        MainRouter.createModule(ref: self)
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MainPresenter?.getBookData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToDetail" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.model = sender as? Result
        }
    }
    
    
}


extension MainViewController: PresenterToViewMainProtocol {
    func sendSegueObject(object: Result) {
        self.performSegue(withIdentifier: "mainToDetail", sender: object)
    }
    
    func sendNextIndex() {
        collectionView.reloadData()
    }
    
    func sendBookData() {
        collectionView.reloadData()
    }
}

