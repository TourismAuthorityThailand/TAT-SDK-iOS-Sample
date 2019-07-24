//
//  RouteMapViewController.swift
//  TATSDKSample

import UIKit
import MapKit
import TATSDK

class RouteMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var stops : [TATStop] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Default map
        let span = MKCoordinateSpan.init(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 13.736717, longitude: 100.523186), span: span)
        mapView.setRegion(region, animated: true)
        createRoute()
    }
    
    func createRoute() {
        var locations : [CLLocationCoordinate2D] = []
        for info in stops {
            decodeCompressedPath(stop: info)
            guard let geolocation = info.geolocation else { continue }
            locations.append(CLLocationCoordinate2D.init(latitude: geolocation.latitude,
                                                         longitude: geolocation.longitude))
        }
        createMarker(locations: locations)
    }
    
    private func decodeCompressedPath(stop: TATStop)  {
        var routeStopList = [CLLocationCoordinate2D]()
        // decode compressed path
        let decodeRoutes = TATPathCompressor().decode(compressedValue: stop.compressedPath)
        guard let routes = decodeRoutes else { return }
        for route in routes {
            routeStopList.append(CLLocationCoordinate2D.init(latitude: route.latitude,
                                                             longitude: route.longitude))
        }
        
        // create route
        let routePolyLine = MKPolyline.init(coordinates: routeStopList, count: routeStopList.count)
        let type = stop.travelBy
        routePolyLine.subtitle = type
        mapView.addOverlay(routePolyLine)
    }
    
    private func createMarker(locations: [CLLocationCoordinate2D]) {
        var list : [MKAnnotation] = []
        for (index,info) in stops.enumerated() {
            let objectAnnotation = MKPointAnnotation()
            objectAnnotation.subtitle = "\(index + 1). \(info.name)"
            guard let geolocation = info.geolocation else { continue }
            objectAnnotation.coordinate = CLLocationCoordinate2D.init(latitude: geolocation.latitude,
                                                                      longitude: geolocation.longitude)
            list.append(objectAnnotation)
        }
        mapView.addAnnotations(list)
        
        //Display MKMapViewAnnotations within a map view's visible area
        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        let currentMapRect = self.mapView.visibleMapRect
        let padding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        self.mapView.setVisibleMapRect(currentMapRect, edgePadding: padding, animated: true)
    }
    
    private func getTravelModeColor(key: String) -> UIColor {
        switch key {
        // c is car
        case "C":
            return UIColor.red
        // w is walk
        case "W":
            return UIColor.green
        // p is public transport
        case "P":
            return UIColor.blue
        default:
            return UIColor.purple
        }
    }
}

extension RouteMapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRender = MKPolylineRenderer.init(overlay: overlay)
            polylineRender.strokeColor = getTravelModeColor(key: overlay.subtitle!!)
            polylineRender.lineWidth = 3
            return polylineRender
        } else if overlay is MKPlacemark {
            let marker = MKOverlayRenderer.init(overlay: overlay)
            return marker
        } else {
            return MKOverlayRenderer.init()
        }
    }
    
}
