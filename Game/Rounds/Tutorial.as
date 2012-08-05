package Game.Rounds
{
	import flinjin.Flinjin;
	import flinjin.graphics.SpriteText;
	import Game.GameMain;
	import mochi.as3.*;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Tutorial extends GameRound
	{
		private var _factoryInfo:SpriteText;
		private var _controlsInfo:SpriteText;
		private var _tutorialStep:Number = 0;
		
		public function Tutorial()
		{
			super();
			_roundName = "Ok, here is the deal";
			_factoryInfo = new SpriteText("<- Protect this Gas Factory\nfrom ecologists attacks as long as it's possible", _textFormat, true);
			_controlsInfo = new SpriteText("Use mouse to aim your attack.\nPress and hold left mouse button\nto increse power.\nRelease left mouse button to fire", _textFormat, true);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if ((_tutorialStep == 0) && (_timeTotal >= 3500))
			{
				_tutorialStep = 1;
				GameMain.Instance.addSprite(_factoryInfo, 200, 200, 48);
			}
			
			if ((_tutorialStep == 1) && (_timeTotal >= 7500))
			{
				_tutorialStep = 2;
				_factoryInfo.Delete();
				GameMain.Instance.addSprite(_controlsInfo, (Main.CONTENT_WIDTH - _controlsInfo.width) / 2, 200, 48);
			}
			
			if ((_tutorialStep == 2) && (_timeTotal >= 13000))
			{
				_tutorialStep = 3;
				_controlsInfo.Delete();
				GameMain.Instance.scenario.startRound(new Wave0());
			}
		}
	}

}