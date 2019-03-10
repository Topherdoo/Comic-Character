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
		
		private var mug:MovieClip = new Mug();
		private var accel:Accelerometer = new Accelerometer();
		private var box:TextField = new TextField;
		private var beer:MovieClip = new Beer();
		private var mugX:Point;
		private var empty:Boolean;
		
		public function BeerGame() 
		{
			accel.setRequestedUpdateInterval(15);
			
			addEventListener(Event.ADDED, addGame);
		}
		
		private function addGame(event:Event):void
		{
			addMug();
			
			box.textColor = 0xFFFFFF;
			
			addChild(beer);
			
			addChild(mug);
			
			addChild(box);
			
			mug.x = stage.stageWidth/2;
			mug.y = stage.stageHeight/2;
			
			beer.x = mug.width/2;
			
			accel.addEventListener(AccelerometerEvent.UPDATE, rotateMug);
			removeEventListener(Event.ADDED, addGame);
		}
		
		private function addMug():void
		{
			mug.rotation = 0;
			
			beer.y = mug.y + mug.height/2;
			
			mugX = new Point(0, 0);
		}
		
		private function rotateMug(event:AccelerometerEvent):void
		{
			var angle:Number = Math.round(Math.atan2(event.accelerationX, event.accelerationY) * 180/Math.PI);
			
			box.text = angle.toString();
			
			if (angle > -20 && angle < 179)
			{	
				mug.rotation = -angle;
				
				if (mug.beerMug.localToGlobal(mugX).y > beer.y - beer.height)
				{
					beer.y = mug.beerMug.localToGlobal(mugX).y + beer.height;
					
					if (beer.y > 2000)
					{
						empty = true;
					}
				}
				
				if (angle < 10 && angle > -10 && empty)
				{
					empty = false;
					
					addMug();
				}					

			}

		}

	}
	
}