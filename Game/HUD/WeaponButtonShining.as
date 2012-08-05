package Game.HUD
{
	import flash.geom.Point;
	import flinjin.events.FlinjinSpriteEvent;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class WeaponButtonShining extends FjSprite
	{
		
		[Embed(source="../../_assets/bmp/hud/shining-92x87.png")]
		private static var _shiningBitmap:Class;
		
		public function WeaponButtonShining()
		{
			super(new _shiningBitmap(), null, new Point(92, 87), new FjSpriteAnimation("shine", null, 20, false, 1));
			addEventListener(FlinjinSpriteEvent.ANIMATION_FINISHED, onAnimFinished);
		}
		
		private function onAnimFinished(e:FlinjinSpriteEvent):void 
		{
			visible = false;
		}
		
		override public function get visible():Boolean
		{
			return super.visible;
		}
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			
			if (value)
			{
				currentFrame = 0;
				animation.play();
			}
		}
	
	}

}