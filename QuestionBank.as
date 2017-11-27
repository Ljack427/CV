package com.Ljack {
  import flash.net.URLRequest;
  import flash.net.URLLoader;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  
	public class QuestionBank extends EventDispatcher {
    private const JSON_URL:String = "com.Ljack.QuestionBank";
    private var jsonRequest:URLRequest;
    private var jsonLoader:URLLoader;
    private var questionArray:Array;
    public function QuestionBank() {
      questionArray = new Array();
      loadJSON();
    }
    private function loadJSON():void {
      jsonRequest = new URLRequest(JSON_URL);
      jsonLoader = new URLLoader();
      jsonLoader.addEventListener(Event.COMPLETE, jsonLoaded);
      jsonLoader.load(jsonRequest);
    }
    private function jsonLoaded(e:Event):void {
      var jsonData:Object = JSON.parse(e.target.data);
      for each (var question:Object in jsonData.questions){
        questionArray.push(question);
      }
      dispatchEvent(new Event(Event.COMPLETE));
    }
    public function buildBank():Array {
      var b:Array = new Array();
      var max:int = questionArray.length;
      for(var i:int=0; i<max; i++){
        b.push({q:questionArray[i].q, tf:questionArray[i].tf});
      }
      return b;
    }
  }
}