//
//  DiaryDetailVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//
/**
 // Hero Library Code
 //        // UIView
 //        testView.hero.id = "testView"
 //        testView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTestView)))
 
 //    @objc private func tapTestView() {
 //        let vc = UIStoryboard(name: "DiaryViews", bundle: nil).instantiateViewController(withIdentifier: "DetailImageVC") as! DetailImageVC
 //        vc.modalTransitionStyle = .crossDissolve
 //        vc.modalPresentationStyle = .overFullScreen
 //        vc.hero.isEnabled = true
 //        self.present(vc, animated: true)
 //    }
 
 //     self.hero.isEnabled = true
 //     photoCollectionView.hero.modifiers = [.cascade]
 **/

import UIKit
import BSImagePicker
import Photos
import Hero

protocol DelegateDiaryDetailVC: AnyObject {
    func passDiaryData(date: String, title: String, contents: String, photoList: [UIImage])
    
//    func passModifiedDiaryDate(date: String, title: String, contents: String, photoList: [UIImage])
}

class DiaryDetailVC: UIViewController {
    // Constant
    let NUM_PHOTO_MAX = 5
    let TEXTFIELD_BODER_WIDTH: CGFloat = 1.0
    let TEXTFIELD_BORDER_RADIUS: CGFloat = 7
    let BUTTON_BORDER_RADIUS: CGFloat = 7
    let BUTTON_FONT_SIZE: CGFloat = 20
    let CONTENTS_PLACE_HOLDER = "내용을 입력하세요."
    
    // UICollectionView
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    // UILabel
    @IBOutlet weak var diaryDateLabel: UILabel!
    
    // UIButton
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    // UITextField
    @IBOutlet weak var titleTextField: UITextField!
    
    // UITextView
    @IBOutlet weak var contentsTextView: UITextView!
    
    // UIView
    @IBOutlet weak var pointView: UIView!
    
