//clase para obtener todos los pokemones
public class CallPokeApiBatch implements Database.Batchable<Integer>, Database.AllowsCallouts{
    
    //creamos y agregamos en una lista los numeros que usaremos para las llamadas a la API
    public List<Integer> start(Database.BatchableContext bt){
        
        List<Integer> pokemon = new List<Integer>();
        for(integer i=1; i<=898;i++){		//898
            pokemon.add(i);
        }
        return pokemon;
    }
    
    Integer j = 0;
    public void execute(Database.BatchableContext bc, List<Integer> scope){
        //llamado a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+scope[j]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        
      	//evaluamos el estatus de la llamada
        if (response.getStatusCode() == 200) {
            
            //voy a usar deserialize con clase apex para acceder a los datos simples y deserializeUntype para las listas
            PokeApiJson pokeApi = PokeApiJson.parse(response.getBody());
            Map <String, Object> pokemonesMap = (Map <String, Object>) JSON.deserializeUntyped(response.getBody());
            
			//conversion de altura a mt. y de peso a kg y pasamos la primer letra del nombre a mayuscula
            
            Double altura = (Double)pokeApi.height / 10;
            Double peso = (Double)pokeApi.weight / 10;
            String pokeName = pokeApi.name;
            pokeName = pokeName.capitalize();
            
            //mapas, listas y strings para acceder a los types
            Map <String, Object> pokemonTypesMap = new Map <String, Object>();
            Map <String, Object> poketypeMap = new Map <String, Object>();
            List <Object> typesList = (List<Object>) pokemonesMap.get('types');
            List <Object> typeList = new List<Object>();
            String typeString = '';
            String typesString = '';
            
            //evaluamos que la lista no este vacia y accedemos a los type
            if(!typesList.isEmpty()){
                for(Object type : typesList){
                    pokemonTypesMap = (Map<String, Object>) type;
                    typeList.add(pokemonTypesMap.get('type'));      
                }
            }
            
            //evaluamos que la lista no este vacia para acceder a name, paso la primer
            //letra a mayuscula y concatenamos al string el ; para pasarlo a la multy picklist 
            
            if(!typeList.isEmpty()){
                for(Object t : typeList){
                    poketypeMap = (Map <String, Object>) t;
                    typeString = (String) poketypeMap.get('name');
                    typesString += typeString.capitalize() + ';';
                }
            }
            
            //mapas y listas para acceder a los stats
            Map <String, Object> pokemonStatsMap = new Map <String, Object>();
            Map <String, Object> pokeStatMap = new Map <String, Object>();
            List <Object> statsList = (List<Object>) pokemonesMap.get('stats');
            List <Object> statList = new List<Object>();
            Integer speed, hp, defense, attack;
			
            //evaluamos que la lista no este vacia y accedemos a los stat
            if(!statsList.isEmpty()){
                for(Object st : statsList){
                    pokemonStatsMap = (Map<String, Object>) st;
                    statList.add(pokemonStatsMap.get('stat')); 
                }
            }
            
            //evaluamos que la lista no este vacia y hacemos una validacion accediendo al nombre del stat y de asignamos el valor de
            //base_stat a la variable que asignaremos al campo del registro
             
            if(!statList.isEmpty()){
                for(Object s : statList){
                    pokeStatMap = (Map <String, Object>) s;
                    
                    if(pokeStatMap.get('name') == 'hp'){
                        hp = (Integer) pokemonStatsMap.get('base_stat');
                    }
                    else if(pokeStatMap.get('name') == 'attack'){
                       attack = (Integer) pokemonStatsMap.get('base_stat');
                    }
                    else if(pokeStatMap.get('name') == 'speed'){
                       speed = (Integer) pokemonStatsMap.get('base_stat');
                    }
                    else if(pokeStatMap.get('name') == 'defense'){
                       defense = (Integer) pokemonStatsMap.get('base_stat');
                    }
                }
            }
            
             //mapas y listas para acceder a los movimientos
           
             Map <String, Object> pokemonMovesMap = new Map <String, Object>();
            Map <String, Object> pokeMoveMap = new Map <String, Object>();
            List <Object> movesList = (List<Object>) pokemonesMap.get('moves');
            List <Object> moveList = new List<Object>();
            String moveString = '';
            String movesString = '';
            
            //evaluamos que la lista no este vacia y accedemos a move
            
            if(!movesList.isEmpty()){
                for(Object move : movesList){
                    pokemonMovesMap = (Map<String, Object>) move;
                    moveList.add(pokemonMovesMap.get('move'));      
                }
            }
            //evaluamos que la lista no este vacia y para acceder al name y poner la
            //primer letra en mayuscula, lo agregamos a una lista de strings
            
            List <String> strMov= new List <String>();
            
            if(!moveList.isEmpty()){
                for(Object t : moveList){
                    pokeMoveMap = (Map <String, Object>) t;
                    moveString = (String) pokeMoveMap.get('name');
                    strMov.add(moveString.capitalize()); 
                }
            }
            
            //variables Id que voy a asignar al campo EXTId__c ---  lista que contiene movimientos coincidentes entre Movimiento__c 
            //y movimientos del pokemon en pokeapi
            
            Id idSlot4 , idSlot1 , idSlot2 , idSlot3;
             LIST<sObject> listmov = new LIST<sObject>(4);
             listmov = [SELECT Id, Name from Movimiento__c WHERE Name in :strMov LIMIT 4];
            
            //validaciones de tamaño para asignar los valores de la lista a las variables Id
            if(listmov.size() == 1){
                idSlot1 = listmov[0].id;	
            }else if(listmov.size() == 2){
				idSlot2 = listmov[1].id;	
                idSlot1 = listmov[0].id;	
            }else if(listmov.size() == 3){
                idSlot1 = listmov[0].id;	
                idSlot2 = listmov[1].id;	
                idSlot3 = listmov[2].id;	
            }else if(listmov.size() > 3){
           		idSlot4 = listmov[3].id;
                idSlot3 = listmov[2].id;
                idSlot2 = listmov[1].id;	
                idSlot1 = listmov[0].id;	
            } 
            
            //mapas, listas y strings para acceder a ability
            Map <String, Object> pokemonAbilitiesMap = new Map <String, Object>();
            Map <String, Object> pokeAbilityMap = new Map <String, Object>();
            List <Object> abilitiesList = (List<Object>) pokemonesMap.get('abilities');
            List <Object> abilityList = new List<Object>();
            String abilityString = '';
            String abilitiesString = '';
            
            //evaluamos que la lista no este vacia y accedemos a ability
            if(!abilitiesList.isEmpty()){
                for(Object ability : abilitiesList){
                    pokemonAbilitiesMap = (Map<String, Object>) ability;
                    abilityList.add(pokemonAbilitiesMap.get('ability'));      
                }
            }
            //evaluamos que la lista no este vacia para poder acceder a name y poner la
            //primer letra en mayuscula y concatenamos al string el ; 
            
            List <String> strAb= new List <String>();
            if(!abilityList.isEmpty()){
                for(Object a : abilityList){
                    pokeAbilityMap = (Map <String, Object>) a;
                    abilityString = (String) pokeAbilityMap.get('name');
                    strAb.add(abilityString.capitalize());
                }
            }
            
            //creo una variable tipo sObject y hago una query en busca de una coincidencia entre una habilidad
            //del pokemon que se va a insertar y un registro de Habilidad__c
            //primero valido que la lista no este vacia
            //asigno el valor del id del registro retornado a mi variable id
            sObject abilityObj;
            Id idAbility;
            if(!strAb.isEmpty()){	//.size() > 0
                abilityObj = [SELECT Id, Name from Habilidad__c WHERE Name like :strAb[0] LIMIT 1];
                idAbility = abilityObj.id;
            }
           
              
            
            
            //creacion de objeto y asignacion de valores a los campos
            
            Pokemon__c pokemon = new Pokemon__c(
            	ExtId__c = pokeApi.id,
            	Name = pokeName,
            	Altura__c = altura + ' mts.',
            	Peso__c = peso + ' kg.',
            	Imagen__c = pokeApi.sprites.front_default,
            	Vida__c = pokeApi.stats[0].base_stat,			//hp,		
            	Velocidad__c = pokeApi.stats[5].base_stat,		//speed,
            	Defensa__c = pokeApi.stats[2].base_stat,		//defense,
            	Ataque__c = pokeApi.stats[1].base_stat,			//attack,
            	Tipos__c = typesString,           	
                Slot1__c = idSlot1,
            	Slot2__c = idSlot2,
            	Slot3__c = idSlot3,
            	Slot4__c = idSlot4,
               	Habilidad__c = idAbility
        	);
        	try {
            // insertamos el registro creado
            	insert pokemon;         
        	} catch(Exception e) {
            	System.debug(e);
        	}
            // incremento de variable que uso como indice para recorrer la lista de integers generada en start
        	j++;
        } 
        // en caso de recibir un status distinto de 200 realizamos el debug
        else{
             	System.debug('Codigo de error::'+ response.getStatusCode());
            }  
        
    }
    public void finish(Database.BatchableContext bc){
        //operacion que ejecutamos al finalizar el execute
        system.debug('termino el batch');
    }
}