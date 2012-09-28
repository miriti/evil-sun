package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.graphics.FjSprite;
	import flinjin.types.BoundingRect;
	import Game.Balance;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Paratrooper extends Mob
	{
		static public const SWING:Number = Math.PI / 32;
		[Embed(source="../../_assets/bmp/mobs/paratrooper/drop-103x126.png")]
		private static var _paratroopBitmap:Class;
		
		private var _paratrooperSprite:FjSprite = new FjSprite(new _paratroopBitmap());
		private var _phase:Number = 0;
		
		public function Paratrooper()
		{
			super(_paratrooperSprite.width, _paratrooperSprite.height);
			addSprite(_paratrooperSprite);
			setCenter(51.5, 15);
			addEventListener(FlinjinSpriteEvent.ADDED_TO_LAYER, onAdded);
			_hitTheFactory = false;
			
			initMob();
		}
		
		override protected function initMob():void
		{
			super.initMob();
			_healthPoints = Balance.paratrooperHealth;
			_healthPointsMax = Balance.paratrooperHealth;
			_score = Balance.paratrooperScore;
		}
		
		private function onAdded(e:FlinjinSpriteEvent):void
		{
			x = width;
			y = -height;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			y += s(deltaTime) * 30;
			angle = Math.sin(_phase) * SWING;
			_phase += (deltaTime / 1000) * 1.5;
			
			if (y >= 300)
			{
				die();
				GameMain.Instance.factory.Hit(Balance.paratrooperDamage, Paratrooper);
			}
		}
	
	}

}