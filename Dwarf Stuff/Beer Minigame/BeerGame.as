package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.sensors.Accelerometer;
	import flash.events.AccelerometerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextColorType;
	
	
	public class BeerGame extends MovieClip 
	{
		
		//private var beer:MovieClip = new Beer();
		private var beerLow:Number = 0;
		private var mug:MovieClip = new Mug();
		private var accel:Accelerometer = new Accelerometer();
		private var box:TextField = new TextField;
		
		public function BeerGame() 
		{
			accel.setRequestedUpdateInterval(15);
			
			addEventListener(Event.ADDED, addGame);
		}
		
		private function addGame(event:Event):void
		{
			mug.x = stage.stageWidth/2;
			mug.y = stage.stageHeight/2;
			
			addChild(mug);
			
			addChild(box);
			
			box.textColor = 0xFFFFFF;
			
			accel.addEventListener(AccelerometerEvent.UPDATE, rotateMug);
			removeEventListener(Event.ADDED, addGame);
		}
		
		private function rotateMug(event:AccelerometerEvent):void
		{
			var angle:Number = Math.atan2(event.accelerationX, event.accelerationY) * 180/Math.PI;
			
			box.text = angle.toString();
			
			if (angle > -20 && angle < 179)
			{	
					mug.beer.rotation = angle;
					trace(mug.beer.y);
			}

		}

	}
	
}