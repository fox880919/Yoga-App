//
//  SessionMapViewController.swift
//  Yoga Manager
//
//  Created by Faiez Altamimi on 4/8/18.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import GooglePlaces
class SessionMapViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    let marker = GMSMarker()
    
    var session : Session!
    
    var currentLocation: Location?
    
    var locationBeforePickerView : Location!

    var newInputView : UIView!
    
    var newLocation : Location?
    
    var allLocations: [Location]!

    @IBOutlet weak var SessionMapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var locationNameTxtField: UITextField!
    
    private let locationManager = CLLocationManager()
    
    var placesClient: GMSPlacesClient!
    //var zoomLevel: Float = 15.0
    
    var isFirstLocation = true

    var locationModelView = LocationModelView()
    
    var savedLocationBtnPicker = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allLocations = locationModelView.getAllLocations()
        
        newInputView = UIView(frame: CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 216))

        if let session = session {
            
            if let location = session.location {

                locationNameTxtField.text = location.name
                
                marker.position.latitude = Double(location.latitude!)!
                
                marker.position.longitude = Double(location.longitude!)!
                
            }
        }
        
        else if let location = currentLocation {
            
            locationNameTxtField.text = location.name
            
            marker.position.latitude = Double(location.latitude!)!
            
            marker.position.longitude = Double(location.longitude!)!
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()

        SessionMapView.delegate = self
    
        placesClient = GMSPlacesClient.shared()
        
    }


    @IBAction func savedLocationBtnPressed(_ sender: Any) {
        
        if(currentLocation == nil)
        {
            
            locationBeforePickerView = session.location
        }
        else{
            
            locationBeforePickerView = currentLocation
        }
        
      savedLocationBtnPicker = UIPickerView(frame:CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: 216))
        
        savedLocationBtnPicker.delegate = self
        savedLocationBtnPicker.dataSource = self

        savedLocationBtnPicker.backgroundColor = UIColor.white
        
        savedLocationBtnPicker.showsSelectionIndicator = true

        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)

        toolBar.isUserInteractionEnabled = true
        
        newInputView.addSubview(savedLocationBtnPicker)
        
        newInputView.addSubview(toolBar)
        
        self.view.addSubview(newInputView)
   
    }
    
    @objc func cancelPicker()
    {
        
        if(currentLocation == nil)
        {
            
             session.location = locationBeforePickerView
        }
        else{
            
            currentLocation = locationBeforePickerView
        }
        
        locationModelView.deleteALocation(entity: locationBeforePickerView)
    
        savedLocationBtnPicker.resignFirstResponder()
        newInputView.removeFromSuperview()
    }
    
    @objc func donePicker()
    {
        if(currentLocation == nil)
        {
            
            locationNameTxtField.text = session.location!.name
            
            if let latitude = session.location!.latitude, let longitude = session.location!.longitude {
                
                marker.position.latitude = Double(latitude)!
                
                marker.position.longitude = Double(longitude)!
                
            }
        }
        else{
            
            locationNameTxtField.text = currentLocation!.name
            
            if let latitude = currentLocation!.latitude, let longitude = currentLocation!.longitude {
                
                marker.position.latitude = Double(latitude)!
                
                marker.position.longitude = Double(longitude)!
            }
        }
        
     
        
        getLocation()
        
        savedLocationBtnPicker.resignFirstResponder()
        newInputView.removeFromSuperview()

    }

    
    @IBAction func submitBtn(_ sender: Any) {
        
        if (locationNameTxtField.text ?? "").isEmpty
        {
            let alert = UIAlertController(title: "Error", message: "Location name can't be empty", preferredStyle: UIAlertControllerStyle.alert)

            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true)

            return
        }
        
       else
        {
            if currentLocation == nil{
                
                saveSessionLocation()
            }
            else{
                
                locationModelView.updateALocation(location: currentLocation!, name: locationNameTxtField.text!, latitude: "\(marker.position.latitude)", longitude: "\(marker.position.longitude)", address: addressLabel.text!)
                
                dismiss(animated: true, completion: nil)

            }
        }
        

    }
    
    func saveSessionLocation()
    {
        
        if(session?.location != nil)
        {
            
            let alert = UIAlertController(title: "Saving Options", message: "Add as a new location", preferredStyle: UIAlertControllerStyle.alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                
                self.newLocation = self.locationModelView.addANewLocation(name: self.locationNameTxtField.text!, latitude: "\(self.marker.position.latitude)", longitude: "\(self.marker.position.longitude)", address: self.addressLabel.text!)
                
                self.session.location = self.newLocation
                
                self.dismiss(animated: true, completion: nil)
                
            })
            
            let noAction = UIAlertAction(title: "No, update this location", style: UIAlertActionStyle.cancel, handler: { action in
                
                self.locationModelView.updateALocation(location: self.session.location!, name: self.locationNameTxtField.text!, latitude: "\(self.marker.position.latitude)", longitude: "\(self.marker.position.longitude)", address: self.addressLabel.text!)
                
                self.dismiss(animated: true, completion: nil)
            })
            
            
            alert.addAction(yesAction)
            
            alert.addAction(noAction)
            
            
            self.present(alert, animated: true)
        }
        else{
            
            session.location = locationModelView.addANewLocation(name: locationNameTxtField.text!, latitude: "\(marker.position.latitude)", longitude: "\(marker.position.longitude)", address: addressLabel.text!)
            
            dismiss(animated: true, completion: nil)

        }

    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        
