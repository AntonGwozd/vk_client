//
//  NewsViewController.swift
//  vk_gvozd_client
//
//  Created by Anton Gvozdanov on 09/10/2019.
//  Copyright © 2019 Anton Gvozdanov. All rights reserved.
//

import UIKit

//Структура новостей
//Каждая новость это секция
struct NewsStruct {
    var newsHead: String
    var newsText: String
    var newsFoto: UIImage
    var newsLike: Int
    var newsSeeCount: Int
}


class NewsViewController: UITableViewController {
    
    var newsArray: [NewsStruct] = []
    var sectionName: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //заполним массив новостей
        createNewsArray()
        
        //регистрируем ячейки
        tableView.register(UINib(nibName: "NewsFotoCell", bundle: nil), forCellReuseIdentifier: "newsFotoCell")
        tableView.register(UINib(nibName: "NewsTextCell", bundle: nil), forCellReuseIdentifier: "newsTextCell")
        tableView.register(UINib(nibName: "NewsControllCell", bundle: nil), forCellReuseIdentifier: "newsControllCell")
    }
        
    //Количество Секций
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    //имена секций
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
    
    //Количество строк в секции по размеру массива
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //Заполнение ячейки по данным масива
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsFotoCell", for: indexPath) as! NewsFotoCell
            cell.newsFoto.image = newsArray[indexPath.section].newsFoto
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsTextCell", for: indexPath) as! NewsTextCell
            cell.newsText.text = newsArray[indexPath.section].newsText
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsControllCell", for: indexPath) as! NewsControllCell
            cell.newsLikeCount.text = String(newsArray[indexPath.section].newsLike)
            if newsArray[indexPath.section].newsLike == 0 {
                cell.newsLikeValue.likeValue = false
            } else {
                cell.newsLikeValue.likeValue = true
            }
            cell.newsSeeCount.text = String(newsArray[indexPath.section].newsSeeCount)
            return cell
        }
    }
    
    //Селект десселкт строки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createNewsArray() {
        var news1 = NewsStruct(newsHead: "ГРУ 29155", newsText: "Это подразделение ГРУ расположено в Москве. Основной вид его деятельности - обеспечение военной безопасности. Этот центр подготовки специалистов ГРУ на 100% принадлежит Минобороны. Возглавляет его Герой России генерал Андрей Аверьянов. Подробнее: https://www.newsru.com/", newsFoto: UIImage(named: "news1")!, newsLike: 0, newsSeeCount: 0)
        var news2 = NewsStruct(newsHead: "ФБК Навального - иноагент", newsText: "Факт соответствия организации признакам некоммерческой организации, выполняющей функции иностранного агента, установлен в ходе проведенного Главным управлением Минюста России по Москве текущего контроля за ее деятельностью, - заявили в министерстве.", newsFoto: UIImage(named: "news2")!, newsLike: 0, newsSeeCount: 0)
        
        newsArray = [news1, news2]
        sectionName = [news1.newsHead, news2.newsHead]
    }
}
