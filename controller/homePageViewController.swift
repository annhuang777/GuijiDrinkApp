//
//  homePageViewController.swift
//  Guiji
//
//  Created by Pin yu Huang on 2022/3/25.
//

import UIKit

class homePageViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var secondImageview: UIImageView!
    
    @IBOutlet weak var orderLabel: UILabel!
    
    
                                         
                       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //label在載入時設為隱藏
        orderLabel.isHidden = true
        
        //firstImageView在使用手勢之下要設為true
        firstImageView.isUserInteractionEnabled = true

        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.addTarget(self, action: #selector(TapToChange(gesture:)))
        firstImageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    @objc func TapToChange(gesture:UITapGestureRecognizer){
        
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseOut) {
            self.firstImageView.alpha = 0
        } completion: { (_) in
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
                self.orderLabel.isHidden = false
                self.orderLabel.transform = CGAffineTransform(translationX: 0, y:80)

            }

        }

        
       
        
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
    

