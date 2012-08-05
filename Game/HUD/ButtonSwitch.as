package Game.HUD
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flinjin.graphics.FjSpriteAnimation;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class ButtonSwitch extends Button
	{
		private var _inactiveFrame2:Number = 2;
		
		private var _lastState:Number = 0;
		
		private var _state:Boolean = true;
		
		public function ButtonSwitch(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null)
		{
			super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			hitSwitch();
		}
		
		public function get inactiveFrame2():Number
		{
			return _inactiveFrame2;
		}
		
		public function set inactiveFrame2(value:Number):void
		{
			_inactiveFrame2 = value;
		}
		
		public function get state():Boolean
		{
			return _state;
		}
		
		public function set state(value:Boolean):void
		{
			_state = value;
		}
		
		public function hitSwitch():void
		{
			var t:Number = inactiveFrame;
			inactiveFrame = _inactiveFrame2;
			inactiveFrame2 = t;
			state = !state;
		}
	
	}

}