package Game.Rounds
{
	import flinjin.graphics.FjSpriteText;
	import Game.Mobs.Tank;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Wave2 extends GameRound
	{
		private var _hintText:FjSpriteText;
		private var _hint:Boolean = false;
		
		private var _hintState:Number = 0;
		private var _hintStateTime:Number = 0;
		private var _done:Boolean = false;
		private var _doneTime:Number;
		
		public function Wave2()
		{
			super();
			
			_roundName = "Wave 2: Tank Attack";
			_nextRound = Wave3;
			
			for (var i:int = 0; i < 5; i++)
			{
				addMobEvent(i * 750, new Tank());
			}
		}
	}

}