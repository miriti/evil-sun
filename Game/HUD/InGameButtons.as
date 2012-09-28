package Game.HUD
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flinjin.graphics.FjLayer;
	import flinjin.sound.FjSnd;
	import Game.GameMain;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class InGameButtons extends FjLayer
	{
		[Embed(source="../../_assets/bmp/hud/ingame/pause-67x67.png")]
		private static var _bitmapPause:Class;
		
		[Embed(source="../../_assets/bmp/hud/ingame/unpause-69x63.png")]
		private static var _bitmapUnPause:Class;
		
		[Embed(source="../../_assets/bmp/hud/ingame/unmute-70x59.png")]
		private static var _bitmapMute:Class;
		
		[Embed(source="../../_assets/bmp/hud/ingame/mute-75x59.png")]
		private static var _bitmapUnMute:Class;
		
		private var _buttonPause:Button = new Button(new _bitmapPause(), null, new Point(67, 67));		
		private var _buttonUnPause:Button = new Button(new _bitmapUnPause(), null, new Point(69, 63));
		
		private var _buttonMute:Button = new Button(new _bitmapMute(), null, new Point(70, 59));
		private var _buttonUnMute:Button = new Button(new _bitmapUnMute(), null, new Point(75, 59));
		
		public function InGameButtons()
		{
			super(140, 80);
			interactive = true;
			
			_buttonPause.addEventListener(MouseEvent.MOUSE_DOWN, onPauseButton);
			_buttonUnPause.addEventListener(MouseEvent.MOUSE_DOWN, onUnPauseButton);
			
			_buttonMute.addEventListener(MouseEvent.MOUSE_DOWN, onMuteButton);
			_buttonUnMute.addEventListener(MouseEvent.MOUSE_DOWN, onUnMuteButton);
			
			addSprite(_buttonPause, 0, 0);
			addSprite(_buttonMute, 65, 5);
			addSprite(_buttonUnPause, 0, 0);
			addSprite(_buttonUnMute, 64, 5);
			
			_buttonUnPause.visible = false;
			_buttonUnMute.visible = false;
		}
		
		private function onUnMuteButton(e:MouseEvent):void
		{
			FjSnd.enabled = true;
			if (MusicButton.musicEnabled)
				Main.Music.play();
			_buttonUnMute.visible = false;
			_buttonMute.visible = true;
		}
		
		private function onMuteButton(e:MouseEvent):void
		{
			FjSnd.enabled = false;
			_buttonMute.visible = false;
			_buttonUnMute.visible = true;
		}
		
		private function onUnPauseButton(e:MouseEvent):void
		{
			GameMain.Instance.pause = false;
			_buttonUnPause.visible = false;
			_buttonPause.visible = true;
		}
		
		private function onPauseButton(e:MouseEvent):void
		{
			GameMain.Instance.pause = true;
			_buttonPause.visible = false;
			_buttonUnPause.visible = true;
		}
	
	}

}