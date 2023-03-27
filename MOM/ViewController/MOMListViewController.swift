//
//  MOMListViewController.swift
//  MOM
//
//  Created by SowmiyaRagul on 25/03/23.
//

import UIKit
import Firebase

enum Menu : String {
    case add = "Add"
    case edit = "Edit"
    case view = "View"
}

class MOMListViewController : BaseViewController {
    //MARK: Outlet
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: Local Variable
    var momList: [MOMDetail]? = [MOMDetail]()
    var viewModel = MOMViewModel()
    
    @IBAction func addAction(_ sender: UIButton) {
        navigateToMOMDetail(momDetail: nil, type: .add)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        listOfMOM()
    }
    
    // MARK: SetUpMethod
    private func setUp() {
        //MARK: Register cell
        tableView?.register(UINib(nibName: "\(MOMTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(MOMTableViewCell.self)")
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        
        //MARK: Call Delegate
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

//MARK: Navigation
extension MOMListViewController {
    private func navigateToMOMDetail(momDetail:MOMDetail?,type: Menu) {
        let detailViewController = MOMDetailViewController(nibName: Identifier.momDetailVc, bundle: nil)
        detailViewController.menu = type
        detailViewController.momDetail = momDetail
        present(detailViewController, animated: true) { [weak self] in
            self?.listOfMOM()
        }
    }
}

//MARK: TableViewDelegate
extension MOMListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: MOMTableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(MOMTableViewCell.self)") as? MOMTableViewCell {
            if let momDetail = momList?[indexPath.row] {
                cell.setMOMDetails(momDetail: momDetail)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return momList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let momDetail = momList?[indexPath.row] else { return }
        navigateToMOMDetail(momDetail: momDetail, type: .view)
    }
}

extension MOMListViewController {
    private func listOfMOM() {
        momList?.removeAll()
        viewModel.listOfMOM { [weak self] isSuccess, error,data in
            if isSuccess == true {
                if let momData = data?.value as? [String:Any] {
                    momData.values.forEach { value in
                        let dic = value as? [String:Any]
                        var momDetail = MOMDetail()
                        momDetail.date =  dic?["date"] as? String
                        momDetail.title = dic?["title"] as? String
                        momDetail.notes = dic?["notes"] as? String
                        momDetail.key = dic?["time"] as? String
                        self?.momList?.insert(momDetail, at: 0)
                    }
                }
                self?.tableView?.reloadData()
            }
        }
    }
}
