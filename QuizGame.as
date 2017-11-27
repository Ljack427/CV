package com.Ljack {
  import flash.display.MovieClip;
  import flash.text.TextField;
  import flash.display.SimpleButton;
  import flash.events.Event;
  import com.Ljack.QuestionBank;
  import flash.events.MouseEvent;
  import flash.utils.setTimeout;

public class QuizGame extends MovieClip {
    public var trueBtn:SimpleButton;
    public var falseBtn:SimpleButton;
    public var questionText:TextField;
    public var statusMsg:TextField;
    
	private var questionBank:QuestionBank;
    private var questionArray:Array;
    private const questionMax:int = 5;
    private var questionCount:int = 0;
    private var currentAnswer:String;
    private var currentScore:int = 0;

public function QuizGame() {
      statusMsg.text = "";
      questionArray = new Array();
      questionBank = new QuestionBank();
      questionBank.addEventListener(Event.COMPLETE, dataReady);
      trueBtn.addEventListener(MouseEvent.CLICK, truePressed);
      falseBtn.addEventListener(MouseEvent.CLICK, falsePressed);
    }
private function truePressed(e:MouseEvent):void {
      if(statusMsg.text == ""){
        if(currentAnswer == "true"){
          currentScore += 100/questionMax;
          statusMsg.text = "CORRECT!";
        }else{
          statusMsg.text = "WRONG";
        }
        setTimeout(newQuestion, 1000);
      }
    }
    private function falsePressed(e:MouseEvent):void {
      if(statusMsg.text == ""){
        if(currentAnswer == "false"){
          currentScore += 100/questionMax;
          statusMsg.text = "CORRECT!";
        }else{
          statusMsg.text = "WRONG";
        }
        setTimeout(newQuestion, 1000);
      }
    }
    private function dataReady(e:Event):void {
      questionArray = questionBank.buildBank();
      grabQuestion();
    }
    private function newQuestion():void {
      statusMsg.text = "";
      trace(currentScore);
      grabQuestion();
    }
    private function grabQuestion():void {
      if(questionCount < questionMax){
        var max:int = questionArray.length-1;
        var rq:int = Math.floor(Math.random() * (max - 0 + 1));
        var ta:Array = questionArray.splice(rq, 1);
        questionText.text = ta[0].q;
        currentAnswer = ta[0].tf;
        questionCount++;
      }else{
        gameOver();
      }
    }
    private function gameOver():void {
      statusMsg.text = currentScore+"/100 points";
      questionText.text = "Game Over!";
    }
  }
}