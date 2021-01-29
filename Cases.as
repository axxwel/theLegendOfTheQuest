package{
	
	
	public class Cases {
		
		public var carteDecor:Array=new Array();
		public var cases:int=0;
		public var ligne:int=0;
		public var colonne:int=0;
		
		public function Cases(){
			
		}
		public function tester_case(pligne:int,pcolonne:int,pcarte:Array):int{
				
				ligne=pligne;
				colonne=pcolonne;
				carteDecor=pcarte;
				
				cases=0;
			
//cases sol...................................................................
				if((carteDecor[ligne][colonne]==3)||//exterieur
					(carteDecor[ligne][colonne]==8)||
					
					(carteDecor[ligne][colonne]==42)||//interieur
					(carteDecor[ligne][colonne]==43)||
					
					(carteDecor[ligne][colonne]==52)||//pont bois
					(carteDecor[ligne][colonne]==53)||
					(carteDecor[ligne][colonne]==54)||
					
					(carteDecor[ligne][colonne]==269)||//branches
					(carteDecor[ligne][colonne]==270)||
					(carteDecor[ligne][colonne]==273)){cases=1;}
//cases infrancissables..........................................................
				if(	(carteDecor[ligne][colonne]==12)||//exterieur
					(carteDecor[ligne][colonne]==13)||
					(carteDecor[ligne][colonne]==14)||
					(carteDecor[ligne][colonne]==15)||
					(carteDecor[ligne][colonne]==16)||
					(carteDecor[ligne][colonne]==17)||
					(carteDecor[ligne][colonne]==18)||
					(carteDecor[ligne][colonne]==19)||
					(carteDecor[ligne][colonne]==20)||
					
					(carteDecor[ligne][colonne]==230)||//interieur
					(carteDecor[ligne][colonne]==231)||
					(carteDecor[ligne][colonne]==233)||
					(carteDecor[ligne][colonne]==234)||
					(carteDecor[ligne][colonne]==250)){cases=2;}
//cases echelles...................................................................
				if( (carteDecor[ligne][colonne]==71)||
					(carteDecor[ligne][colonne]==72)||
					(carteDecor[ligne][colonne]==73)){cases=4;}
//case fin echelles...............................................................
				if( (carteDecor[ligne][colonne]==64)||
					(carteDecor[ligne][colonne]==65)||
					(carteDecor[ligne][colonne]==66)||
					(carteDecor[ligne][colonne]==67)||
					(carteDecor[ligne][colonne]==68)||
					(carteDecor[ligne][colonne]==69)){cases=5;}
//case escalier...............................................................
				if( (carteDecor[ligne][colonne]==27)||
					(carteDecor[ligne][colonne]==28)||
					(carteDecor[ligne][colonne]==29)||
					(carteDecor[ligne][colonne]==30)){cases=10;}
//cases Monstres...................................................................
				if( (carteDecor[ligne][colonne]==562)||//ronces
					(carteDecor[ligne][colonne]==563)|| 
				    (carteDecor[ligne][colonne]==564)||
					(carteDecor[ligne][colonne]==582)||
					(carteDecor[ligne][colonne]==583)||
					(carteDecor[ligne][colonne]==584)){cases=100;}
				
				if( (carteDecor[ligne][colonne]==565)||//rocher
					(carteDecor[ligne][colonne]==585)){cases=101;}
//cases Plateforme...................................................................
				if( (carteDecor[ligne][colonne]==462)||
					(carteDecor[ligne][colonne]==464)){cases=201;}
				if( (carteDecor[ligne][colonne]==463)||
					(carteDecor[ligne][colonne]==465)){cases=202;}
				if( (carteDecor[ligne][colonne]==482)||
					(carteDecor[ligne][colonne]==484)){cases=203;}
				if( (carteDecor[ligne][colonne]==483)||
					(carteDecor[ligne][colonne]==485)){cases=204;}
				if( (carteDecor[ligne][colonne]==489)||
					(carteDecor[ligne][colonne]==490)||
					(carteDecor[ligne][colonne]==491)){cases=205;}//Plateforme tombe......
				if( (carteDecor[ligne][colonne]==469)||
					(carteDecor[ligne][colonne]==471)){cases=206;}//Plateforme case......
//tester cases eau.................................................................
				if(carteDecor[ligne][colonne]==126){cases=300;}
//tester cases Sons.................................................................
				if( (carteDecor[ligne][colonne]==122)||
					(carteDecor[ligne][colonne]==123)||
					(carteDecor[ligne][colonne]==124)){cases=400;}//CASCADE...
//tester cases porte.................................................................
	//PortesCoté--------------------------------------------------
				if(carteDecor[ligne][colonne]==424){cases=110;}
				if(carteDecor[ligne][colonne]==425){cases=111;}
	//PortesFaces-------------------------------------------------
				if(carteDecor[ligne][colonne]==402){cases=11;}
				if(carteDecor[ligne][colonne]==403){cases=12;}
				if(carteDecor[ligne][colonne]==404){cases=13;}
				if(carteDecor[ligne][colonne]==405){cases=14;}
				if(carteDecor[ligne][colonne]==406){cases=15;}
				if(carteDecor[ligne][colonne]==407){cases=16;}
				if(carteDecor[ligne][colonne]==408){cases=17;}
				if(carteDecor[ligne][colonne]==409){cases=18;}
				if(carteDecor[ligne][colonne]==410){cases=19;}
				if(carteDecor[ligne][colonne]==411){cases=20;}
				if(carteDecor[ligne][colonne]==412){cases=21;}
				if(carteDecor[ligne][colonne]==413){cases=22;}
				if(carteDecor[ligne][colonne]==414){cases=23;}
				if(carteDecor[ligne][colonne]==415){cases=24;}
				if(carteDecor[ligne][colonne]==416){cases=25;}
				if(carteDecor[ligne][colonne]==417){cases=26;}
				if(carteDecor[ligne][colonne]==418){cases=27;}
				if(carteDecor[ligne][colonne]==419){cases=28;}
				if(carteDecor[ligne][colonne]==420){cases=29;}
				if(carteDecor[ligne][colonne]==421){cases=30;}
//tester cases camera..............................................................
				if(carteDecor[ligne][colonne]==662){cases=31;}//block DG
				if(carteDecor[ligne][colonne]==663){cases=32;}//zoom out
				if(carteDecor[ligne][colonne]==664){cases=33;}//zoom in
				if(carteDecor[ligne][colonne]==665){cases=34;}//cam up
				if(carteDecor[ligne][colonne]==666){cases=35;}//cam Down
//tester cases PNJ.................................................................
				if(carteDecor[ligne][colonne]==702){cases=600;}
				if(carteDecor[ligne][colonne]==703){cases=601;}
				if(carteDecor[ligne][colonne]==704){cases=602;}
				if(carteDecor[ligne][colonne]==705){cases=603;}
				if(carteDecor[ligne][colonne]==706){cases=604;}
				if(carteDecor[ligne][colonne]==707){cases=605;}
				if(carteDecor[ligne][colonne]==708){cases=607;}
				if(carteDecor[ligne][colonne]==709){cases=608;}
				if(carteDecor[ligne][colonne]==710){cases=609;}
				if(carteDecor[ligne][colonne]==711){cases=610;}
//tester cases objets decos..........................................................
				if(carteDecor[ligne][colonne]==215){cases=700;}//WC
				if(carteDecor[ligne][colonne]==210){cases=701;}//lit fond
				if(carteDecor[ligne][colonne]==211){cases=702;}//lit tete
//RETOUR CASES===============================================================================================================
				return (cases);
		}			
	}
}