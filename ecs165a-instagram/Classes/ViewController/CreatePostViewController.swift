//
//  CreatePostViewController.swift
//  ecs165a-instagram
//
//  Created by Korman Chen on 2/23/19.
//  Copyright © 2019 Korman Chen. All rights reserved.
//

import UIKit

class CreatePostViewController: InputViewController {

    private let ROW_HEIGHT: CGFloat = 100
    private let SECTION_HEIGHT: CGFloat = 200
    private let TOTAL_ROWS = 2

    private let createPostVM = CreatePostViewModel()

    private let headerView: ImageHeaderView = {

        let view = ImageHeaderView()
        view.addTarget(target: self, selector: #selector(addImage))
        return view
    }()

    override func setup() {

        super.setup()

        let postButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(postTapped))

        navigationItem.rightBarButtonItem = postButton
        navigationController?.navigationBar.tintColor = .themeBlue

        tableview.separatorStyle = .singleLine
        tableview.separatorColor = .themeLightGray

        tableview.register(PlainTextViewTableViewCell.self, forCellReuseIdentifier: plainTextViewCellId)
    }

    override func getCellIdForRow(row: Int) -> String {
        return plainTextViewCellId
    }

    @objc private func addImage() {

        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { [weak self] action in
            self?.presentImagePicker(source: .camera)
        })

        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .default, handler: { [weak self] action in
            self?.presentImagePicker(source: .photoLibrary)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        let actionSheet = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
        actionSheet.addAction(actions: [cameraAction, photoAlbumAction, cancelAction])

        present(actionSheet, animated: true, completion: nil)
    }

    @objc private func postTapped() {

        showSpinner()

        createPostVM.create { [weak self] serviceResponse in

            self?.stopSpinner()

            if serviceResponse.isSuccess {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }

    private func presentImagePicker(source: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(source) {

            let controller = UIImagePickerController()
            controller.sourceType = source
            controller.delegate = self

            present(controller, animated: true, completion: nil)
        }
    }
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: ImagePickerController Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        headerView.config(image: info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
        dismiss(animated: true, completion: nil)
    }

    // MARK: TableView Delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ROW_HEIGHT
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SECTION_HEIGHT
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TOTAL_ROWS
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableview, cellForRowAt: indexPath)

        if let cell = cell as? PlainTextViewTableViewCell {

            cell.config(placeholder: indexPath.row == createPostVM.CAPTION_ROW
                ? "Enter your caption here." : "Tag your friends here by username. (i.e @JaneDoe @JohnDoe)")

            cell.textChanged = { [weak self] text in
                self?.createPostVM.set(text: text, row: indexPath.row)
            }
            cell.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        }

        return cell
    }
}
