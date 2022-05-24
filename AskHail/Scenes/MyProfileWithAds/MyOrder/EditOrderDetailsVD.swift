//
//  EditOrderDetailsVD.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/16/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class EditOrderDetailsVD: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var BackGround: UIView!

    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var desTxt: UITextView!
    @IBOutlet weak var desLineView: UIView!
    @IBOutlet weak var desView: UIView!
    
    @IBOutlet weak var OrderTitleTf: UITextField!
    @IBOutlet weak var OrderTitleLineView: UIView!
    @IBOutlet weak var OrderTitleView: UIView!
    
    @IBOutlet weak var PriceTf: UITextField!
    @IBOutlet weak var PriceImage: UIImageView!
    @IBOutlet weak var PriceLineView: UIView!
    @IBOutlet weak var PriceView: UIView!
    
    @IBOutlet weak var directionTf: UITextField!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionLineView: UIView!
    @IBOutlet weak var directionView: UIView!
    
    @IBOutlet weak var RegionTf: UITextField!
    @IBOutlet weak var CityTf: UITextField!
    @IBOutlet weak var BlockTf: UITextField!
    
    
    @IBOutlet weak var RegionImage: UIImageView!
    @IBOutlet weak var RegionLineView: UIView!
    @IBOutlet weak var RegionView: UIView!
    
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var ScrollHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CityView: UIView!
    
    @IBOutlet weak var StateView: UIView!
   
    
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var DirectionPicker = UIPickerView()
    var RegionPicker = UIPickerView()
    var CityPicker = UIPickerView()
    var BlocksPicker = UIPickerView()
    
    var DirectionArray : [SidesData] = []
    var RegionArray : [RegionData] = []
    var CitArray : [CitiesData] = []
    var BlocksArray : [BlocksData] = []
    
    var FeatureArray : [FeaturesData] = []
    var SelectedFeature = [Int : Feature_data]()
    var cellArray = [AddDetailsCell]()
    var CurrentFeatureArray : [Order_specifications] = []
    
    var FeatureData = false
    
    var lat = 0.0
    var lng = 0.0
    var Address = ""
    
    var DetialsData : OrderEditDetailsData?
    
    var Direction_id = ""
    var Region_id = ""
    var City_id = ""
    var Block_id = ""
    
    var Order_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getRegion()
        getDirection()
        getFeature()
        getOrderDetails()
        
        BackGround.backgroundColor = Colors.ViewBackGroundColoer
        
        setShadow(view: TopBar, width: 5, height: 5, shadowRadius: 15, shadowOpacity: 1, shadowColor: #colorLiteral(red: 0.8906363641, green: 0.9258546308, blue: 0.936609456, alpha: 1))
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.8974673004, green: 0.911144314, blue: 0.922011104, alpha: 1))
        
        OrderTitleTf.placeHolderColor = Colors.PlaceHolderColoer
        PriceTf.placeHolderColor = Colors.PlaceHolderColoer
        directionTf.placeHolderColor = Colors.PlaceHolderColoer
        RegionTf.placeHolderColor = Colors.PlaceHolderColoer
        CityTf.placeHolderColor = Colors.PlaceHolderColoer
        BlockTf.placeHolderColor = Colors.PlaceHolderColoer

        OrderTitleTf.delegate = self
        PriceTf.delegate = self
        directionTf.delegate = self
        
        RegionTf.delegate = self
        CityTf.delegate = self
        BlockTf.delegate = self
        desTxt.delegate = self
        
        
        OrderTitleTf.setPadding(left: 16, right: 16)
        PriceTf.setPadding(left: 16, right: 16)
        
        directionTf.setPadding(left: 16, right: 16)
        RegionTf.setPadding(left: 16, right: 16)
        CityTf.setPadding(left: 16, right: 16)
        BlockTf.setPadding(left: 16, right: 16)

        DetailsCollectionView.delegate = self
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.RegisterNib(cell: AddDetailsCell.self)
        
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        setShadow(view: OrderTitleView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: desView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: PriceView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: RegionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: RegionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: RegionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: CityView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: StateView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        setShadow(view: directionView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        
        
        self.directionTf.inputView = DirectionPicker
        self.RegionTf.inputView = RegionPicker
        self.CityTf.inputView = CityPicker
        self.BlockTf.inputView = BlocksPicker
        
        self.initPickers(picker: self.DirectionPicker)
        self.initPickers(picker: self.RegionPicker)
        
        if L102Language.currentAppleLanguage() == "en" {
            desTxt.text = "Description of the Advertising"
            
        }else {
            
            desTxt.text = "وصف الاعلان"
        }
        
        desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DetailsCollectionView.layer.removeAllAnimations()
        ScrollHeight.constant = DetailsCollectionView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getOrderDetails()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if desTxt.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            desTxt.text = ""
            desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    
    @IBAction func BackAcrion(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        if OrderTitleTf.text?.isEmpty != true , PriceTf.text?.isEmpty != true , desTxt.text?.isEmpty != true , directionTf.text?.isEmpty != true ,RegionTf.text?.isEmpty != true  {
            
            var skip_status = true
            var x = 0
            for item in FeatureArray {
                if item.feature_options == "required" {
                    let indexPath = IndexPath.init(row: x, section: 0)
                       let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
                    
                    if cell.DetailTf.text == "" {
                        
                        skip_status = false
                        
                        ErrorLineAnimiteNoimage(text: cell.DetailTf, lineView: cell.LineView, ishidden: false)
                    }
                }
                
                x = x + 1
            }
            
            if skip_status {
                updateDetail()
            }
           
            
            
        } else {
            
            if OrderTitleTf.text?.isEmpty == true {
                ErrorLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: false)
            }
            if PriceTf.text?.isEmpty == true {
                ErrorLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: false)
            }
            if desTxt.text?.isEmpty == true {
                ErrorLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: false)
            }
            if directionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: false)
            }
            if RegionTf.text?.isEmpty == true {
                ErrorLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
            }
            
            if CityTf.text?.isEmpty == true {
                ErrorLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
            }
            
            if BlockTf.text?.isEmpty == true {
                ErrorLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: false)
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
            
        } else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: RegionLineView, ishidden: false)
            
            
            
            
        } else if textField == CityTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: RegionLineView, ishidden: false)
            
            
            if CitArray.count > 0 {
                CityTf.text = CitArray[0].city_name
            }
            
        } else if textField == BlockTf {
            
            EnableLineAnimite(text: BlockTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-2"), lineView: RegionLineView, ishidden: false)
            
            
            if BlocksArray.count > 0 {
                BlockTf.text = BlocksArray[0].block_name
            }
            
        }
        return true;
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == OrderTitleTf {
            
            EnableLineAnimiteNoimage(text: OrderTitleTf, lineView: OrderTitleLineView, ishidden: true)
            
        } else if textField == PriceTf {
            
            EnableLineAnimite(text: PriceTf, ImageView: PriceImage, imageEnable: #imageLiteral(resourceName: "money"), lineView: PriceLineView, ishidden: true)
            
        } else if textField == directionTf {
            
            EnableLineAnimite(text: directionTf, ImageView: directionImage, imageEnable: #imageLiteral(resourceName: "direction"), lineView: directionLineView, ishidden: true)
            
//            if DirectionArray.count > 0 {
//                directionTf.text = DirectionArray[Int(Direction_id) ?? 0].side_name
//            }
            
        }  else if textField == RegionTf {
            
            EnableLineAnimite(text: RegionTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: true)
            
            if RegionArray.count > 0 , Region_id == "" {
                RegionTf.text = RegionArray[0].region_name
                Region_id = "\(RegionArray[0].region_id ?? 0)"
            }
            getCities()
            
            
        } else if textField == CityTf {
            
            EnableLineAnimite(text: CityTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: true)
            if CitArray.count > 0 , City_id == "" {
                CityTf.text = CitArray[0].city_name
                City_id = "\(CitArray[0].city_id ?? 0)"
            }
            getBlocks()
            
        } else if textField == BlockTf {
            
            EnableLineAnimite(text: BlockTf, ImageView: RegionImage, imageEnable: #imageLiteral(resourceName: "distance-1"), lineView: RegionLineView, ishidden: true)
            
            if BlocksArray.count > 0 , Block_id == "" {
                BlockTf.text = BlocksArray[0].block_name
                Block_id = "\(BlocksArray[0].block_id ?? "")"
            }
        }
        
        return true;
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: true)
        }
        return true;
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView ==  desTxt{
            
            EnableLineAnimiteTextView(text: desTxt, lineView: desLineView, ishidden: true)
        }
        
        return true;
    }
    
    
    @IBAction func DistrictNameAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PickerSearchVC") as! PickerSearchVC
        vc.Delegate = self
        vc.Search_type = .Region
        vc.RegionArray = self.RegionArray
        vc.Search_region_Array = self.RegionArray
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    @IBAction func CityNameAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PickerSearchVC") as! PickerSearchVC
        vc.Delegate = self
        vc.Search_type = .City
        vc.CitArray = self.CitArray
        vc.Search_rcity_Array = self.CitArray
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func NeighbourAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Authontication, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PickerSearchVC") as! PickerSearchVC
        vc.BlocksArray = self.BlocksArray
        vc.Delegate = self
        vc.Search_type = .Neighbour
        vc.Search_Block_Array = self.BlocksArray
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}

