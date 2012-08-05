package
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	import flinjin.FjLog;
	import flinjin.FjPreloader;
	import flinjin.Flinjin;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Preloader extends FjPreloader
	{
		//private var _applicationClass:String = "Main";
		
		[Embed(source="_assets/bmp/loader/loader back.jpg")]
		private static var _bgBitmap:Class;
		
		[Embed(source="_assets/bmp/loader/loader_sun.png")]
		private static var _bgSunFace:Class;
		
		[Embed(source="_assets/bmp/loader/loader_sun_crona.png")]
		private static var _sunCoronaBitmap:Class;
		
		private var _sunCorona:Bitmap = new _sunCoronaBitmap() as Bitmap;
		private var _mcCorona:Sprite = new Sprite();
		
		//private var _progressBar:PreloaderProgressBar;
		
		public function Preloader()
		{
			/*if (stage)
			   {
			   stage.scaleMode = StageScaleMode.NO_SCALE;
			   stage.align = StageAlign.TOP_LEFT;
			
			   addChild(new _bgBitmap());
			
			   var sunFace:Bitmap = new _bgSunFace();
			   sunFace.x = width / 2 - sunFace.width / 2;
			   sunFace.y = height / 2 - sunFace.height / 2;
			   addChild(sunFace);
			
			   _sunCorona.x = -_sunCorona.width / 2;
			   _sunCorona.y = -_sunCorona.height / 2;
			   _mcCorona.addChild(_sunCorona);
			
			   _mcCorona.x = width / 2;
			   _mcCorona.y = height / 2;
			   addChild(_mcCorona);
			
			   _progressBar = new PreloaderProgressBar(856, 15);
			   _progressBar.x = 88;
			   _progressBar.y = 491;
			   addChild(_progressBar);
			 } */
			
			if (Main.CONTENT_WIDTH == Main.SCENE_WIDTH)
				Flinjin.applicationName = "Evil Sun HD";
			else
				Flinjin.applicationName = "Evil Sun";
			
			applicationClass = "Main";
		
		/*addEventListener(Event.ENTER_FRAME, checkFrame);
		   loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		 loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);*/
		}
	
	}

} /*
   import flash.display.MovieClip;

   class PreloaderProgressBar extends MovieClip
   {
   private var _progress:uint;
   private var _maxWidth:Number;
   private var _barHeight:Number;

   function PreloaderProgressBar(maxWidth:Number, barHeight:Number = 16)
   {
   super();
   _maxWidth = maxWidth;
   _barHeight = barHeight;

   graphics.clear();
   graphics.beginFill(0x000000);
   graphics.drawRect(0, 0, _maxWidth, _barHeight);
   graphics.endFill();
   }

   public function get progress():uint
   {
   return _progress;
   }

   public function set progress(value:uint):void
   {
   _progress = value;

   graphics.clear();
   graphics.beginFill(0xffffff);
   graphics.drawRect(0, 0, _maxWidth * (100 / _progress), _barHeight);
   graphics.endFill();
   }
 }*/