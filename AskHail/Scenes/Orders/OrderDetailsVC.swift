//
//  OrderDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/4/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class OrderDetailsVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    
    @IBOutlet weak var OrderTitleTf: UITextField!
    @IBOutlet weak var OrderTitleLineView: UIView!
    
    @IBOutlet weak var PriceTf: UITextField!
    @IBOutlet weak var PriceImage: UIImageView!
    @IBOutlet weak var PriceLineView: UIView!
    
    @IBOutlet weak var directionTf: UITextField!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLineView: UIView!
    
    @IBOutlet weak var RegionTf: UITextField!
    @IBOutlet weak var RegionImage: UIImageView!
    @IBOutlet weak var RegionLineView: UIView!

    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var DirectionPicker = UIPickerView()
    var RegionPicker = UIPickerView()
    
    var DirectionArray : [SidesData] = []
    var RegionArray : [BlocksData] = []
    var FeatureArray : [FeaturesData] = []
    var cellArray = [AddDetailsCell]()
    
    var FeatureData = false
    
    var SelectedFeature = [Int : Feature_data]()
    
    var Direction_id = 0
    var Region_id = 0
    var Ad_id = ""
    
    var Section_id = ""
    var SubSection_id = ""
    
    var isHome = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRegion()
        getDirection()
        getFeature()
        
        OrderTitleTf.placeHolderColor = Colors.PlaceHolderColoer
        PriceTf.placeHolderColor = Colors.PlaceHolderColoer
        directionTf.placeHolderColor = Colors.PlaceHolderColoer
        RegionTf.placeHolderColor = Colors.PlaceHolderColoer
        
        DetailsCollectionView.delegate = self
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.RegisterNib(cell: AddDetailsCell.self)

        
        OrderTitleTf.delegate = self
        PriceTf.delegate = self
        directionTf.delegate = self
        RegionTf.delegate = self
        desTxt.delegate = self
        
        OrderTitleTf.setPadding(left: 16, right: 16)
        PriceTf.setPadding(left: 16, right: 16)
        directionTf.setPadding(left: 16, right: 16)
        RegionTf.setPadding(left: 16, right: 16)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
       
        
        self.directionTf.inputView = DirectionPicker
        self.RegionTf.inputView = RegionPicker
        
        self.initPickers(picker: self.DirectionPicker)
        self.initPickers(picker: self.RegionPicker)
        
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        if L102Language.currentAppleLanguage() == "en" {
            desTxt.text = "Description of the request"
            
        }else {
            
            desTxt.text = "وصف الطلب"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DetailsCollectionView.layer.removeAllAnimations()
        ScrollHeight.constant = DetailsCollectionView.contentSize.height + 650
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if desTxt.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            desTxt.text = ""
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if OrderTitleTf.text?.isEmpty != true , PriceTf.text?.isEmpty != true , desTxt.text?.isEmpty != true , desTxt.text != "وصف الطلب" , desTxt.text != "Description of the request" , directionTf.text?.isEmpty != true ,RegionTf.text?.isEmpty != true {
            
            SetDetails()
            
        } else {
            
            if OrderTitleTf.text?.isEmpty == true {
                ErrorLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: false)
            }
            if PriceTf.text?.isEmpty == true {
                ErrorLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: false)
            }
            if desTxt.text?.isEmpty == true || desTxt.text == "وصف الطلب" || desTxt.text == "Description of the request"{
                
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            if directionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: false)
            }
            
            if RegionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: directionLineView, ishidden: false)
            }
            
            self.view.shake()
            
        }
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderTitleTf {
            
            EnableLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: false)
            
        } else if textField == PriceTf {
            
            EnableLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money-white"), lineView: PriceLineView, ishidden: false)
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction-2"), lineView: directionLineView, ishidden: false)
            
            if DirectionArray.count > 0 {
                directionTf.text = DirectionArray[0].side_name
            }
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: RegionLineView, ishidden: false)
            
            if RegionArray.count > 0 {
                RegionTf.text = RegionArray[0].block_name
            }
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField.text?.isEmpty == true{
            
            if textField == OrderTitleTf {
                
                EnableLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: true)

            } else if textField == PriceTf {
                
                EnableLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: true)
                
            } else if textField == directionTf {
                
                EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: PriceLineView, ishidden: true)
                
                
            } else if textField == RegionTf {
                
                EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: true)
                
                
            }
        }
        
        
        return true;
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
        }
        return true;
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: true)
        }
        
        return true;
    }
}

extension OrderDetailsVC : UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func initPickers(picker: UIPickerView) {
        
        picker.dataSource = self as! UIPickerViewDataSource
        picker.delegate = self as! UIPickerViewDelegate
        picker.tintColor = #colorLiteral(red: 0.840886116, green: 0.6630725861, blue: 0.2519706488, alpha: 1)
        picker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == DirectionPicker {
            
            return DirectionArray.count
            
        }else if pickerView == RegionPicker {
            
            return RegionArray.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                print(row)
                Direction_id = DirectionArray[row].side_id ?? 0
                return DirectionArray[row].side_name
            }
            
        }else if pickerView == RegionPicker{
            
            if RegionArray.count != 0 {
                
                print(row)
                Region_id = RegionArray[row].block_id ?? 0
                return RegionArray[row].block_name
                
            }
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                directionTf.text = DirectionArray[row].side_name
                Direction_id = DirectionArray[row].side_id ?? 0
                
            }
        }else if pickerView == RegionPicker {
            
            if RegionArray.count != 0 {
                
                RegionTf.text = RegionArray[row].block_name
                Region_id = RegionArray[row].block_id ?? 0
                
            }
        }
    }
}