extension EditOrderDetailsVD  : Choose_search_key {
    func Choose_Search_key(id: String, name: String, searchtype: search_type) {
        switch searchtype {
        case .Region:
            Region_id = id
            self.RegionTf.text = name
        getCities()
        case .City:
            City_id = id
            self.CityTf.text = name
            getBlocks()
        case .Neighbour:
            Block_id = id
            self.BlockTf.text = name
        }
    }
    
  
    
    
}

extension EditOrderDetailsVD : UIPickerViewDelegate, UIPickerViewDataSource  {
    
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
            
        }else if pickerView == CityPicker {
            
            return CitArray.count
            
        }else if pickerView == BlocksPicker {
            
            return BlocksArray.count
            
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                print(row)
                Direction_id = "\(DirectionArray[row].side_id ?? 0)"
                return DirectionArray[row].side_name
            }
            
        }else if pickerView == RegionPicker{
            
            if RegionArray.count != 0 {
                
                print(row)
                Region_id = "\(RegionArray[row].region_id ?? 0)"
                return RegionArray[row].region_name
                
            }
        }else if pickerView == CityPicker{
            
            if CitArray.count != 0 {
                
                print(row)
                City_id = "\(CitArray[row].city_id ?? 0)"
                return CitArray[row].city_name
                
            }
        }else if pickerView == BlocksPicker{
            
            if BlocksArray.count != 0 {
                
                print(row)
                Block_id = "\(BlocksArray[row].block_id ?? "")"
                return BlocksArray[row].block_name
                
            }
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == DirectionPicker{
            
            if DirectionArray.count != 0 {
                directionTf.text = DirectionArray[row].side_name
                  Direction_id = "\(DirectionArray[row].side_id ?? 0)"
            }
        }else if pickerView == RegionPicker {
            
            if RegionArray.count != 0 {
                RegionTf.text = RegionArray[row].region_name
                Region_id = "\(RegionArray[row].region_id ?? 0)"
              
            }
        }else if pickerView == CityPicker {
            
            if CitArray.count != 0 {
                CityTf.text = CitArray[row].city_name
                City_id = "\(CitArray[row].city_id ?? 0)"
                
            }
        }else if pickerView == BlocksPicker {
            
            if BlocksArray.count != 0 {
                BlockTf.text = BlocksArray[row].block_name
                Block_id = "\(BlocksArray[row].block_id ?? "")"
                
            }
        }
    }
}

