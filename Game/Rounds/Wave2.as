package Game.Rounds
{
	import flinjin.graphics.FjSpriteText;
	import Game.GameMainScenario;
	import Game.HUD.instructions.FireballInstruction;
	import Game.HUD.instructions.TankShotLine;
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
			
			_nextRound = Wave3;
			
			for (var i:int = 0; i < 5; i++)
			{
				addEvent(i * 750, Tank);
			}
			
			if (GameMainScenario.helpEnabled)
			{
				addEvent(2000, null, new TankShotLine(this));
				addEvent(2100, null, new FireballInstruction(this));
			}
		}
	}

}