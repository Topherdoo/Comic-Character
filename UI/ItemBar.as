package  
{
	
	import flash.display.MovieClip;
	
	
	public class ItemBar extends MovieClip 
	{
		private var lButton = new LButton();
		private var rButton = new RButton();
		private var itemBar = new ItemBarMC();
		
		public function ItemBar() 
		{
			rButton.x = stage.stageWidth;
			itemBar.x = 12;
			addChild(itemBar);
			addChild(lButton);
			addChild(rButton);
		}
	}
	
}
