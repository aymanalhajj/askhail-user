//
//  BusinessAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView
import Cosmos

class BusinessAdsVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    // MARK: OutLet0
    
    @IBOutlet weak var RateView: CosmosView!
    
    @IBOutlet weak var AdsNumber: UILabel!
    @IBOutlet weak var AdsTitle: UILabel!
    @IBOutlet weak var AdsRate: UILabel!
    @IBOutlet weak var AdsDisnatce: UILabel!
    @IBOutlet weak var ViewsNumber: UILabel!
    @IBOutlet weak var AdsDate: UILabel!
    
    
    @IBOutlet weak var AdsDescribtion: UILabel!
    @IBOutlet weak var PlaceSpace: UILabel!
    @IBOutlet weak var PlacceAllSpace: UILabel!
    @IBOutlet weak var PlaceDirection: UILabel!
    @IBOutlet weak var haveParking: UILabel!
    @IBOutlet weak var HaveWareHouse: UILabel!
    
    @IBOutlet weak var Addess: UILabel!
    
    @IBOutlet weak var AdsOwnerName: UILabel!
    @IBOutlet weak var NumberOsAds: UILabel!
    
    @IBOutlet weak var NumberOfComments: UILabel!
    
    @IBOutlet weak var TotalCommentsRate: UILabel!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    @IBOutlet weak var StarAdsView: UIView!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
    
    var CommentArray = [String]()
    var checkBox = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            RateView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 5
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: JobCell.self)
        
        
        PagerView.dataSource = self
        PagerView.delegate = self
        
        
        
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        PagerView.isInfinite = false
        PagerView.addSubview(pageControl)
        PagerView.addSubview(StarAdsView)
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        PagerView.automaticSlidingInterval = 3.0
        
        print(DetailsView.frame.height)
        
        self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentsTableView.layer.removeAllAnimations()
        ScrollView.constant = CommentsTableView.contentSize.height + DetailsView.frame.height + 1600 + CommentViewHeight.constant
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 5
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        pageControl.currentPage = index
        //           var imageUrl = SliderImages[index].image ?? ""
        
        cell.imageView?.image = #imageLiteral(resourceName: "starAdsImage")
        cell.imageView?.contentMode = .scaleAspectFill
        
        return cell
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func SaveAvtion(_ sender: Any) {
        
        if checkBox == false{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
            checkBox = true
        }else{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
            checkBox = false
        }
        
    }
    
    @IBAction func ShareAds(_ sender: Any) {
        
        print("Share")
        
    }
    
    @IBAction func Photogrphe(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsPopUpVC") as! BusinessAdsPopUpVC
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func ContactTwitterAcction(_ sender: Any) {
        print("Share")
    }
    
    @IBAction func ContactInstgrameAction(_ sender: Any) {
        print("Share")
    }
    
    
    @IBAction func ConractSnapAction(_ sender: Any) {
        print("Share")
    }
    
    @IBAction func ContactFaceBookAction(_ sender: Any) {
        
    }
    
    @IBAction func WebSiteAction(_ sender: Any) {
        
        
    }
    
    @IBAction func GoToPlaceAction(_ sender: Any) {
        
        print("Go to place")
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessPlaceLocationVC") as! BusinessPlaceLocationVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func PhneCallAction(_ sender: Any) {
        
        
    }
    
    @IBAction func WhatsAppAction(_ sender: Any) {
        
    }
    
    @IBAction func AppChatAction(_ sender: Any) {
        
    }
    
    @IBAction func ProfileAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessProfileVC") as! BusinessProfileVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func AddComment(_ sender: Any) {
        
        UIView.animate(withDuration: 0.6, animations: {
            
            self.CommentViewHeight.constant = 172
            self.CommentView.alpha = 1
            self.CommentsTableView.reloadData()
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
             
                
                
            }, completion: { _ in
                
                
            })
        })
    }
    
    
    @IBAction func AddNewComment(_ sender: Any) {
        
        
        
        CommentArray.append("")
        UIView.animate(withDuration: 0.3, animations: {
            
            self.CommentViewHeight.constant = 0
            self.CommentView.alpha = 0
            self.CommentsTableView.reloadData()
         
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
             
                
                
            }, completion: { _ in
                
                
            })
        })
        
        RateView.rating = 0
    }
    
    @IBAction func ShawMoreRateAction(_ sender: Any) {
        
        
    }
    
    
}

// MARK: extension
extension BusinessAdsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as JobCell
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
}

