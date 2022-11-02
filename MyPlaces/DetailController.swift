//
//  DetailController.swift
//  MyPlaces
//
//  Created by PC-793 on 6/10/22.
//

import UIKit

class DetailController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate & UITextFieldDelegate {
    
    let manager = ManagerPlaces.shared()
        
    @IBOutlet var scrollview:UIScrollView!;
    @IBOutlet var update:UIButton!
    @IBOutlet var delete:UIButton!
    @IBOutlet var cancel:UIButton!
    @IBOutlet var selectImage:UIButton!
    
    @IBOutlet weak var viewPicker: UIPickerView!
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    
    var keyboardHeight:CGFloat!
    var activeField: UIView!
    var lastOffset:CGPoint!
    
    
    let pickerElems1 = ["Generic place", "Touristic place"]
    
    var place:Place? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // scrollview.contentSize = CGSize(width: 0.0, height: 1000);
        
        if(manager.placeSelected != -1){
            place = manager.getPlaceSelected()
            self.update.titleLabel?.text = "Update"
            textName.text = place?.name
            textDescription.text = place?.description
        }else{
            //place = Place(type:Place.PlacesTypes.GenericPlace, name: "", description: "", image_in: nil )
            self.update.titleLabel?.text = "New"
        }
        
        
        viewPicker.delegate = self
        viewPicker.dataSource = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:#selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector:#selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        textName.delegate = self
        textDescription.delegate = self
        
        update.addTarget(self, action: #selector(updatePlace), for: .touchUpInside)
        delete.addTarget(self, action: #selector(deletePlace), for: .touchUpInside)
        cancel.addTarget(self, action: #selector(cancelDetail), for: .touchUpInside)
        selectImage.addTarget(self, action: #selector(selectImageFunc), for: .touchUpInside)

        
    }
    
    
    @objc func deletePlace(){
        manager.remove(manager.getPlaceSelected())
        manager.UpdateObservers()
        self.navigationController?.popViewController(animated: true)
    }
    @objc func updatePlace(){
        /*var data:Data? = nil
        data = imagePicked.image!.jpegData(compressionQuality: 1.0)*/
        if(manager.placeSelected == -1){
            var pl = Place(name: textName.text!, description: textDescription.text!, image_in: nil /*data*/)
            //pl?.location = ManagerLocation.GetLocation()
            manager.append(value: pl)
        }else{
            manager.getPlaceSelected().name = textName.text!
            manager.getPlaceSelected().description = textDescription.text!
        }
        manager.UpdateObservers()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelDetail(){        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func selectImageFunc(){
        
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerElems1.count
    }
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerElems1[row]
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        view.endEditing(true)
        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        imagePicked.contentMode = .scaleAspectFit
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
    @objc func showKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
    }
    
    // Hide soft keyboard
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func hideKeyboard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
    }

    
    @objc func textViewShouldBeginEditing(_ textView: UITextView)
    {
        activeField = textView
        lastOffset = self.scrollview.contentOffset
    }
    @objc func textViewShouldEndEditing(_ textView: UITextView) {
        if(activeField==textView) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
    }
    @objc func textFieldShouldBeginEditing(_ textField: UITextView) -> Bool{
        activeField = textField
        lastOffset = self.scrollview.contentOffset
        return true
    }
    @objc func textFieldShouldEndEditing(_ textField: UITextView) {
        if(activeField==textField) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
    }

}
