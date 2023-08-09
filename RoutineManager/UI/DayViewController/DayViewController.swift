//
//  DayViewController.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

public final class DayViewController: UIViewController {

    
    
    
    private let dataSource = DayDataSource()
    
    private let presenter: DayPresenter
    
    private let soundUtil = SoundUtil(sound: .DoubleClick)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var provressView: UIProgressView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBackground: UIView!
    
    @IBOutlet weak var congratsView: UIView!
    
    @IBOutlet weak var successStack: UIStackView!
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(presenter: DayPresenter) {
        self.presenter = presenter
        super.init(nibName: "DayViewController", bundle: Bundle.main)
    }
    

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavbar(title: "Undefined")
        
        self.tableView.delegate = dataSource
        self.tableView.dataSource = dataSource
        self.tableView.tableFooterView = UIView()
        
        self.successStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:))))
        
        self.presenter.fetchData()
    }
    
    
    func navigateToTimer(){
        let navigator = ( UIApplication.shared.delegate as? AppDelegate )?.getNavigator()
        let appcomponent = ( UIApplication.shared.delegate as? AppDelegate )?.getAppComponent()
        guard let timerUtil = appcomponent?.getTimerUtil(),
              let timerScreen = navigator?.getTimerScreen(timerUtil: timerUtil) else { return }
        self.navigationController?.pushViewController(timerScreen, animated: true)
    }
    
    func updateTableViewContent(content: DayContent){
        self.setupNavbar(title: content.day)
        
        content.models.forEach{
            let nib = UINib(nibName: $0.reuseIdentifier, bundle: nil)
            self.tableView?.register(nib, forCellReuseIdentifier: $0.reuseIdentifier)
        }
        
        self.dataSource.setData(data: content.models)
        self.tableView.reloadData()
    }
    
    
    func removeItem(itemName: String){
        guard let updatedModel = dataSource.removeModelByName(itemName) else {
            return
        }
        
        
        let progress: Double = Double((updatedModel.currentCount * 100 ) / updatedModel.totalCount)
        self.tableView.deleteRows(at: updatedModel.indexPath, with: .automatic)
        self.updateProgress(progress: 100 - progress)
        self.checkAllFinished(model: updatedModel)
        self.soundUtil.play()
    }
    
    private func checkAllFinished(model: UpdatedProgressModel){
        if(model.currentCount == 0){
            self.showTableView(false)
        }
    }
    
    private func updateProgress(progress: Double){
        self.provressView.setProgress(Float(progress * 0.01), animated: true)
        self.progressLabel.attributedText =  NSAttributedString(
            string: "\(progress)%",
            attributes: [
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .strokeWidth: -5.0
            ]
        )
    }
    
    
    @objc func onTap(_ sender: UITapGestureRecognizer? = nil){
        self.soundUtil.play()
        self.presenter.fetchData()
        self.updateProgress(progress: 0.0)
        self.showTableView(true)
    }
    
    
    private func showTableView(_ value: Bool){
        self.tableView.isHidden = !value
        self.progressBackground.isHidden = !value
        self.congratsView.isHidden = value
    }

}
