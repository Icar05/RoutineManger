//
//  TestViewConroller.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit

public final class TestViewConroller: UIViewController {

    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: "TestViewConroller", bundle: Bundle.main)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

    }

}
