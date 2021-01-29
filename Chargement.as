package{
	
	import flash.display.*;
	import flash.system.*;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.*;
	
	public class Chargement extends MovieClip {
		
		public var donneesLieux:XML=new XML();
		public var donneesListePNJ:XML=new XML();
		public var donneesCine:XML=new XML();
		
		public var cartesLieux:Array=new Array();
		
		public var chargementLieux:Boolean=false;
		public var chargementListePNJ:Boolean=false;
		public var chargementCine:Boolean=false;
		public var chargementVideo:Boolean=false;

		
		public var tabChargementCarteTermine:Array=new Array();
		
		public var dossier:String="Jour";
		
		public function Chargement(pDossier:String="Jour"){
			dossier=pDossier
			
			chargerLieux();
			chargerListePNJ();
			chargerCine();
			chargerVideo();
		}
		public function chargementTotalTermine(){
			if(chargementLieux==true&&
				chargementListePNJ==true&&
				chargementCine==true&&
				chargementVideo==true){
				stage.dispatchEvent(new Event("chargementTotalTermine"));
			}
		}
		public function chargementTotalCarteTermine(){
			var chargementFin:Boolean=true;
			for(var n:int=0;n<tabChargementCarteTermine.length;n++){
				for(var i:int=0;i<tabChargementCarteTermine[n].length;i++){
					if(tabChargementCarteTermine[n][i]==false){chargementFin=false;}
				}
			}
			if( chargementFin==true){
				stage.dispatchEvent(new Event("chargementTotalCarteTermine"));
			}			
		}
		public function chargerCartes(nomCarteLieux:Array){
			for(var n:int=0;n<nomCarteLieux.length;n++){
				var nom:Array=new Array();
				nom[0]=dossier;
				nom[1]=nomCarteLieux[n];
				cartesLieux.push([nom,[[],[],[],[],[]]]);
				tabChargementCarteTermine[n]=passerTabFalse(n);
				chargerCarte(n,nomCarteLieux[n],"N0");
				chargerCarte(n,nomCarteLieux[n],"N1");
				chargerCarte(n,nomCarteLieux[n],"N2");
				chargerCarte(n,nomCarteLieux[n],"N3");
				chargerCarte(n,nomCarteLieux[n],"Monstres");
				chargerCarte(n,nomCarteLieux[n],"Items");
			}
			
			function passerTabFalse(n:int=0):Array{
				var tabTemp:Array=new Array();
				for(var f:int=0;f<6;f++){
					 tabTemp[f]=false;
				}
				return(tabTemp);
			}
		}
//LIEUX=====================================================================================================
		private function chargerLieux():void{
			var chargeur= new URLLoader();
			chargeur.dataFormat=URLLoaderDataFormat.TEXT;
			chargeur.addEventListener(Event.COMPLETE,chargementTermine);
			chargeur.addEventListener(IOErrorEvent.IO_ERROR,erreurChargement);
			chargeur.load(new URLRequest("CarteDecor"+dossier+"/porteLieux.xml"));
			
			function chargementTermine(evt:Event):void{
				var donneesXML=new XML(evt.currentTarget.data);
				donneesLieux=donneesXML;
				chargementLieux=true;
				chargementTotalTermine();
			}
			function erreurChargement(pEvent:IOErrorEvent):void{
				trace("erreur de chargement de lieux");
			}
		}
//LISTE PNJ=======================================================================================================
		private function chargerListePNJ():void{
			var chargeur= new URLLoader();
			chargeur.dataFormat=URLLoaderDataFormat.TEXT;
			chargeur.addEventListener(Event.COMPLETE,chargementTerminee);
			chargeur.addEventListener(IOErrorEvent.IO_ERROR,erreurChargement);
			chargeur.load(new URLRequest("CarteDecor"+dossier+"/listePNJ.xml"));
			
			function chargementTerminee(evt:Event):void{
				
				var donneesXML=new XML(evt.currentTarget.data);
				donneesListePNJ=donneesXML;
				chargementListePNJ=true;
				chargementTotalTermine();
			}
			function erreurChargement(pEvent:IOErrorEvent):void{
				trace("erreur de chargement de listePNJ");
			}
		}
//CINE=======================================================================================================
		private function chargerCine():void{
			var chargeur= new URLLoader();
			chargeur.dataFormat=URLLoaderDataFormat.TEXT;
			chargeur.addEventListener(Event.COMPLETE,chargementTermine);
			chargeur.addEventListener(IOErrorEvent.IO_ERROR,erreurChargement);
			chargeur.load(new URLRequest("CarteDecor"+dossier+"/cineControl.xml"));
			
			function chargementTermine(evt:Event):void{
				var donneesXML=new XML(evt.currentTarget.data);
				donneesCine=donneesXML;
				chargementCine=true;
				chargementTotalTermine();
			}
			function erreurChargement(pEvent:IOErrorEvent):void{
				trace("erreur de chargement de Cine");
			}
		}
//CARTES==================================================================================================
		public function chargerCarte(n:int,nomLieux:String,idCarte:String):void{
			var tableau:Array=new Array();
			var cartetemp:Array=new Array();
			var conteneur:URLLoader= new URLLoader();
			conteneur.dataFormat= URLLoaderDataFormat.VARIABLES;
			conteneur.load(new URLRequest("CarteDecor"+dossier+"/"+nomLieux+"/"+idCarte+".as"));
			
			conteneur.addEventListener(Event.COMPLETE, chargementTerminee);
			conteneur.addEventListener(IOErrorEvent.IO_ERROR, erreurChargement);
			
			function chargementTerminee(pevt:Event):void{
				
				var tableautemp:Array= new Array();
				tableautemp=pevt.currentTarget.data.carte.split("!");
				for(var L:Number=0;L<tableautemp.length;L++){
					cartetemp[L]=tableautemp[L].split(",");
				}
				tableau=cartetemp;
				switch(idCarte){
					case "N0": cartesLieux[n][1][0]=cartetemp;tabChargementCarteTermine[n][0]=true;break; 
					case "N1": cartesLieux[n][1][1]=cartetemp;tabChargementCarteTermine[n][1]=true;break; 
					case "N2": cartesLieux[n][1][2]=cartetemp;tabChargementCarteTermine[n][2]=true;break; 
					case "N3": cartesLieux[n][1][3]=cartetemp;tabChargementCarteTermine[n][3]=true;break; 
					case "Monstres": cartesLieux[n][1][4]=cartetemp;tabChargementCarteTermine[n][4]=true;break; 
					case "Items": cartesLieux[n][1][5]=cartetemp;tabChargementCarteTermine[n][5]=true;break; 
				}
				chargementTotalCarteTermine()
			}
			function erreurChargement(pevt:IOErrorEvent):void{
				 trace("erreur de chargement de N0");
			}
		}
//VIDEO=====================================================================================================
		public function chargerVideo(){
			
			var chargeur:Loader=new Loader();
			var contexte:LoaderContext=new LoaderContext();
			contexte.applicationDomain=ApplicationDomain.currentDomain;
			chargeur.load(new URLRequest("CarteDecor"+dossier+"/bibliothequeAnimation.swf"),contexte);
			
			chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE,chargementTermine);
			chargeur.addEventListener(IOErrorEvent.IO_ERROR, erreurChargement);
			
			function chargementTermine(pevt:Event):void{
				var objetLoaderInfo:LoaderInfo=pevt.currentTarget as LoaderInfo;
				var domaineApplication:ApplicationDomain=ApplicationDomain.currentDomain;
				chargementVideo=true;
				chargementTotalTermine();
			}
			function erreurChargement(pevt:IOErrorEvent):void{
				 trace("erreur de chargement de N0");
			}
		}
	}
}