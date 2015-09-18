package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 
	 * @author Yuxin
	 * 
	 */
	public class AirQuadrilateralIntersect extends Sprite
	{
		public function AirQuadrilateralIntersect()
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addToStage)
		}
		private var pp1:YPoint = new YPoint();
		private var pp2:YPoint = new YPoint();
		private var pp3:YPoint = new YPoint();
		private var pp4:YPoint = new YPoint();
		private var pp5:YPoint = new YPoint();
		private function addToStage(e:Event):void
		{
			pp1.inits(0xFF0000,1);
			pp2.inits(0x00FF00,2);
			pp3.inits(0x0000FF,3);
			pp4.inits(0xFFFF00,4);
			pp5.inits(0x000000,5);
			for (var i:int = 1; i < 6; i++) 
			{
				this["pp"+i].x = Math.random()*200;
				this["pp"+i].y = Math.random()*200;
				this["pp"+i].name = "pp"+i;
				this.addChild(this["pp"+i])
				this["pp"+i].addEventListener(MouseEvent.MOUSE_DOWN,btnMouseDown);
			}
		}
		private function btnMouseDown(e:MouseEvent):void
		{
			e.currentTarget.addEventListener(MouseEvent.MOUSE_UP,btnMouseUp);
			e.currentTarget.startDrag();
		}
		private function btnMouseUp(e:MouseEvent):void
		{
			e.currentTarget.stopDrag();
			//trace(getQuadrilateralArea(pp1,pp2,pp3,pp4));
			//trace(getPointToQuadrilateralArea(pp1,pp2,pp3,pp4,pp5));
			if(getQuadrilateralArea(pp1,pp2,pp3,pp4) == getPointToQuadrilateralArea(pp1,pp2,pp3,pp4,pp5)){
				trace("pp5 在 pp1,pp2,pp3,pp4的矩形内-----------------------")
			}else{
				trace("pp5 不在 pp1,pp2,pp3,pp4的矩形内")
			}
			if(judge(pp1,pp3,pp2,pp4)){
				trace("pp1-pp3,与pp2-pp4 -相交------------")
			}else{
				trace("pp1-pp3,与pp2-pp4 -不相交")
			}
		}
		private function getPointToQuadrilateralArea(p1:YPoint,p2:YPoint,p3:YPoint,p4:YPoint,p5:YPoint):int
		{
			var triangleA:Number = getTriangleArea(p1,p2,p5);
			var triangleB:Number = getTriangleArea(p2,p3,p5);
			var triangleC:Number = getTriangleArea(p3,p4,p5);
			var triangleD:Number = getTriangleArea(p1,p4,p5);
			return int(triangleA+triangleB+triangleC+triangleD);
		}
		private function getQuadrilateralArea(p1:YPoint,p2:YPoint,p3:YPoint,p4:YPoint):int
		{
			var triangleA:Number = getTriangleArea(p1,p2,p3);
			var triangleB:Number = getTriangleArea(p1,p4,p3);
			return int(triangleA+triangleB);
		}
		private function getTriangleArea(p1:YPoint,p2:YPoint,p3:YPoint):Number
		{
			var aa:Number = getPointDistence(p1,p2);
			var bb:Number = getPointDistence(p2,p3);
			var cc:Number = getPointDistence(p1,p3);
			var s:Number = (aa+bb+cc)/2;
			return Math.sqrt(s*(s-aa)*(s-bb)*(s-cc));
		}
		private function getPointDistence(p1:YPoint,p2:YPoint):Number
		{
			return Math.sqrt((p2.x-p1.x)*(p2.x-p1.x)+ ((p2.y-p1.y)*(p2.y-p1.y)));
		}
		
		//判断两条线是否相交
		private function onsegment(pi:YPoint,pj:YPoint,pk:YPoint):Boolean //判断点pk是否在线段pi pj上   
		{  
			if(Math.min(pi.x,pj.x)<=pk.x && pk.x<=Math.max(pi.x,pj.x))  
			{  
				if(Math.min(pi.y,pj.y)<=pk.y && pk.y<=Math.max(pi.y,pj.y))  
				{  
					return true;  
				}  
			}  
			return false;  
		}  
		private function direction(pi:YPoint,pj:YPoint,pk:YPoint):Number //计算向量pkpi和向量pjpi的叉积   
		{  
			return (pi.x-pk.x)*(pi.y-pj.y)-(pi.y-pk.y)*(pi.x-pj.x);  
		}  
		private function judge(p1:YPoint,p2:YPoint,p3:YPoint,p4:YPoint):Boolean //判断线段p1p2和p3p4是否相交   
		{  
			var d1:Number = direction(p3,p4,p1);  
			var d2:Number = direction(p3,p4,p2);  
			var d3:Number = direction(p1,p2,p3);  
			var d4:Number = direction(p1,p2,p4);  
			if(d1*d2<0 && d3*d4<0)  
				return true;  
			if(d1==0 && onsegment(p3,p4,p1))  
				return true;  
			if(d2==0 && onsegment(p3,p4,p2))  
				return true;  
			if(d3==0 && onsegment(p1,p2,p3))  
				return true;  
			if(d4==0 && onsegment(p1,p2,p4))  
				return true;  
			return false;  
		} 
		
	}
}