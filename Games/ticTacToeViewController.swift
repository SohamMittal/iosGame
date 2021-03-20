//
//  ticTacToeViewController.swift
//  Games
//
//  Created by english on 2020-12-06.
//  Copyright © 2020 AkhilaMadhuri. All rights reserved.
//

import UIKit

class ticTacToeViewController: UIViewController {

    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var lblChoose: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    @IBOutlet weak var choiceO: UIImageView!
    @IBOutlet weak var choiceX: UIImageView!
    @IBOutlet var cells: [UIImageView]!
    var usedCells : [Int] = []
    @IBOutlet weak var lblGameStaus: UILabel!
    var spacesLeft = 9
    var moveTimer : Timer?
    var thinkTimer: Timer?
    var preventMoveTimer : Timer?
    var playerImage : UIImage? = nil;
    var compImage : UIImage? = nil;
    var not = UIImage(named: "not")
    var cross = UIImage(named: "cross")
    var sayings = ["Ahaa!", "That took some time", "It is a little tough!", "Hehe I am a noob", "I am not very good at this"]
    
 
    
    
    @IBOutlet weak var lblTurn: UILabel!
    fileprivate func initGame() {
        
        for cell in cells{
            cell.image = nil;
        }
        btnReset.isHidden = true;
        lblOr.isHidden = false;
        choiceX.isHidden = false;
        choiceO.isHidden = false;
        choiceX.image = cross
        choiceO.image = not
        
        lblGameStaus.text = "Let's begin";
        lblTurn.text = "Please make a selection!";
        choiceO.isUserInteractionEnabled = true;
        choiceX.isUserInteractionEnabled = true;
        
        let imageTapRecognizers = UITapGestureRecognizer(target: self, action: #selector(selection(sender:)))
        let imageTapRecognizersq = UITapGestureRecognizer(target: self, action: #selector(printw(sender:)))
         choiceX.addGestureRecognizer(imageTapRecognizersq)
        choiceO.addGestureRecognizer(imageTapRecognizers)
    }
    
    @objc func printw(sender: UIGestureRecognizer){
        print("I am pressed bitch!")
        print(choiceX.isUserInteractionEnabled)
        
        let choice = sender.view!.tag
        print("I am pressed!")
        if(choice == 100){
            playerImage = UIImage(named: "cross")
            compImage = UIImage(named: "not")
        }
        else if(choice == 101){
            playerImage = UIImage(named: "not")
            compImage = UIImage(named: "cross")
        }
        lblOr.isHidden = true;
        lblChoose.text = "You chose: ";
        choiceX.image  = playerImage;
        choiceO.isHidden = true
        cellsEnabled(true)
    }
    @objc func selection(sender : UIGestureRecognizer){
        
        print(choiceX.isUserInteractionEnabled)
        
        let choice = sender.view!.tag
        print("I am pressed!")
        if(choice == 100){
            playerImage = UIImage(named: "cross")
            compImage = UIImage(named: "not")
        }
        else if(choice == 101){
            playerImage = UIImage(named: "not")
            compImage = UIImage(named: "cross")
        }
        lblOr.isHidden = true;
        lblChoose.text = "You chose: ";
        choiceX.image  = playerImage;
        choiceO.isHidden = true
        cellsEnabled(true)
    }
    
    fileprivate func cellsEnabled(_ choice : Bool) {
        for cell in cells {
            cell.isUserInteractionEnabled = choice
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGame()
        
        for cell in cells {
            cell.isUserInteractionEnabled = false;
            
            let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(playerMove(sender:)))
            cell.addGestureRecognizer(imageTapRecognizer)
            
            
        }
        
        
        
    }
    
    func assignCellImage(_ cellTag: Int , _ cellImage : UIImage) {
        cells[cellTag].image = cellImage
    }
    func isCellEnabled(_ cellTag: Int ,_ choice: Bool){
        cells[cellTag].isUserInteractionEnabled = choice
    }
    fileprivate func addToUsedList(_ cellTag: Int) {
        usedCells.append(cellTag)
        
        
        
    }
    
    // MARK: - Player Move
    @objc func playerMove(sender: UIGestureRecognizer){
        
    
        let cellTag = sender.view!.tag
        
        assignCellImage(cellTag, playerImage!)
        
        isCellEnabled(cellTag, false);
        
        addToUsedList(cellTag)
        
        if(checkWin(cellTag)){
            lblTurn.text = "You won!";
            end();
            return
        }
        
        lblTurn.text = "Computer's Turn";
        spacesLeft -= 1
        if(spacesLeft>1){
            preventPlayerMove()
            moveTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(CompMove), userInfo: nil, repeats: false)
            thinkTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(thinkOutLoud), userInfo: nil, repeats: false)
            lblGameStaus.text = "Hmm... Lemme Think"
            spacesLeft -= 1
        }
        checkGameOver()
    }
    func preventPlayerMove(){
        for cell in cells{
            cell.isUserInteractionEnabled = false;
        }
    }
    
