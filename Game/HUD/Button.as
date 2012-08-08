package Game.HUD
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	import flinjin.graphics.FjSpriteAnimation;
	import flinjin.FjInput;
	import flinjin.sound.FjSnd;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Button extends FjSprite
	{
		private var _activeFrame:Number = 1;
		private var _inactiveFrame:Number = 0;
		private var _hintLayer:FjLayer;
		private var _hint:ButtonHint;
		private var _mouseDown:Boolean = false;
		
		public function Button(spriteBmp:Bitmap, rotationCenter:Point = null, frameSize:Point = null, spriteAnimation:FjSpriteAnimation = null)
		{
			super(spriteBmp, rotationCenter, frameSize, spriteAnimation);
			interactive = true;
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override public function mouseOver(localX:Number, localY:Number):void
		{
			var _m:Boolean = _mouseOver;
			super.mouseOver(localX, localY);
			
			if (!_m && _mouseOver)
				FjSnd.playSound('menu-hover');
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			_mouseDown = false;
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			_mouseDown = true;
			FjSnd.playSound('menu-click');
		}
		
		override public function Move(deltaTime:Number):void
		{
			super.Move(deltaTime);
			
			if (_mouseOver)
			{
				if (!_mouseDown)
				{
					currentFrame = _activeFrame;					
				}
				else
				{
					currentFrame = _inactiveFrame;
				}
				
				if (_hint != null)
				{
					if (!_hint.visible)
						_hint.visible = true;
				}
			}
			else
			{
				currentFrame = _inactiveFrame;
				if (_hint != null)
				{
					if (_hint.visible)
						_hint.visible = false;
				}
			}
		}
		
		public function get activeFrame():Number
		{
			return _activeFrame;
		}
		
		public function set activeFrame(value:Number):void
		{
			_activeFrame = value;
		}
		
		public function get inactiveFrame():Number
		{
			return _inactiveFrame;
		}
		
		public function set inactiveFrame(value:Number):void
		{
			_inactiveFrame = value;
		}
		
		public function get hint():ButtonHint
		{
			return _hint;
		}
		
		public function set hint(value:ButtonHint):void
		{
			var l:FjLayer = _hintLayer == null ? parent : _hintLayer;
			l.addSprite(value, x, y);
			_hint = value;
		}
		
		public function get hintLayer():FjLayer
		{
			return _hintLayer;
		}
		
		public function set hintLayer(value:FjLayer):void
		{
			_hintLayer = value;
		}
	}

}