//MARK:- CollectionView Contoller

extension OrderDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDetailsCell", for: indexPath) as! AddDetailsCell
    

        
        for item in SelectedFeature {
            
            print(item.key , indexPath.row)
            
            if item.key == indexPath.row {
                
                cell.DetailTf.text = item.value.data_title
                
            }
            
        }
        
        
        
        if FeatureData {
            
            let model = FeatureArray[indexPath.row]
            
            cell.DetailTf.placeholder = model.feature_name ?? ""
            
            if model.feature_type == "choose" {
                cell.arrow_doun.isHidden = false
                cell.ChoseDetailsBtn.isHidden = false
            }else{
                cell.arrow_doun.isHidden = true
                cell.ChoseDetailsBtn.isHidden = true
            }
            
            
            cell.ChoseDetails = {
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "ChoseFeaturePopupVC") as! ChoseFeaturePopupVC
                vc.modalPresentationStyle = .fullScreen
                vc.Delegte = self
                vc.index = indexPath.row
                vc.FeatureData = self.FeatureArray[indexPath.row].feature_data ?? []
                vc.pageTitle = self.FeatureArray[indexPath.row].feature_name ?? ""
                self.addChild(vc)
                vc.view.frame = self.view.frame
                self.view.addSubview(vc.view)
                vc.didMove(toParent: self)
            }
            
        }
        
        return cell
    }
    
}

extension OrderDetailsVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let width = collectionView.frame.width
            return CGSize.init(width: width , height:56)
        
    }
}

//MARK:- Protocol Controller
extension OrderDetailsVC : ChoseFromFeature {
    func choseFeature(data: Feature_data, index: Int) {
        SelectedFeature[index] = data
        print(SelectedFeature)
        let indexPath = IndexPath.init(row: index, section: 0)
           let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
        cell.DetailTf.text = data.data_title

    }
}


//MARK:-API
extension OrderDetailsVC {
    
    func SetDetails() {
        self.view.lock()
        
        var Parameters = [
            
            "order_id" : Ad_id,
            "title" : OrderTitleTf.text ?? "",
            "description" : desTxt.text ?? "",
            "price" : PriceTf.text ?? "",
            "side_id" : "\(Direction_id)",
            "block_id" : "\(Region_id)"
        ] as [String : Any]
        
        var features = self.SelectedFeature.values
        var selected_ides = [Int]()
        var x = 0
        for item in SelectedFeature {
            
            Parameters["features[\(x)]['feature_id']"] = "\(self.FeatureArray[item.key].feature_id ?? 0)"
            Parameters["features[\(x)]['answer']"] = "\(item.value.data_id ?? 0)"
            
            
            print(self.FeatureArray[item.key].feature_id ?? 0 , item.value.data_feature_id ?? 0)
            x = x + 1
        }
           
        
        print(cellArray.count)
        
        var y = 0
        for item in FeatureArray {
            
            let indexPath = IndexPath.init(row: y, section: 0)
               let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell


            if FeatureArray[y].feature_type == "text" {

                

                if cell.DetailTf.text != "" {

                    print(y)

                    Parameters["features[\(x)]['feature_id']"] = "\( FeatureArray[y].feature_id ?? 0)"
                    Parameters["features[\(x)]['answer']"] = cell.DetailTf.text ?? ""
                }
                x = x + 1
            }
         y = y + 1
           
        }
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-add-order/level3-add-details", imagesArray: nil, profileImage: nil, commercial_register_image: nil, office_license_image: nil, id_image: nil, VediosArray: nil, VediosDuration: nil) { (data : Level_1_Model?, String) in
                
            
            self.view.unlock()
            
            if String != nil {
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
            }else {
                
                guard let data = data else {
                    return
                }
                
                let storyboard = UIStoryboard(name: Order , bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "OrderContactNumberVC") as! OrderContactNumberVC
                vc.Ad_id = self.Ad_id
                vc.Section_id = self.Section_id
                vc.SubSection_id = self.SubSection_id
                self.navigationController?.pushViewController(vc, animated: true)
                
                print(data)
                
            }
        }
    }
    
    func getRegion() {
        
        self.view.lock()
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)blocks") { (data : BlocksModel?, String) in
       
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.RegionArray = data.data ?? []
                
               
                print(data)
                
                
            }
        }
    }
    
    func getDirection() {
        
       ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)sides") { (data : SidesModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.DirectionArray = data.data ?? []
                
               
                print(data)
                
                
            }
        }
    }
    
    func getFeature() {
        
        let Parameters = [
            "order_id": Ad_id,
        ] as [String : Any]
        
        print(Ad_id)
        
        
       ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-add-order/show-order-features") { (data : FeaturesModel?, String) in
            
        self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                print(data)
                if data.data?.count ?? 0 > 0 {
                    self.FeatureArray = data.data ?? []
                    self.FeatureData = true
                }
               
                self.DetailsCollectionView.reloadData()

                print(data)
            }
        }
    }
    
}