    func checkWin(_ cellTag : Int) ->Bool{
        if(checkRowWin(cellTag) ||   checkColumnWin(cellTag) || checkDiagonalWin(cellTag)){
            return true
        }
        return false;
    }
    
    //MARK: - Check for row Win
    func checkRowWin(_ cellTag : Int) -> Bool{
        let row1 = [0,1,2]
        let row2 = [3,4,5]
        let row3 = [6,7,8]
        
        for n in row1{
            if(cellTag == n ){
                if((cells[row1[0]].image == cells[row1[1]].image ) && (cells[row1[0]].image == cells[row1[2]].image)){
                                
                               return true
                }
            }
        }
        
        for n in row2{
            if(cellTag == n ){
                if((cells[row2[0]].image == cells[row2[1]].image ) && (cells[row2[0]].image == cells[row2[2]].image)){
                                
                               return true
                }
            }
        }
        for n in row3{
            if(cellTag == n ){
                if((cells[row3[0]].image == cells[row3[1]].image ) && (cells[row3[0]].image == cells[row3[2]].image)){
                                
                                return true
                }
            }
        }
        
        return false;
    }
        
    //MARK: - check for column win
    func checkColumnWin(_ cellTag : Int) -> Bool{
        let col1 = [0,3,6]
        let col2 = [1,4,7]
        let col3 = [2,5,8]
       
        for n in col1{
        if(cellTag == n ){
           if((cells[col1[0]].image == cells[col1[1]].image ) && (cells[col1[0]].image == cells[col1[2]].image)){
                           
                           return true
           }
        }
        }

        for n in col2{
        if(cellTag == n ){
           if((cells[col2[0]].image == cells[col2[1]].image ) && (cells[col2[0]].image == cells[col2[2]].image)){
                           
                           return true
           }
        }
        }
        for n in col3{
        if(cellTag == n ){
           if((cells[col3[0]].image == cells[col3[1]].image ) && (cells[col3[0]].image == cells[col3[2]].image)){
                           
                           return true
           }
        }
        }
              return false
    }
    
    //MARK: - check for diagonal win
    func checkDiagonalWin(_ cellTag : Int) -> Bool{
        let daig1 = [0,4,8]
        let diag2 = [2,4,6]
        
        for n in daig1{
            if(cellTag == n ){
               if((cells[daig1[0]].image == cells[daig1[1]].image ) && (cells[daig1[0]].image == cells[daig1[2]].image)){
                               
                               return true
               }
            }
        }
        
        for n in diag2{
            if(cellTag == n ){
               if((cells[diag2[0]].image == cells[diag2[1]].image ) && (cells[diag2[0]].image == cells[diag2[2]].image)){
                               
                              return true
               }
            }
        }
        return false
    }
    
    func checkGameOver(){
        if(spacesLeft == 0){
            lblTurn.text = "It's a draw!";
            end();
        }
    }
    @objc func thinkOutLoud(){
        lblGameStaus.text = sayings[Int.random(in: 0...4)]
        thinkTimer?.invalidate();
        thinkTimer = nil;
    }
    
    // MARK: - Computer Move
    @objc func CompMove(){
        
        var number : Int
        number = Int.random(in: 0...8)
        while(numExists(number)){
            number = Int.random(in: 0...8)
        }
        
        assignCellImage(number, compImage!)
        isCellEnabled(number, false)
        addToUsedList(number)
        
        if(checkWin(number)){
            lblTurn.text = "Computer Won!";
            end();
        }
        
        
        lblTurn.text = "Your Turn"
        
        enableUserInput()
        
        preventMoveTimer?.invalidate();
        preventMoveTimer = nil
        moveTimer?.invalidate()
        moveTimer = nil
    }
    
    func enableUserInput(){
        for cell in cells{
            cell.isUserInteractionEnabled = true;
        }
        for index in usedCells{
            cells[index].isUserInteractionEnabled = false;
        }
    }
    
    func numExists(_ number : Int) ->Bool{
        
        for item in usedCells {
            if(number == item){
                return true
            }
        }
        return false
    }
    
    func end(){
        btnReset.isHidden = false;
        
    }
    @IBAction func Reset(_ sender: Any) {
        initGame()
        usedCells.removeAll()
        spacesLeft = 8
    }
}
