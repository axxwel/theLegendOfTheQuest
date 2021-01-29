package{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class VoileNoir extends MovieClip{
		
		public var monVoile1:Voile=new Voile();
		public var monVoile2:Voile=new Voile();
		public var monVoile3:Voile=new Voile();
		public var conteneur:MovieClip=new MovieClip();
		public var voileVisible:Boolean=true;
		public var ouvrirAutorise:Boolean=true;
		public var image:int=0;
		public var sens:int=0;
		
		
		public function VoileNoir(){
			addChild(conteneur);
			
			conteneur.addChild(monVoile1);
			conteneur.addChild(monVoile2);
			conteneur.addChild(monVoile3);
		}
		public function afficher(){
			if (voileVisible==true){
				if((image<1)||(image>60)||(ouvrirAutorise==false)){
					monVoile1.stop();
				}else{
					if((image>=2)&&(image<=59)){
						image+=sens;
						monVoile1.gotoAndStop(image);
						monVoile2.gotoAndStop(image-3);
						monVoile3.gotoAndStop(image-6);
						if(image>36){monVoile2.alpha-=(1/20)*sens;monVoile3.alpha-=(1/20)*sens;}
					}
					if(image==58&&sens==1){conteneur.removeChild(monVoile1);conteneur.removeChild(monVoile2);conteneur.removeChild(monVoile3);}
					if(image==57&&sens==-1){conteneur.addChild(monVoile1);conteneur.addChild(monVoile2);conteneur.addChild(monVoile3);}
				}
			}else{
				if((image>=2)&&(image<=59)){
					image+=sens;
				}
				if((image<1)||(image>60)){
					monVoile1.stop();
				}
				if(image==58&&sens==1&&conteneur.numChildren>0){conteneur.removeChild(monVoile1);conteneur.removeChild(monVoile2);conteneur.removeChild(monVoile3);}
			}
		}
		public function fermer(){sens=-1;image=58;}
		public function ouvrir(){sens=1;image=29;monVoile2.alpha=1;monVoile3.alpha=1;}
		
	}
}