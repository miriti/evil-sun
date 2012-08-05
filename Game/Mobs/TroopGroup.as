package Game.Mobs
{
	import flash.geom.Point;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import Game.Balance;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TroopGroup extends Mob
	{
		[Embed(source="../../_assets/bmp/mobs/troopGroup/troop-group-anim-71x84.png")]
		static private var _animBitmap:Class;
		private var _animSprtie:FjSprite = new FjSprite(new _animBitmap(), null, new Point(71, 84), new FjSpriteAnimation("walk", null, 25, true));
		
		public function TroopGroup()
		{
			super(_animSprtie.width, _animSprtie.height);
			addSprite(_animSprtie);
			_healthPoints = Balance.troopGroupHealth;
			_healthPointsMax = Balance.troopGroupHealth;
			_speed = Balance.troopGroupSpeed;
			_score = Balance.troopGroupScore;
			_explosionDamage = Balance.troopGroupExplosionDamage;
		}
	}

}