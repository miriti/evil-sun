package
{
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flinjin.algorithms.camera.Dissolve;
	import flinjin.Flinjin;
	import flinjin.graphics.FjLayer;
	import flinjin.graphics.FjSpriteText;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class CreditsScreen extends FjLayer
	{
		private var _format:TextFormat = new TextFormat("gameFont", 40, 0x888888);
		private var _titles:Vector.<FjSpriteText> = new Vector.<FjSpriteText>();
		
		public function CreditsScreen()
		{
			super(Main.CONTENT_WIDTH, Main.CONTENT_HEIGHT);
			
			_titles.push(new FjSpriteText("Game by:", _format));
			_titles.push(new FjSpriteText("Dmitry Gorbachev - art", _format));
			_titles.push(new FjSpriteText("Michael Miriti - code", _format));
			_titles.push(new FjSpriteText("Philip Situmorang - music", _format));
			_titles.push(new FjSpriteText(" ", _format));
			_titles.push(new FjSpriteText("MMXII", _format));
			
			for (var i:int = 0; i < _titles.length; i++)
			{
				addSprite(_titles[i], (width - _titles[i].width) / 2, (height - _titles.length * 60) / 2 + i * 60);
			}
			
			interactive = true;
			
			addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent):void
				{
					Flinjin.Instance.Camera.LookBack();
				});
		}
	
	}

}