//        if  currentLocation != nil {
//
//            locationModelView.deleteALocation(entity: currentLocation!)
//        }
        
        dismiss(animated: true, completion: nil)

    }
    
    func getLocation()
    {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            // 3
            self.addressLabel.text = lines.joined(separator: "\n")
            
            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return allLocations.count + 1
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (row == 0)
        {
            return "None"
        }
            
        else{
            
            return allLocations[row - 1].name

        }
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(row == 0)
        {
            
        }
            
        else{
            
            session.location = allLocations[row - 1]
        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
//        let geocoder = GMSGeocoder()
        
        // 2
//        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
//            guard let address = response?.firstResult(), let lines = address.lines else {
//                return
//            }
//
//            // 3
//            self.addressLabel.text = lines.joined(separator: ", ")
//
//            // 4
//            UIView.animate(withDuration: 0.25) {
//                self.view.layoutIfNeeded()
//            }
//        }
    }
    

    
}

extension SessionMapViewController: CLLocationManagerDelegate {
    
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()

        //5
        SessionMapView.isMyLocationEnabled = true
        SessionMapView.settings.myLocationButton = true
    }

    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        if(isFirstLocation)
        {
            isFirstLocation = false
            
            SessionMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
            
            
            marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            marker.isDraggable = true
            
            marker.map = SessionMapView
            
            getLocation()
        }
        
        // 7


    }

}

extension SessionMapViewController: GMSMapViewDelegate{
    
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        
        getLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        marker.position = coordinate
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        
       // SessionMapView.camera = GMSCameraPosition(target: position.target, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
        //SessionMapView.camera = GMSCameraPosition(target: position.target, zoom: 15, bearing: 0, viewingAngle: 0)
        
        //reverseGeocodeCoordinate(position.target)
 
    }
}


   

//extension SessionMapViewController: CLLocationManagerDelegate {
//    
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location: CLLocation = locations.last!
//        print("Location: \(location)")
//        
////        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
////                                              longitude: location.coordinate.longitude,
////                                              zoom: zoomLevel)
////
////        if SessionMapView.isHidden {
////            SessionMapView.isHidden = false
////            SessionMapView.camera = camera
////        } else {
////            SessionMapView.animate(to: camera)
////        }
////
////        listLikelyPlaces()
//        
//
////        SessionMapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
////        SessionMapView.settings.myLocationButton = true
////        SessionMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
//    
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//            // Display the map using the default location.
//            SessionMapView.isHidden = false
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways: fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        }
//    }
//


    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//}



