import UIKit
import MapstedCore
import MapstedMap

class RNMapstedPropListViewController: UITableViewController {
    var spinnerView1: UIActivityIndicatorView?
    
    struct Identifier {
        static let SEGUE = "ID_VIEW_PROPERTY"
        static let TABLE_VIEW_CELL = "CELL_PROPERTY"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RNMapstedViewController,
           segue.identifier == Identifier.SEGUE,
           let property = sender as? PropertyInfo {
            destination.selectedProperty = property
        }
    }
    
    var propertyInfos = [PropertyInfo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Properties"
        spinnerView1 = UIActivityIndicatorView(frame: self.view.bounds)
        spinnerView1?.hidesWhenStopped = true
        self.view.addSubview(spinnerView1!)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.TABLE_VIEW_CELL)
        
        if CoreApi.hasInit() {
            self.handleSuccess()
        }
        else {
            spinnerView1?.startAnimating()
            MapstedMapApi.shared.setUp(prefetchProperties: false, callback: self)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissClicked))
    }
    @objc func dismissClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinnerView1?.frame = self.view.bounds
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return propertyInfos.count
    }
    
    func getItemAt(indexPath: IndexPath) -> PropertyInfo? {
        guard indexPath.row < propertyInfos.count else { return nil }
        return propertyInfos[indexPath.row]
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: Identifier.TABLE_VIEW_CELL, for: indexPath)
        guard let thisProperty = getItemAt(indexPath: indexPath) else {
            return cell
        }
        
        
        cell.textLabel?.text = thisProperty.displayName
        print("\(thisProperty.displayName) - \(thisProperty.propertyId)")
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let thisProperty = getItemAt(indexPath: indexPath) else { return }
        performSegue(withIdentifier: Identifier.SEGUE, sender: thisProperty)
    }
}

extension RNMapstedPropListViewController : CoreInitCallback {
    func onFailure(errorCode: EnumSdkError) {
        
    }
    
    func onStatusUpdate(update: EnumSdkUpdate) {
        
    }
    
    fileprivate func handleSuccess() {
        self.propertyInfos = CoreApi.PropertyManager.getAll().sorted(by: { p1, p2 in
            return p1.displayName < p2.displayName
        })
        DispatchQueue.main.async {
//            self.title = "Properties Found: \(self.propertyInfos.count) "
            self.tableView.reloadData()
        }
        
    }
    
    func onSuccess() {
        DispatchQueue.main.async {
            self.spinnerView1?.stopAnimating()
        }
        handleSuccess()
    }
    
    func onFailure(errorCode: Int, errorMessage: String) {
        print("Failed with \(errorCode) - \(errorMessage)")
    }
    
    func onStatusMessage(messageType: StatusMessageType) {
        
    }
}
