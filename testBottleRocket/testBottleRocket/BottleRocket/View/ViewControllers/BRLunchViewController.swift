//
//  ViewController.swift
//  testBottleRocket
//
//  Created by roreyesl on 07/09/21.
//

import UIKit

class BRLunchViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var lunchCollectionView: UICollectionView!{
        didSet{
            lunchCollectionView.register(UINib(nibName: "BRLunchCollectionViewCell", bundle: Bundle(for: BRLunchViewController.self)), forCellWithReuseIdentifier: "BRLunchCollectionViewCell")
            lunchCollectionView.delegate = self
            lunchCollectionView.dataSource = self
            
        }
    }
    
    // MARK: - Properties
    
    private var viewModel : BRRestaurantsViewModel = BRRestaurantsViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        consultInfo()
        ProgressView.showHUDAddedToWindow()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? BRDetailLunchViewController, let iRowSelected = sender as? Int {
            vc.setViewModel(withVM: self.viewModel, withRowSelected: iRowSelected)
        }
    }
    
    // MARK: - Private
    
    private func consultInfo(){
        viewModel.loadInfoRestaurant { error in
            if error.code.isSuccess{
                self.lunchCollectionView.reloadData()
            }else{
                self.present(AlertGeneric.simpleWith(message:error.userInfo["mensaje"] as? String ), animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - Extensions

extension BRLunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:self.view.frame.size.width , height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BRLunchCollectionViewCell", for: indexPath) as? BRLunchCollectionViewCell
        else { return UICollectionViewCell() }
        cell.instantiateCell(withData: viewModel.getDataRestaurantAtIndex(withRow: indexPath.row))
        return cell
        
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInSection()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "BRLunchVCToBRDetailLunchVC", sender: indexPath.row)
    }
}
