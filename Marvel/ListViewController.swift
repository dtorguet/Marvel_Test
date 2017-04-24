//
//  ViewController.swift
//  Marvel
//
//  Created by David on 8/7/16.
//  Copyright © 2016 com.torguet. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UISearchBarDelegate,UIScrollViewDelegate,DataHandlerDelegate {
    
    var arrayModels = NSMutableArray()
    var imagesCache = NSMutableDictionary()
    var arrayFavorites = NSArray()
    var offset: Int = 0
    var textForSearch: String = ""
    var _noMoreResults :Bool = false
    let dh : DataHandler = DataHandler.sharedInstance
    let refreshControl = UIRefreshControl()
    fileprivate let heightCell = CGFloat(122)
    fileprivate let heightCellLoading = CGFloat(30)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = kTitleListVC
        self.dh.delegate = self
        self.activityView.isHidden = true
        self.arrayFavorites = self.dh.arrayFavorites()
        addRightBarButton()
        checkInternetConnection()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.arrayFavorites = self.dh.arrayFavorites()
        self.tableView.reloadData()
        addRefreshControl()
    }
    
    // MARK: - Private Methods

    func addRightBarButton() -> Void {
        let btnName = UIButton()
        btnName.setImage(UIImage(named: kFavoritesImage), for: UIControlState())
        btnName.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btnName.addTarget(self, action: Selector(kSelectorPushFavorites), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func addRefreshControl() -> Void {
        refreshControl.attributedTitle = NSAttributedString(string: kRefreshControlText)
        refreshControl.addTarget(self, action: #selector(ListViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func refresh(_ sender:AnyObject) {
        checkInternetConnection()
    }
    
    func pushToFavorites() -> Void {
        performSegue(withIdentifier: kSegueListVcToFavoritesVc, sender: nil)
    }
    
    // MARK: Reachbility
    
    func checkInternetConnection() -> Void {
        if Reachability.isConnectedToNetwork() == true {
            //self.dh.fetchCharactersFromApi(text: "sp", offset:  self.offset * 20)
            refreshControl.endRefreshing()
        } else {
            self.activityView.stopAnimating()
            refreshControl.endRefreshing()
            let alert=UIAlertController(title: kAlertNoReachableTitle, message: kAlertNoReachableText, preferredStyle: UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: kOk, style: UIAlertActionStyle.cancel, handler: nil));
            present(alert, animated: true, completion: nil);
        }
    }
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        
        return self.arrayModels.count
    }
 
    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == self.arrayModels.count - 1) {
            return heightCellLoading
        }else{
            return heightCell
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        if self.arrayModels.count != 0 {
            
            if ((indexPath.row == self.arrayModels.count - 1) && !_noMoreResults) {
                let cell : LoadingTableViewCell = (tableView.dequeueReusableCell(withIdentifier: kLoadingCellIdentifier) as? LoadingTableViewCell)!
                cell.activityView.isHidden = false
                cell.activityView.startAnimating()
                self.dh.fetchCharactersFromApi(text: self.textForSearch, offset:  self.offset * 20)
                return cell
            }
            let cell : ListViewControllerTableViewCell = (tableView.dequeueReusableCell(withIdentifier: kCellIDentifier) as? ListViewControllerTableViewCell)!
            let model : Model = self.arrayModels[indexPath.row] as! Model
            let isFavorite: Bool = self.arrayFavorites.contains(model.name)
            cell.setModel(model: model, favorite: isFavorite)
            cell.cellImageView.image = nil
            
            if let image : UIImage = self.imagesCache.object(forKey: model.id) as? UIImage{
                cell.cellImageView.image = image
            }else{
                cell.cellImageView.image = #imageLiteral(resourceName: "background")
                self.dh.imageFromUrl(model: model, cell: cell)
            }
            return cell
        } else {
            fatalError("unexpected cell dequeued from tableView")
        }
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        
                let model : Model = self.arrayModels[indexPath.row] as! Model
                performSegue(withIdentifier: kSegueListVcToDetailVc, sender: model)
                tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        self.textForSearch = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self._noMoreResults = false
        self.arrayModels .removeAllObjects()
        self.offset = 0
        self.tableView.reloadData()
        self.searchBar.resignFirstResponder()
        self.activityView.isHidden = false
        self.activityView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.dh.fetchCharactersFromApi(text: self.textForSearch, offset:  self.offset * 20)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
         self.searchBar.resignFirstResponder()
    }
    
    //MARK: - Navigation Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == kSegueListVcToDetailVc {
            let object = sender as! Model
            let vc:DetailViewController = segue.destination as! DetailViewController
            vc.model  = object
            if let image : UIImage = self.imagesCache.object(forKey: object.id) as? UIImage{
                vc.thumbnailImage = image
            }else{
               vc.thumbnailImage = nil
            }
        }
//        if segue.identifier == kSegueListVcToFavoritesVc {
//            let vc:FavoritesViewController = segue.destinationViewController as! FavoritesViewController
//        }

    }
    
    // MARK: - DataHandlerDelegate
    func arrayOfModels(array aArrayOfModels: NSArray) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if (aArrayOfModels.count > 0) {
            for object in aArrayOfModels {
                self.arrayModels.add(object)
            }
            self.offset = self.offset + 1
            self.activityView.stopAnimating()
            self.tableView.reloadData()
        }else{
            
            let alert=UIAlertController(title: kAlertNoResultsTitle, message: kAlertNoResultsText, preferredStyle: UIAlertControllerStyle.alert);
            alert.addAction(UIAlertAction(title: kOk, style: UIAlertActionStyle.cancel, handler: nil));
            present(alert, animated: true, completion: nil);
            self.activityView.stopAnimating()
            self._noMoreResults = true
            self.tableView.reloadData()
            
        }
        
    }
    
    func imageFromUrl(image aImage: UIImage, cell aCell: ListViewControllerTableViewCell, model aModel: Model) {
        aCell.cellImageView.image = aImage
        self.imagesCache.setObject(aImage, forKey: aModel.id)
    }
}





