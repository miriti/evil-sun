package Game.HUD
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class AreYouSureDialog extends FjLayer
	{
		[Embed(source="../../_assets/bmp/hud/dialog/back.png")]
		private static var _backBmp:Class;
		private var _back:FjSprite = new FjSprite(new _backBmp());
		
		[Embed(source="../../_assets/bmp/hud/dialog/yes-88x59.png")]
		private static var _bmpYes:Class;
		private var _btnYes:Button = new Button(new _bmpYes(), null, new Point(88, 59)).setCenter() as Button;
		
		[Embed(source="../../_assets/bmp/hud/dialog/no-74x58.png")]
		private static var _bmpNo:Class;
		private var _btnNo:Button = new Button(new _bmpNo(), null, new Point(74, 58)).setCenter() as Button;
		
		public var noCallBack:Function = null;
		public var yesCallback:Function = null;
		
		public function AreYouSureDialog()
		{
			super(_back.width, _back.height);
			addSprite(_back);
			addSprite(_btnYes, 140, 120);
			addSprite(_btnNo, 250, 120);
			
			_btnYes.addEventListener(MouseEvent.MOUSE_DOWN, onYes);
			_btnNo.addEventListener(MouseEvent.MOUSE_DOWN, onNo);
			
			interactive = true;
		}
		
		private function onYes(e:MouseEvent):void
		{
			if (yesCallback != null)
				yesCallback.call();
		}
		
		private function onNo(e:MouseEvent):void
		{
			Delete();
			if (noCallBack != null)
				noCallBack.call();
		}
	
	}

}