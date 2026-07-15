import Foundation
import UIKit
import MapstedCore
import MapstedMap
import MapstedMapUi
import LocationMarketing

@objc public class RNMapstedViewController: UIViewController {
    private var containerVC: ContainerViewController?
    private var mapsVC: MapstedMapUiViewController?
    var selectedProperty: PropertyInfo? = nil
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    @objc public func echoSwift(_ value: String) -> String {
        print(value)
        return value
    }
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containerVC = segue.destination as? ContainerViewController, segue.identifier == "containerSegue" {
            self.containerVC = containerVC
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uSelectedProperty = selectedProperty  {
            self.navigationItem.title = uSelectedProperty.displayName
        }
        
        spinnerView.startAnimating()
        if CoreApi.hasInit() {
            addMapView()
        }
        else {
            MapstedMapApi.shared.setUp(prefetchProperties: false, callback: self)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let selectedProperty = selectedProperty else {
            return
        }
        MapstedMapApi.shared.removeProperty(propertyId: selectedProperty.propertyId)
    }
    
    func addMapView() {
        if mapsVC == nil {
            if let mapsVC = MapstedMapUiViewController.shared as? MapstedMapUiViewController {
                mapsVC.setAlertDelegate(alertDelegate: self)
                self.mapsVC = mapsVC
                containerVC?.addController(controller: mapsVC, yOffset: 0, isNew: false)
            }
        }
        self.handleSuccess()
    }
    
    func displayProperty(propertyInfo: PropertyInfo, completion: (() -> ())? = nil) {
        // Implementation omitted for brevity
        self.mapsVC?.showLoadingSpinner(text: "Loading...")
        self.spinnerView.stopAnimating()
        
        let propertyId = propertyInfo.getPropertyId()
        mapsVC?.selectAndDrawProperty(propertyId: propertyId, callback: {[weak self] status in
            DispatchQueue.main.async {
                self?.mapsVC?.hideLoadingSpinner()
                if status {
                    self?.mapsVC?.displayPropertyOnMap {
                        completion?()
                    }
                }
                else {
                    print("Problem with status on select and draw", status)
                }
            }
        })
    }
    
    fileprivate func handleSuccess() {
        if let selectedProperty = self.selectedProperty {
            self.displayProperty(propertyInfo: selectedProperty) {
                
            }
        }
        else {
            let propertyInfos = CoreApi.PropertyManager.getAll()
            if propertyInfos.count > 0 {
                let firstProperty = propertyInfos[0]
                self.displayProperty(propertyInfo: firstProperty) {
                    
                }
            }
            else {
                print("Mapsted - No properties found")
            }
        }
    }
}

//MARK: - Core Init Callback methods
extension RNMapstedViewController : CoreInitCallback {
    public func onSuccess() {
        DispatchQueue.main.async {
            self.addMapView()
        }
    }
    
    public func onFailure(errorCode: EnumSdkError) {
        print("Mapsted - onFailure: \(errorCode)")
    }
    
    public func onStatusUpdate(update: EnumSdkUpdate) {
    }
    
    public func onStatusMessage(messageType: StatusMessageType) {
    }
}

//MARK: - Routing Request Callback methods
extension RNMapstedViewController: RoutingRequestCallback {
    public func onSuccess(routeResponse: MNRouteResponse) {
        MapstedMapApi.shared.handleRouteResponse(routeResponse: routeResponse)
    }
    
    public func onError(errorCode: Int, errorMessage: String, alertIds: [String]) {
        MapstedMapApi.shared.handleRouteError(errorCode: errorCode, errorMessage: errorMessage, alertIds: alertIds)
    }
}

extension RNMapstedViewController: GeofenceEventListener {
    public func onGeofenceEvent(propertyId: Int, triggerId: String) {
        // Implementation omitted for brevity
    }
}

//MARK: - MN Alert Delegate methods
extension RNMapstedViewController : MNAlertDelegate {
    public func showAlerts() {
    }
    
    public func loadingAlerts() -> Bool {
        return false
    }
}