    // Variable
    var photoList = Array<UIImage>()
    var diaryEditorMode: DiaryEditorMode?
    var diaryDateStr: String!
    var diaryDelegate: DelegateDiaryDetailVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        // UICollectionView
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: "AddPhotoCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCell")
        photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        
        // UIView
        configurePointView()
        
        // UITextView()
        configureContentsTextView()
        
        // UILabel
        configureDiaryDateLabel()
        
        // UITextField
        configureTitleTextField()
        
        // UIButton
        configureDiaryDeleteButton()
        configureFinishButton()
        validateInputField()
    }
    
    private func configurePointView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.pointView.bounds
        let colors: [CGColor] = [
            ColorManager.shared.getThemeMain().cgColor,
            ColorManager.shared.getPointViewColor().cgColor]
        
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.cornerRadius = self.pointView.frame.width / 2
        
        pointView.layer.addSublayer(gradientLayer)
        pointView.layer.cornerRadius = pointView.frame.width / 2
    }
    
    private func configureContentsTextView() {
        contentsTextView.layer.borderWidth = TEXTFIELD_BODER_WIDTH
        contentsTextView.layer.borderColor = ColorManager.shared.getContentsTextFieldColor().cgColor
        contentsTextView.layer.cornerRadius = TEXTFIELD_BORDER_RADIUS
        contentsTextView.textContainerInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        contentsTextView.font = FontManager.shared.getNanumSquareR(fontSize: 15)
        
        if diaryEditorMode == .new {
            self.contentsTextView.text = "내용을 입력하세요."
            self.contentsTextView.textColor = ColorManager.shared.getContentsTextFieldColor()
        }
        contentsTextView.delegate = self
    }
    
    private func configureDiaryDateLabel() {
        diaryDateLabel.text = diaryDateStr
    }
    
    private func configureTitleTextField() {
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: titleTextField.frame.height))
        
        titleTextField.layer.borderWidth = TEXTFIELD_BODER_WIDTH
        titleTextField.layer.borderColor = ColorManager.shared.getContentsTextFieldColor().cgColor
        titleTextField.layer.cornerRadius = TEXTFIELD_BORDER_RADIUS
        titleTextField.leftView = leftPadding
        titleTextField.leftViewMode = UITextField.ViewMode.always
        titleTextField.font = FontManager.shared.getNanumSquareR(fontSize: 15)
        
        titleTextField.addTarget(self, action: #selector(DidTitleTextFiledChange(_:)), for: .editingChanged)
    }
    
    @objc private func DidTitleTextFiledChange(_ textField: UITextField) {
        validateInputField()
    }
    
    private func configureDiaryDeleteButton() {
        if diaryEditorMode == .new {
            deleteButton.layer.isHidden = true
        }else if diaryEditorMode == .edit {
            deleteButton.layer.isHidden = false
        }
    }
    
    private func configureFinishButton(){
        finishButton.setTitle("완료", for: .normal)
        finishButton.backgroundColor = ColorManager.shared.getThemeMain()
        finishButton.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: BUTTON_FONT_SIZE)
        finishButton.titleLabel?.textColor = ColorManager.shared.getWhite()
        finishButton.layer.cornerRadius = BUTTON_BORDER_RADIUS
        constrainFinishButton()
    }
    
    private func constrainFinishButton() {
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.widthAnchor.constraint(equalToConstant: 348).isActive = true
        finishButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func validateInputField() {
        finishButton.isEnabled = !(titleTextField.text?.isEmpty ?? true) && !(contentsTextView.text.isEmpty) && (contentsTextView.text != CONTENTS_PLACE_HOLDER)
        
        if finishButton.isEnabled {
            finishButton.backgroundColor = ColorManager.shared.getThemeMain()
            finishButton.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: BUTTON_FONT_SIZE)
        }else {
            finishButton.backgroundColor = ColorManager.shared.getDisableColor()
            finishButton.titleLabel?.font = FontManager.shared.getNanumSquareB(fontSize: BUTTON_FONT_SIZE)
        }
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapFinishButton(_ sender: UIButton) {
        if diaryEditorMode == .new {
            guard let date = diaryDateLabel.text else { return }
            guard let title = titleTextField.text else { return }
            guard let contents = contentsTextView.text else { return }
            
            diaryDelegate?.passDiaryData(date: date, title: title, contents: contents, photoList: photoList)
        } else if diaryEditorMode == .edit {
            guard let date = diaryDateLabel.text else { return }
            guard let title = titleTextField.text else { return }
            guard let contents = contentsTextView.text else { return }
            
        }
        dismiss(animated: true)
    }
    
    // 유저가 화면을 터치하면 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// UICollectionView
extension DiaryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return photoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath) as! AddPhotoCell
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoImageView.image = photoList[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(tapDeleteButton(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func tapDeleteButton(button: UIButton) {
        let index = button.tag
        photoList.remove(at: index)
        photoCollectionView.reloadData()
    }
    
    @objc private func tapPhotoImageView(view: UIView) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if photoList.count == NUM_PHOTO_MAX {
                // TODO: Show alert
                let alert = UIAlertController(title: nil, message: "사진은 최대 5장까지 등록할 수 있습니다.", preferredStyle: .alert)
                let confirmButton = UIAlertAction(title: "확인", style: .default)
                alert.addAction(confirmButton)
                present(alert, animated: true, completion: nil)
                return
            }
            
            let imagePicker = ImagePickerController()
            imagePicker.overrideUserInterfaceStyle = .light
            imagePicker.settings.selection.max = self.NUM_PHOTO_MAX-self.photoList.count
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
            imagePicker.settings.theme.selectionStyle = .numbered
            imagePicker.settings.theme.selectionFillColor = ColorManager.shared.getThemeMain()
            imagePicker.settings.theme.selectionStrokeColor = .white
            imagePicker.doneButton.tintColor = ColorManager.shared.getThemeMain()
            imagePicker.cancelButton.tintColor = .red

            presentImagePicker(imagePicker, select: { (asset) in
                   }, deselect: { (asset) in
                   }, cancel: { (assets) in
                   }, finish: { (assets) in
                       for asset in assets {
                           let image = self.getAssetThumbnail(asset: asset)
                    self.photoList.append(image)
                }
                self.photoCollectionView.reloadData()
            })
        } else { // 사진 목록 section
            let DetailImageVC = UIStoryboard(name: "DiaryViews", bundle: nil).instantiateViewController(withIdentifier: "DetailImageVC") as! DetailImageVC
            
            DetailImageVC.detailImage = photoList[indexPath.row]
            DetailImageVC.modalTransitionStyle = .crossDissolve
            DetailImageVC.modalPresentationStyle = .overFullScreen
            DetailImageVC.hero.isEnabled = true
            self.present(DetailImageVC, animated: true)
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        option.isNetworkAccessAllowed = true
        option.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
}

// UITextView
extension DiaryDetailVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == CONTENTS_PLACE_HOLDER {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = CONTENTS_PLACE_HOLDER
            textView.textColor = ColorManager.shared.getContentsTextFieldColor()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        validateInputField()
    }
}
