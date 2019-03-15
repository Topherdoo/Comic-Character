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
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	//for testing items
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	
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
		private var itemBarY:Number = 500;
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
		//area the bar can be dragged
		private var fl_DragBounds:Rectangle = new Rectangle(itemBarEnd, itemBarY, -itemBarEnd, 0)
		//wait time before dragging, to allow for tap
		private var dragDelay:Timer = new Timer(60);
		//arrays for the items
		private var itemSlots:Array = new Array();
		private var items:Array = new Array();
		
		public function ItemBar() 
		{	
			//position of the right button
			rButton.x = 720;
			rButton.y = itemBarY;
			lButton.y = itemBarY;
			itemBar.y = itemBarY;

			//addChild(background);
			addChild(itemBar);
			addChild(lButton);
			addChild(rButton);
			
			//set up touch
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

			//event listeners for left and right buttons
			lButton.addEventListener(TouchEvent.TOUCH_TAP, LeftButtonTap);
			rButton.addEventListener(TouchEvent.TOUCH_TAP, RightButtonTap);

			
			//event listener looking for a touchon the bar
			itemBar.addEventListener(TouchEvent.TOUCH_BEGIN, startDragging);
			
			//array of the item slots
			itemSlots[0] = itemBar.slot1;
			itemSlots[1] = itemBar.slot2;
			itemSlots[2] = itemBar.slot3;
			itemSlots[3] = itemBar.slot4;
			itemSlots[4] = itemBar.slot5;
			itemSlots[5] = itemBar.slot6;
			
			//event listeners for item testing buttons ---------------Remove these for the game--------------------
			b1.addEventListener(TouchEvent.TOUCH_TAP, b1t);
			b2.addEventListener(TouchEvent.TOUCH_TAP, b2t);
			b3.addEventListener(TouchEvent.TOUCH_TAP, b3t);
			b4.addEventListener(TouchEvent.TOUCH_TAP, b4t);
			b5.addEventListener(TouchEvent.TOUCH_TAP, b5t);
			b6.addEventListener(TouchEvent.TOUCH_TAP, b6t);
		}
		
		//Test buttons -----------------------------Remove these for the game-----------------------------------
		private function b1t(event:TouchEvent):void
		{
			addBeer();
		}	
		
		private function b2t(event:TouchEvent):void
		{
			addHookshot();
		}
		
		private function b3t(event:TouchEvent):void
		{
			addHammer();
		}
		
		private function b4t(event:TouchEvent):void
		{
			addLightning();
		}	
		
		private function b5t(event:TouchEvent):void
		{
			addFire();
		}
		
		private function b6t(event:TouchEvent):void
		{
			addDagger();
		}
		
		//------------------------ Call these functions when you want to add an item ----------------------------
		//_______________________________________________________________________________________________________
		
		private function addBeer():void
		{
			var exists = false;
			
			//check the items to see if the needed item already exists, to prevent getting multiple
			for each (var item in items)
			{
				if (item.name == "beer")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
				//make the item icon
				var beer = new BeerItem();
				//name the item so that we can check if it is in the items
				beer.name = "beer";
				//add it to the bar
				itemBar.addChild(beer);
				//set the item's position to the first available slot
				beer.x = itemSlots[items.length].x;
				//add an event listener for the item
				beer.addEventListener(TouchEvent.TOUCH_TAP, useBeer);

				//add the item to the items array
				items.push(beer);					
			}

		}
				
		private function addHookshot():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "hookshot")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var hookshot = new HookshotItem();
			hookshot.name = "hookshot";
			//add it to the bar
			itemBar.addChild(hookshot);
			//set the item's position to the first available slot
			hookshot.x = itemSlots[items.length].x;
			//add an event listener for the item
			hookshot.addEventListener(TouchEvent.TOUCH_TAP, useHookshot);
			
			//add the item to the items array
			items.push(hookshot);
			}
		}	
		
		private function addHammer():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "hammer")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var hammer = new HammerItem();
			hammer.name = "hammer";
			//add it to the bar
			itemBar.addChild(hammer);
			//set the item's position to the first available slot
			hammer.x = itemSlots[items.length].x;
			//add an event listener for the item
			hammer.addEventListener(TouchEvent.TOUCH_TAP, useHammer);
			
			//add the item to the items array
			items.push(hammer);
			}
		}
		
		private function addLightning():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "lightning" || item.name == "fire")
				{
					exists = true;
					
					break;
				}
			}
			
			if (exists == false)
			{
			//make the item icon
			var lightning = new LightningItem();
			lightning.name = "lightning";
			//add it to the bar
			itemBar.addChild(lightning);
			//set the item's position to the first available slot
			lightning.x = itemSlots[items.length].x;
			//add an event listener for the item
			lightning.addEventListener(TouchEvent.TOUCH_TAP, useLightning);
			
			//add the item to the items array
			items.push(lightning);
			}
		}
		
		private function addFire():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "lightning" || item.name == "fire")
				{
					exists = true;
					
					break;
				}
			}
			
			
			if (exists == false)
			{
			//make the item icon
			var fire = new FireItem();
			fire.name = "fire";
			//add it to the bar
			itemBar.addChild(fire);
			//set the item's position to the first available slot
			fire.x = itemSlots[items.length].x;
			//add an event listener for the item
			fire.addEventListener(TouchEvent.TOUCH_TAP, useFire);
			
			//add the item to the items array
			items.push(fire);
			}
		}
		
		private function addDagger():void
		{
			var exists = false;
			
			for each (var item in items)
			{
				if (item.name == "dagger")
				{
					exists = true;
					
					break;
				}
			}

			if (exists == false)
			{
			//make the item icon
			var dagger = new DaggerItem();
			dagger.name = "dagger";
			//add it to the bar
			itemBar.addChild(dagger);
			//set the item's position to the first available slot
			dagger.x = itemSlots[items.length].x;
			//add an event listener for the item
			dagger.addEventListener(TouchEvent.TOUCH_TAP, useDagger);
			
			//add the item to the items array
			items.push(dagger);
			}
		}
		
		private function LeftButtonTap(event:TouchEvent):void
		{
			//end any velocity
			vel = 0;
			
			//check the bar's position to make sure it is divisible by 137.75 (where it's centered)
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
		
		private function startDragging(event:TouchEvent):void
		{
			//when touch begins, start the delay timer
			dragDelay.addEventListener(TimerEvent.TIMER, Delay);
			dragDelay.start();
			
			trace("timer started");
			
			//add an event listener for ending touch
			addEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);
		}
		
		private function Delay(event:TimerEvent):void
		{
			//when delay ends, start the touch move event to drag the bar
			itemBar.addEventListener(TouchEvent.TOUCH_MOVE, bar_TouchMove);
			
			//add an event listener to look at where the bar's current X is
			addEventListener(Event.ENTER_FRAME, Dragging);
			
			//stop the timer
			dragDelay.removeEventListener(TimerEvent.TIMER, Delay);
			dragDelay.stop();
			dragDelay.reset();
			
			trace("start drag");
			
			//disable the items while dragging
			for each(var item in items)
			{
				item.mouseEnabled = false;
			}
		}
		
		private function bar_TouchMove(event:TouchEvent):void
		{
			//start dragging the item bar, ccan only be dragged on the x axis, between -413.25 and 0)
			itemBar.startTouchDrag(event.touchPointID, false, fl_DragBounds);
		}

		private function bar_TouchEndHandler(event:TouchEvent):void
		{
			//check if dragging has started by checking the timer
			if (dragDelay.running == false)
			{
				trace("end drag");
				
				itemBar.removeEventListener(TouchEvent.TOUCH_MOVE, bar_TouchMove);
				
				//stop dragging the bar
				itemBar.stopTouchDrag(event.touchPointID);
				
				//stop looking at the bar position
				removeEventListener(Event.ENTER_FRAME, Dragging);
				
				//set the velocity using the previous position and current position
				vel = itemBar.x - oldFrame;
				trace(vel);
				
				//start updating the velocity
				addEventListener(Event.ENTER_FRAME, doVelocity)
				
				//re-enable items
				for each(var item in items)
				{
					item.mouseEnabled = true;
				}
			}
			
			else
			{
				//stop the timer
				dragDelay.removeEventListener(TimerEvent.TIMER, Delay);
				dragDelay.stop();
			}

			//stop looking for drag end
			removeEventListener(TouchEvent.TOUCH_END, bar_TouchEndHandler);	
		}
		
		private function Dragging(event:Event):void
		{
			//get the current frame of the bar
			oldFrame = itemBar.x;
		}
		
		private function doVelocity(event:Event):void
		{
			//check if velocity is less than 1
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
		
		//------------ Functions for when you touch an item on the bar, add your code here. Use removeItem(event.target) when you want to remove the item from the bar --------------------
		//_________________________________________________________________________________________________________________________________________________________________________
		
		private function useBeer(event:TouchEvent):void
		{
			//code goes here
			trace("used Beer");
			
			removeItem(event.target);
		}
		
		private function useHookshot(event:TouchEvent):void
		{
			//code goes here
			trace("used Hookshot");
			
			removeItem(event.target);
		}	
		
		private function useHammer(event:TouchEvent):void
		{
			//code goes here
			trace("used Hammer");
			
			removeItem(event.target);
		}	
		
		private function useLightning(event:TouchEvent):void
		{
			//code goes here
			trace("used Lightning Staff");
			
			removeItem(event.target);
		}
		
		private function useFire(event:TouchEvent):void
		{
			//code goes here
			trace("used Fire Staff");
			
			removeItem(event.target);
		}	
		
		private function useDagger(event:TouchEvent):void
		{
			//code goes here
			trace("used Dagger");
			
			removeItem(event.target);
		}	
		
		private function removeItem(itemRemoved):void
		{
			for(var i:int = 0; i < items.length; i++)
			{
				//find the item that needs to be removed
				if(items[i] == itemRemoved)
				{
					//remove it from the item bar and the array
					itemBar.removeChild(items[i]);
					items.splice(i, 1);
					i = items.length;
				}
			}
			
			for(var j:int = 0; j < items.length; j++)
			{
				//reposition each of the items
				items[j].x = itemSlots[j].x;
			}
		}
	}
}
