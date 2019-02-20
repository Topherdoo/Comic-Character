package  
{
	
	import flash.display.MovieClip;
	import flash.ui.Multitouch;
	import flash.events.TouchEvent;
	import flash.display.SimpleButton;
	import flash.ui.MultitouchInputMode;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	
	
	public class ItemBar extends MovieClip 
	{
		private var background:MovieClip = new Background();
		private var lButton:SimpleButton = new LButton();
		private var rButton:SimpleButton = new RButton();
		//number of item slots
		private var itemBar:MovieClip = new ItemBarMC();
		//space between item slots
		private var itemSlot:MovieClip;	
		//Y position of the item bar
		private var itemBarY:Number = 1140;
		//how far the bar can move to the left before stopping
		private var itemBarEnd:Number = -413.25;
		//how far the icons move when pressing an arrow (basically the width of one item slot)

		private var movement:Number = 137.75;
		//Friction for swiping
		private var friction:Number = 0.4;
		//Velocity for swiping
		private var vel:Number = 0;
		//for finding velocity
		private var oldFrame:Number = 0;
		//private var newFrame:Number = 0;
		
		public function ItemBar() 
		{	
			//position of the right button
			rButton.x = 720;
			rButton.y = itemBarY;
			lButton.y = itemBarY;
			itemBar.y = itemBarY;

			addChild(background);
			addChild(itemBar);
			addChild(lButton);
			addChild(rButton);
			
			//set up touch
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			//event listeners for left and right buttons
			lButton.addEventListener(TouchEvent.TOUCH_TAP, LeftButtonTap);
			rButton.addEventListener(TouchEvent.TOUCH_TAP, RightButtonTap);

			//event listener for item bar drag
			itemBar.addEventListener(TouchEvent.TOUCH_MOVE, bar_TouchBeginHandler);
			
			//event listeners for the items
			itemBar.slot1.addEventListener(TouchEvent.TOUCH_TAP, slot1Tap);
			itemBar.slot2.addEventListener(TouchEvent.TOUCH_TAP, slot2Tap);
			itemBar.slot3.addEventListener(TouchEvent.TOUCH_TAP, slot3Tap);
			itemBar.slot4.addEventListener(TouchEvent.TOUCH_TAP, slot4Tap);
			itemBar.slot5.addEventListener(TouchEvent.TOUCH_TAP, slot5Tap);
			itemBar.slot6.addEventListener(TouchEvent.TOUCH_TAP, slot6Tap);
		}
		
		private function LeftButtonTap(event:TouchEvent):void
		{
			//end any velocity
			vel = 0;
			
			//check the bar's position to make sure it is divisible by the movement (137.75)
			var num = itemBar.x % movement;
			
			//check if the bar is as far as it can go
			if(itemBar.x >= 0)
			{
				itemBar.x = 0;
			}
			
			//check if it is between two items, if so go to the next closest			
			else if(num != 0)
			{
				itemBar.x -= num;
			}
			
			//move the item slots one over			
			else
			{
				itemBar.x += movement;
			}
		}		
		private function RightButtonTap(event:TouchEvent):void
		{
			vel = 0;
			
			var num = itemBar.x % movement;

			if(itemBar.x <= itemBarEnd)
			{
				itemBar.x = itemBarEnd;
			}

			else if(num != 0)
			{
				trace(itemBar.x, num);
				itemBar.x -= movement + num;
			}
			
			else
			{
				itemBar.x -= movement;
			}
		}
		
		private function bar_TouchBeginHandler(event:TouchEvent):void
		{
			trace("start drag");
			
			//start dragging the item bar, ccan only be dragged on the x axis, starting at itemBarEnd and ending at -itemBarEnd (between -413.25 and 0)
			var fl_DragBounds:Rectangle = new Rectangle(itemBarEnd, itemBarY, -itemBarEnd, 0)
			itemBar.startTouchDrag(event.touchPointID, false, fl_DragBounds);
			
			//add an event listener to look at where the bar's current X is
			addEventListener(Event.ENTER_FRAME, Dragging);
			
			//add an event listener to end the drag
			addEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);
			
			//disable the item slots when dragging (not sure if mouseEnabled works on mobile)
			itemBar.slot1.mouseEnabled = false;
			itemBar.slot2.mouseEnabled = false;
			itemBar.slot3.mouseEnabled = false;
			itemBar.slot4.mouseEnabled = false;
			itemBar.slot5.mouseEnabled = false;
			itemBar.slot6.mouseEnabled = false;
		}

		private function bar_TouchEndHandler(event:TouchEvent):void
		{
			trace("end drag");
			
			//stop dragging the bar
			itemBar.stopTouchDrag(event.touchPointID);
			
			//stop looking at the bar position
			removeEventListener(Event.ENTER_FRAME, Dragging);
			
			//set the velocity using the previous position and current position
			vel = itemBar.x - oldFrame;
			
			//start updating the velocity
			addEventListener(Event.ENTER_FRAME, doVelocity)
			
			//stop looking for drag end
			removeEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);
			
			//re-enable the items (if this works)
			itemBar.slot1.mouseEnabled = true;
			itemBar.slot2.mouseEnabled = true;
			itemBar.slot3.mouseEnabled = true;
			itemBar.slot4.mouseEnabled = true;
			itemBar.slot5.mouseEnabled = true;
			itemBar.slot6.mouseEnabled = true;
		}
		
		private function Dragging(event:Event):void
		{
			//get the current frame of the bar
			oldFrame = itemBar.x;
		}
		
		private function doVelocity(event:Event):void
		{
			//slow down the velocity with friction if under the minimum (1 or -1)
			if(vel < 1 && vel > -1)
			{
				removeEventListener(Event.ENTER_FRAME, doVelocity);				
			}
			
			else if(vel >= 1)
			{
				vel -= friction;		
			}
			
			else if(vel <= -1)
			{
				vel += friction;
			}
			
			//add the velocity to the item bar
			itemBar.x += vel;
			
			//make sure the item bar is still within view, if not stop the velocity
			if(itemBar.x <= itemBarEnd)
			{
				itemBar.x = itemBarEnd;
				vel = 0;
			}
			
			else if(itemBar.x >= 0)
			{
				itemBar.x = 0;
				vel = 0;
			}
		}
		
		//item touch events
		private function slot1Tap(event:TouchEvent):void
		{
			background.visible = false;
			trace("Slot 1 Tapped");
		}
		
		private function slot2Tap(event:TouchEvent):void
		{
						background.visible = true;
			trace("Slot 2 Tapped");
		}	
		
		private function slot3Tap(event:TouchEvent):void
		{
						background.visible = false;
			trace("Slot 3 Tapped");
		}	
		
		private function slot4Tap(event:TouchEvent):void
		{
						background.visible = true;
			trace("Slot 4 Tapped");
		}	
		
		private function slot5Tap(event:TouchEvent):void
		{
						background.visible = false;
			trace("Slot 5 Tapped");
		}	
		
		private function slot6Tap(event:TouchEvent):void
		{
						background.visible = true;
			trace("Slot 6 Tapped");
		}
	}
}
