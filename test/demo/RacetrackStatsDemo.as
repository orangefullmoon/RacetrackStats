package demo 
{
	import alecmce.profiling.RacetrackStats;

	import flash.display.Sprite;

	public class RacetrackStatsDemo extends Sprite 
	{
		public function RacetrackStatsDemo()
		{
			RacetrackStats.prep();
			new RacetrackStats(stage);
			
			var item:DemoItem;
			
			addChild(item = new DemoItem(Smoke));
			item.x = 0;
			item.y = 50;
			
			item.x = 220;
			item.y = 50;
			
			item.x = 440;
			item.y = 50;
		}
	}
}

import demo.Demo;

import com.bit101.components.PushButton;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.MouseEvent;

internal class DemoItem extends Sprite
{
	private var item:Demo;
	
	public function DemoItem(demoClass:Class)
	{
		item = new demoClass(200, 300);
		addChild(DisplayObject(item));
			
		var start:PushButton = new PushButton(this);
		start.addEventListener(MouseEvent.CLICK, onStart);
		start.width = 150;
		start.x = 25;
		start.y = 320;
		
		var stop:PushButton = new PushButton(this);
		stop.addEventListener(MouseEvent.CLICK, onStop);
		stop.width = 150;
		stop.y = 360;
		
		var reset:PushButton = new PushButton(this);
		reset.addEventListener(MouseEvent.CLICK, onReset);
		reset.label = "reset";
		reset.width = 150;
		reset.height = 30;
		reset.x = 25;
		reset.y = 400;
	}

	private function onStart(event:MouseEvent):void 
	{
		item.start();
	}
	
	private function onStop(event:MouseEvent):void 
	{
		item.stop();
	}

	private function onReset(event:MouseEvent):void 
	{
		item.reset();
	}
}