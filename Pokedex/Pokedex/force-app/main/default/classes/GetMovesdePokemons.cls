public class GetMovesdePokemons {
    public List<Id> retornarMoves(Map<String, Object> respuesta){
         //mapas, listas y strings para acceder a moves
            Map <String, Object> pokemonMovesMap = new Map <String, Object>();
            Map <String, Object> pokeMoveMap = new Map <String, Object>();
            List <Object> movesList = (List<Object>) respuesta.get('moves');
            List <Object> moveList = new List<Object>();
            String moveString = '';
            String movesString = '';
            
            //evaluamos que la lista no este vacia y accedemos a los type
            if(!movesList.isEmpty()){
                for(Object move : movesList){
                    pokemonMovesMap = (Map<String, Object>) move;
                    moveList.add(pokemonMovesMap.get('move'));      
                }
            }
            //evaluamos que la lista no este vacia y tenga type para poder acceder a name y poner la
            //primer letra en mayuscula y concatenamos al string el ; para pasarlo a la pick list cuando termine de 
            //recorrer todos los type
            List <String> strMov= new List <String>();
            
            if(!moveList.isEmpty()){
                for(Object t : moveList){
                    pokeMoveMap = (Map <String, Object>) t;
                    moveString = (String) pokeMoveMap.get('name');
                    strMov.add(moveString.capitalize()); 
                }
            }
            
            sObject idMov , idMov1 , idMov2 , idMov3;
            List<Id> idsMov = new List<Id>(4);
            if(strMov.size() >= 4){
                idMov = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[0] LIMIT 1];
            	idMov1 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[1] LIMIT 1];
            	idMov2 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[2] LIMIT 1];
         		idMov3 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[3] LIMIT 1];
           		idsMov.add(idMov.id);
                idsMov.add(idMov1.id);
                idsMov.add(idMov2.id);
                idsMov.add(idMov3.id);
            }else if(strMov.size() == 3){
                idMov = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[0] LIMIT 1];
            	idMov1 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[1] LIMIT 1];
            	idMov2 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[2] LIMIT 1];
                idsMov.add(idMov.id);
                idsMov.add(idMov1.id);
                idsMov.add(idMov2.id);
            }else if(strMov.size() == 2){
                idMov = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[0] LIMIT 1];
            	idMov1 = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[1] LIMIT 1];
                idsMov.add(idMov.id);
                idsMov.add(idMov1.id);
            }else if(strMov.size() == 1){
                idMov = [SELECT Id, Name from Movimiento__c WHERE Name like :strMov[0] LIMIT 1];
                idsMov.add(idMov.id);
            }
        return idsMov;
    }
}