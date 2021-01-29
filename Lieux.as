package{
	
	public class Lieux {
		
		public var nom_lieux:String;
		public var nom_fond:String;
		public var colonne_depart:int;
		public var ligne_depart:int;
		public var numeroHorizon:int;
		public var controlZoom:int;
		public var controlCam:int;
		public var type:String;
		public var idType:String;
		
		
		public var donnee_niveau:Array=new Array();
		public var donneeLieuxXML:XML;

		public function Lieux(){
			
		}
		public function creerLieux(pdonneesXML:XML){
			donneeLieuxXML=pdonneesXML;
			nom_lieux=donneeLieuxXML.lieux_depart_debutJeu.@nom;
			nom_fond=donneeLieuxXML.lieux_depart_debutJeu.@nom_fond;
			colonne_depart=donneeLieuxXML.lieux_depart_debutJeu.@colonne_depart;
			ligne_depart=donneeLieuxXML.lieux_depart_debutJeu.@ligne_depart;
			numeroHorizon=donneeLieuxXML.lieux_depart_debutJeu.@numeroHorizon;
			controlZoom=donneeLieuxXML.lieux_depart_debutJeu.@controlZoom;
			controlCam=donneeLieuxXML.lieux_depart_debutJeu.@controlCam;
			type=donneeLieuxXML.lieux_depart_debutJeu.@type;
			idType=donneeLieuxXML.lieux_depart_debutJeu.@idType;
			retour();
		}
		public function nomLieux():Array{
			var tableau:Array=new Array();
			var n:int=0;
			var lieuxXMLList:XMLList=donneeLieuxXML.lieux_depart;
			for each(var nomXML:XML in lieuxXMLList){
				tableau[n]=nomXML.@nom;
				n++
			}
			return(tableau);
		}		
		public function changerLieux(pnomLieuxDepart:String,pnumeroPorte:int):void{
			nom_lieux=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@nom;
			nom_fond=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@nom_fond;
			colonne_depart=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@colonne_depart;
			ligne_depart=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@ligne_depart;
			numeroHorizon=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@numeroHorizon;	
			controlZoom=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@controlZoom;	
			controlCam=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@controlCam;	
			type=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@type;
			idType=donneeLieuxXML.lieux_depart.(@nom==pnomLieuxDepart).porte.(@numero==pnumeroPorte).@idType;	
			retour();
		}
		public function retour(){
				donnee_niveau[0]=nom_lieux;
				donnee_niveau[1]=ligne_depart;
				donnee_niveau[2]=colonne_depart;
				donnee_niveau[3]=nom_fond;
				donnee_niveau[4]=numeroHorizon;
				donnee_niveau[5]=controlZoom;
				donnee_niveau[6]=controlCam;
				donnee_niveau[7]=type;
				donnee_niveau[8]=idType;
		}
		public function restart(){
			nom_lieux=donneeLieuxXML.lieux_depart_debutJeu.@nom;
			nom_fond=donneeLieuxXML.lieux_depart_debutJeu.@nom_fond;
			colonne_depart=donneeLieuxXML.lieux_depart_debutJeu.@colonne_depart;
			ligne_depart=donneeLieuxXML.lieux_depart_debutJeu.@ligne_depart;
			numeroHorizon=donneeLieuxXML.lieux_depart_debutJeu.@numeroHorizon;
			controlZoom=donneeLieuxXML.lieux_depart_debutJeu.@controlZoom;
			controlCam=donneeLieuxXML.lieux_depart_debutJeu.@controlCam;
			type=donneeLieuxXML.lieux_depart_debutJeu.@type;
			idType=donneeLieuxXML.lieux_depart_debutJeu.@idType;
			retour();
		}
	}
}