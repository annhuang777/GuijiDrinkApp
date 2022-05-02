//
//  menuViewController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/4/3.
//

import UIKit

class menuViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
  
    //banner model init.
    var banner:BannerData?
    
    //bannerOutlet
  
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
     //使用containerView切換不同tableViewController
    @IBOutlet var containerViews: [UIView]!
    @IBOutlet weak var categoriesSeg: UISegmentedControl!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 4, target: self, selector:#selector(imageChange), userInfo:nil, repeats: true)
          
  
    
    }
     
    
    @objc func imageChange(){
        
        var indexPath:IndexPath?
        imageIndex += 1
        
        if imageIndex < images.count{
            indexPath = IndexPath(item: imageIndex, section: 0)
            bannerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            

        } else {
            imageIndex = 0
            indexPath = IndexPath(item: imageIndex, section: 0)
            bannerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition:.centeredHorizontally)

        }
        
        
    }
    
    
    @IBAction func tappedSegmented(_ sender: UISegmentedControl) {
        
        for containerView in containerViews{
            //isHidden = false(no show),otherwise
            //個別的containerView is no show
            containerView.isHidden = true
            
        }
       //被segmentedControl選的containerView is show
        containerViews[sender.selectedSegmentIndex].isHidden = false
    
        
    }
    
    //bannerCollectionView
    let images = ["P0","P1","P2","P3"]
    var imageIndex = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? bannerCollectionViewCell else{return UICollectionViewCell()}
        
        cell.bannerImage.image = UIImage(named:images[indexPath.item])
        
        return cell
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

    


