//
//  ViewController.swift
//  Tables-Collections
//
//  Created by Елизавета Каранкевич on 29.03.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // таблица
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell") //регистрация кастомнойи ячейки
        table.estimatedRowHeight = 30 //предполагаемая высота ячейки
        table.rowHeight = UITableView.automaticDimension // высчитывается само
        return table
    }()
    
    // данные для таблицы
    let tableData = [
        Book(title: "Властелин Колец", author: "Толкин"),
        Book(title: "Гарри Поттер", author: "Роулинг"),
        Book(title: "Код да Винчи", author: "Дэн Браун"),
        Book(title: "Немезида", author: "Ю Несбе"),
    ]
    
    // коллекция
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 120) // размер ячейки
        layout.minimumInteritemSpacing = 10 // горизонтальный отступ между ячейками
        layout.minimumLineSpacing = 10 // вертикальный отступ между ячейками
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    // исходные данные для коллекции
    var collectionData = [
        Pet(imageName: "cat", title: "Котенок"),
        Pet(imageName: "puppy", title: "Щенок"),
        Pet(imageName: "rabbit", title: "Кролик"),
        Pet(imageName: "snake", title: "Змейка")
    ]
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        getConstraints()
    }
    
    //кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    // тут настраивается ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let item = tableData[indexPath.row]
        cell.titleLabel.text = item.title
        cell.subtitleLabel.text = item.author
        return cell
    }
    
    // нажатие на ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Выбрана строка: \(tableData[indexPath.row])")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CustomCollectionViewCell
        let item = collectionData[indexPath.item]
        cell.imageView.image = UIImage(named: item.imageName)
        cell.titleLabel.text = item.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Выбран элемент: \(collectionData[indexPath.item])")
    }
    
    @objc private func refreshData() {
        let newItems = [
            Pet(imageName: "humster", title: "Хомяк"),
            Pet(imageName: "raccoon", title: "Енот")
        ]
        collectionData.append(contentsOf: newItems) // добавляем новые элементы
        collectionData.shuffle()
        collectionView.reloadData() // обновляем коллекцию
        collectionView.refreshControl?.endRefreshing() //хз что это, но гугл говорит, что надо добавлять
    }
    
    
    
    // MARK: getConstraints
    private func getConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(200) // а как сделать, чтобы высота сама определялась и не растягивалась на весь экран?
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            
        }
    }
    
}
