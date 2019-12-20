//
//  AboutTableViewController.swift
//  RD Application
//
//  Created by Георгий Кашин on 06/06/2019.
//  Copyright © 2019 Georgii Kashin. All rights reserved.
//

import UIKit
import MapKit

class AboutTableViewController: UITableViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var mapView: MKMapView!
}

// MARK: - UITableViewController Methods
extension AboutTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.layer.cornerRadius = 5
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
        /// setup placemark on the map
        setupPlacemark()
    }
}

// MARK: - UITableViewDelegate
extension AboutTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            /// create url name
            let urlName = UrlList.allCases[indexPath.row].rawValue
            /// open url
            openUrl(withName: urlName)
        case 1:
            /// create phone number
            guard let phoneNumber = PhoneNumbersList.allCases[safe: indexPath.row]?.rawValue else { return }
            /// call number with phone number
            openUrl(withName: phoneNumber)
        default:
            break
        }
    }
}

// MARK: - URL
extension AboutTableViewController {
    /// Open url with url name
    ///
    /// - Parameter urlName: url name or phone number
    func openUrl(withName urlName: String) {
        if let url = URL(string: urlName) {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - MapView
extension AboutTableViewController {
    /// setup placemark
    func setupPlacemark() {
        let location = MapViewDataConstants.location
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { [unowned self] (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            let annotation = MKPointAnnotation()
            annotation.title = MapViewDataConstants.annotationTitle
            annotation.subtitle = MapViewDataConstants.annotationSubtitle
            
            guard let placemarkLocation = placemark.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: false)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

// MARK: - MapViewDelegate
extension AboutTableViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapViewDataConstants.annotationIdentifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MapViewDataConstants.annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        /// annotation image view
        let imageView = configureImageView()
        annotationView?.rightCalloutAccessoryView = imageView
        return annotationView
    }
}

// MARK: - MapView UI
extension AboutTableViewController {
    /// Configure image view
    ///
    /// - Returns: thumbnail image view
    func configureImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: MapViewDataConstants.imageViewSize.width, height: MapViewDataConstants.imageViewSize.height))
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: MapViewDataConstants.imageName)
        return imageView
    }
}

