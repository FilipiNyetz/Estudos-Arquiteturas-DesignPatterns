//
//  Presenter.swift
//  MVPArchiteture
//
//  Created by Filipi Romão on 04/11/25.
//

import Foundation
import UIKit

//https://jsonplaceholder.typicode.com/users

protocol PresenterDelegate: AnyObject {
    func presentUser(users: [User])
    func presenteAlert(title: String, message: String)
}

typealias Presenter = PresenterDelegate & UIViewController

class UserPresenter {

    var delegate: PresenterDelegate?

    public func getUsers() {
        print("chamou a funcao getUser")
        guard
            let url = URL(string: "https://jsonplaceholder.typicode.com/users")
        else { return }
        let task = URLSession.shared.dataTask(with: url) {
            [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUser(users: users)
            } catch {
                print(error)
            }

        }
        task.resume()
    }
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}