//MARK:- CollectionView Contoller

extension EditOrderDetailsVD: UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDetailsCell", for: indexPath) as! AddDetailsCell
        
        setShadow(view: cell , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        if FeatureData {
            
            let model = FeatureArray[indexPath.row]
            
            var x = 0
            for item in CurrentFeatureArray {
                if FeatureArray[indexPath.row].feature_id == item.specification_section_feature?.feature_id {
                    
                    cell.DetailTf.text = CurrentFeatureArray[x].specification_answer ?? ""
                    
                    if FeatureArray[indexPath.row].feature_type == "choose" {
                        
                        
                        print("dssd")
                        
                        for item1 in FeatureArray[indexPath.row].feature_data ?? [] {
                                                        
                            if item1.data_title == item.specification_answer {
                                self.SelectedFeature[indexPath.row] = item1
                            }
                            
                        }
                        
                     
                    }
                }
                x = x + 1
            }
            if cell.DetailTf.text == "" {
                cell.DetailTf.placeholder = model.feature_name ?? ""
            }
           
            
            if model.feature_type == "choose" {
                cell.ChoseDetailsBtn.isHidden = false
                cell.arrow_doun.isHidden = false
            }else{
                cell.ChoseDetailsBtn.isHidden = true
                cell.arrow_doun.isHidden = true
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
        
        for item in SelectedFeature {
            if item.key == indexPath.row {
                cell.DetailTf.text = item.value.data_title
            }
        }
        
        return cell
    }
    
}

extension EditOrderDetailsVD : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        return CGSize.init(width: width , height:56)
        
    }
}

//MARK:- Protocol Controller

extension EditOrderDetailsVD : ChoseFromFeature {
    func choseFeature(data: Feature_data, index: Int) {
        SelectedFeature[index] = data
        print(SelectedFeature)
        let indexPath = IndexPath.init(row: index, section: 0)
           let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
        cell.DetailTf.text = data.data_title
    }
}

//MARK:-API
extension EditOrderDetailsVD {
    
