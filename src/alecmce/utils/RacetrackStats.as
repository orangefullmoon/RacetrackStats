package alecmce.utils 
{
	import alecmce.stats.ui.iterativegraph.IterativeCompoundGraphWithRollingMeans;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.getTimer;

	/**
	 * Creates a graph of the amount of processing time the Flash Player is taking
	 * to complete each portion of its cycle. 
	 * 
	 * The stats are collected into an array of data, which is passed into the
	 * graph every frame. The data collected is [enter-frame,pre-render,render]. They
	 * are colour coded, by default to the following colors:
	 * 
	 * enter-frame: green
	 * pre-render: blue
	 * render: red
	 * 
	 * @author Alec McEachran
	 * 
	 * (c) 2010 alecmce.com
	 * 
	 * Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
	 */
	public class RacetrackStats 
	{
		private const COUNT:int = 10;
		
		private var stage:Stage;
		
		private var container:DisplayObjectContainer;
		
		private var data:Array;
		private var graph:IterativeCompoundGraphWithRollingMeans;
//		private var drawing:IterativeGraphWithRollingMean;
//		private var code:IterativeGraphWithRollingMean;
//		private var renders:IterativeGraphWithRollingMean;
//		private var framerate:IterativeGraphWithRollingMean;

		private var time:int;
		private var frame:int;

		public function RacetrackStats(stage:Stage)
		{
			this.stage = stage;
			
			container = new Sprite();
			
			data = [0,0,0];
			
			var barColors:Array = [0x6600FF00,0x661E90FF,0x66FF0000];
			
			graph = new IterativeCompoundGraphWithRollingMeans(100, 60, 50, barColors, meanColors, 20);
			graph.bitmap.x = 400;
//			code = new IterativeGraphWithRollingMean(100,60,50,0x6600FF00,0xFF00FF00,20);
//			renders.bitmap.x = 100;
//			drawing.bitmap.x = 200;
//			framerate.bitmap.x = 300;
			
			container.addChild(graph.bitmap);
			
			stage.addChild(container);
			
			frame = time = getTimer();
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, int.MAX_VALUE);
		}

		private function onEnterFrame(event:Event):void
		{
			data[2] = getTimer() - time;
			graph.update(data);
			frame = time = getTimer();
			stage.invalidate();
		}
		
		private function onRenderBegins(event:Event):void
		{
			var t:int = getTimer();
			time = t;
		}
		
		private function onRenderEnds(event:Event):void 
		{
			var t:int = getTimer();
			data[1] = t - time;
			time = t;
		}
	}
}