//
//  MOMDetailViewController.swift
//  MOM
//
//  Created by SowmiyaRagul on 25/03/23.
//

import UIKit
import ActionSheetPicker_3_0
import FirebaseDatabase

class MOMDetailViewController : BaseViewController {
    //MARK: Outlet
    @IBOutlet weak var navigationBar: UINavigationBar?
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var notesTextView: UITextView?
    @IBOutlet weak var addAndEditButton: UIButton?
    @IBOutlet weak var selectDateTextField: UITextField?
    @IBOutlet weak var editIconButton: UIButton?
    @IBOutlet weak var selectDateButton: UIButton?
    
    //MARK: Local Variable
    var dataBaseReference: DatabaseReference?
    var menu: Menu?
    var momDetail: MOMDetail?
    var viewModel = MOMViewModel()
    
    @IBAction func addNotesTapped(_ sender: UIButton) {
        switch true {
        case titleTextField?.text?.isEmpty:
            showAlert(message: Constants.title)
            break
        case selectDateTextField?.text?.isEmpty:
            showAlert(message: Constants.selectDate)
            break
        case notesTextView?.text.isEmpty:
            showAlert(message: Constants.notes)
            break
        default:
            dismiss(animated: true) { [weak self] in
                if self?.menu == .add {
                    self?.writeData()
                } else {
                    var momDetail = MOMDetail()
                    momDetail.key = self?.momDetail?.key
                    momDetail.title = self?.titleTextField?.text
                    momDetail.notes = self?.notesTextView?.text
                    momDetail.date = self?.selectDateTextField?.text
                    self?.viewModel.saveData(momDetail: momDetail) { isSuccess in
                        
                    }
                }
            }
        }
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        titleTextField?.isUserInteractionEnabled = true
        notesTextView?.isUserInteractionEnabled = true
        selectDateTextField?.isUserInteractionEnabled = true
        selectDateButton?.isUserInteractionEnabled = true
        addAndEditButton?.isHidden = false
        menu = .edit
        setUpUI()
    }
    
    @IBAction func SelectDateTapped(_ sender: UIButton) {
        ActionSheetDatePicker.show(withTitle: "SelectDate", datePickerMode: .date, selectedDate: Date(), minimumDate: nil, maximumDate: Date(), doneBlock: { [weak self] picker, date, _ in
            if let date = date as? Date {
                self?.selectDateTextField?.text = date.getDate(date: date)
            }
        }, cancel: { cancel in
            
        }, origin: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        if menu != .add {
            titleTextField?.isUserInteractionEnabled = false
            notesTextView?.isUserInteractionEnabled = false
            selectDateTextField?.isUserInteractionEnabled = false
            selectDateButton?.isUserInteractionEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if menu == .view || menu == .edit {
            setMOMDetail()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView?.delegate = self
        dataBaseReference = Database.database().reference()
    }
    
    private func setUpUI() {
        addAndEditButton?.layer.cornerRadius = 5.0
        addAndEditButton?.isHidden = (menu == .add || menu == .edit) ? false : true
        editIconButton?.isHidden = menu == .view ? false : true
        addAndEditButton?.setTitle(menu == .edit ? "Save" : "Add", for: .normal)
    }
    
    //MARK: SetMOMDetail
    private func setMOMDetail() {
        titleTextField?.text = momDetail?.title
        notesTextView?.text = momDetail?.notes
        selectDateTextField?.text = momDetail?.date
    }
}

//MARK: AddAndSaveData
extension MOMDetailViewController {
    private func writeData() {
        var dataDictionary : [String: Any] = [:]
        dataDictionary["title"] = titleTextField?.text ?? ""
        dataDictionary["notes"] =  notesTextView?.text ?? ""
        dataDictionary["date"] =  selectDateTextField?.text ?? ""
        dataDictionary["time"] = "\(date)_\(hour)_\(minutes)_\(seconds)"
        dataBaseReference?.child("MOM").child("\(date)_\(hour)_\(minutes)_\(seconds)").setValue(dataDictionary)
    }
}

//MARK: UITextView
extension MOMDetailViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == notesTextView {
            if notesTextView?.text == "Enter your notes..." {
                notesTextView?.text = ""
            }
            notesTextView?.textColor = .darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}