    func updateDetail() {
        
        self.view.lock()
        self.MainView.isHidden = true
        var Parameters = [
        
            "order_id" : "\(DetialsData?.order_id ?? 0)",
            "title" : OrderTitleTf.text ?? "",
            "description" : desTxt.text ?? "",
            "location" : "",
            "lat" : "\(lat)",
            "lng" : "\(lng)",
            "price" : PriceTf.text ?? "",
            "side_id" : Direction_id,
            "region_id" : Region_id,
            "city_id" : City_id ,
            "district_id" : Block_id
            
        
                ] as [String : Any]
        
        var features = self.SelectedFeature.values
        var selected_ides = [Int]()
        
        
        
        var x = 0
        
        
        for item in SelectedFeature {
            
            Parameters["features[\(x)]['feature_id']"] = "\(self.FeatureArray[item.key].feature_id ?? 0)"
            Parameters["features[\(x)]['answer']"] = "\(item.value.data_id ?? 0)"
            
            
            print(self.FeatureArray[item.key].feature_id ?? 0 , item.value.data_id ?? 0)
            x = x + 1
        }
        
        var y = 0
        for item in FeatureArray {
            
            let indexPath = IndexPath.init(row: y, section: 0)
            let cell = DetailsCollectionView.cellForItem(at: indexPath) as! AddDetailsCell
            
            
            if FeatureArray[y].feature_type == "text" {
                
                if cell.DetailTf.text == "" {
//                    Parameters["features[\(x)]['feature_id']"] = ""
//                    Parameters["features[\(x)]['answer']"] = ""
                }else{
                    Parameters["features[\(x)]['feature_id']"] = "\( FeatureArray[y].feature_id ?? 0)"
                    Parameters["features[\(x)]['answer']"] = cell.DetailTf.text ?? ""
                    
                    x = x + 1
                }
            }
            y = y + 1
            
        }
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Parameters as [String : AnyObject], url: "\(hostName)user-update-order/update-details", imagesArray: nil, profileImage: nil, commercial_register_image: nil, office_license_image: nil, id_image: nil, VediosArray: nil, VediosDuration: nil) { (data : OrderSuccessEditModel?, String) in
            
            self.MainView.isHidden = false
            self.view.unlock()
            
            if String != nil {
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.navigationController?.popViewController(animated: true)
                
                self.navigationController?.view.makeToast("\(data.data?.message ?? "")")
                
                
                print(data)
                
                
            }
        }
    }
    
    
    
    func getOrderDetails() {
        
        self.view.lock()
        self.MainView.isHidden = true
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)user-update-order/edit-details?order_id=\(Order_id)") { (data : OrderEditDetailsModel?, String) in
            self.MainView.isHidden = false
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.DetialsData = data.data
                
                self.RegionTf.text = data.data?.order_region?.region_name ?? ""
                self.Region_id = "\(data.data?.order_region?.region_id ?? 0)"
                self.CityTf.text = data.data?.order_city?.city_name
                self.City_id = "\(data.data?.order_city?.city_id ?? 0)"
                self.Block_id = "\(data.data?.order_block?.block_id ?? "")"
                self.BlockTf.text = data.data?.order_block?.block_name
                
                self.OrderTitleTf.text = data.data?.order_title ?? ""
                self.desTxt.text = data.data?.order_description ?? ""
                self.PriceTf.text = data.data?.order_price ?? ""
                self.Region_id = "\(data.data?.order_block?.block_id ?? "")"
                self.Direction_id = "\(data.data?.order_side?.side_id ?? 0)"

                
                if self.desTxt.text?.isEmpty == true {
                    
                    if L102Language.currentAppleLanguage() == "en" {
                        self.desTxt.text = "Description of the Advertising"
                        
                    }else {
                        
                        self.desTxt.text = "وصف الاعلان"
                    }
                    
                    self.desTxt.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
                }
                
                
                
                
                print(data)
                
            }
        }
    }
    
    
    func getRegion() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)regions") { (data : REgionModel?, String) in
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.RegionArray = data.data ?? []
                
                self.initPickers(picker: self.RegionPicker)
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
    
    func getCities() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)cities?region_id=\(Region_id)") { (data : CitiesModel?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CitArray = data.data ?? []
                
                self.initPickers(picker: self.CityPicker)
                
                print(data)
                
                
            }
        }
    }
    
    func getBlocks() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil, url: "\(hostName)blocks?city_id=\(City_id)") { (data : BlocksModel?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.BlocksArray = data.data ?? []
                
                self.initPickers(picker: self.BlocksPicker)
                print(data)
                
                
            }
        }
    }
    
    
    func getFeature() {
        
        let Parameters = [
            "order_id": Order_id,
        ] as [String : Any]
          
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
