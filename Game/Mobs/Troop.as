package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.types.BoundingRect;
	import Game.Balance;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Troop extends Mob
	{
		[Embed(source="../../_assets/bmp/mobs/troop/troop-anim-28x50.png")]
		protected var _troopAnim:Class;
		
		protected var _anim:FjSprite = new FjSprite(new _troopAnim(), null, new Point(28, 50), new FjSpriteAnimation("moving", null, 100, true));
		protected var _minX:Number = 0
		protected var _dead:Boolean = false;
		
		public function Troop()
		{
			super(_anim.width, _anim.height);
			addSprite(_anim);			
			
			initMob();
		}
		
		override protected function initMob():void
		{
			super.initMob();
			_healthPointsMax = Balance.troopHealth;
			_healthPoints = Balance.troopHealth;
			_score = Balance.troopScore;
			_speed = Balance.troopSpeed;
			_explosionDamage = Balance.troopDamage;
		}
	}
}