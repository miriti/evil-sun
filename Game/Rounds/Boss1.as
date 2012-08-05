package Game.Rounds
{
	import flinjin.Flinjin;
	import flinjin.graphics.Sprite;
	import Game.GameMain;
	import Game.Mobs.TroopBoss;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Boss1 extends GameRound
	{
		private var _boss:TroopBoss = new TroopBoss();
		
		[Embed(source="../../_assets/bmp/hud/help/keyboard.png")]
		private static var _hintBitmap:Class;
		
		private var _hintSprite:Sprite = new Sprite(new _hintBitmap());
		private var _hint:Boolean = true;
		
		public function Boss1()
		{
			_roundName = "BOSS!!";
			_nextRound = Wave5;
			
			GameMain.Instance.sun.weaponShotgun.recovery = 0;
			GameMain.Instance.sun.weaponFireball.recovery = 0;
			GameMain.Instance.sun.weaponApocalypce.recovery = 0;
			
			addMobEvent(0, new TroopBoss());
			
			GameMain.Instance.addSprite(_hintSprite, GameMain.Instance.factory.width, GameMain.groundLevel - _hintSprite.height, 48);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if ((_timeTotal >= 6000) && (_hint))
			{
				_hint = false;
				_hintSprite.Delete();
			}
		}
	
	}

}