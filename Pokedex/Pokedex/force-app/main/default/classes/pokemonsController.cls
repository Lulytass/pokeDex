public class pokemonsController {
	@AuraEnabled(cacheable=true) //notación para acceder esta clase desde LWC y que guarde en cache para
    //no hacer llamadas innecesarias a la api
	public static List<Pokemon__c> getPokemons(String tipo, String generacion, String name) {
        //funcion para armar query dinamicamente mediante validaciones
        try{
            string condicion = '';
        	string query;
            Integer genInt;
            if(String.isNotBlank(generacion)){
                genInt = Integer.valueOf(generacion);
            }
            
        	if(String.isNotBlank(name)){
            	condicion = 'Name LIKE \'%' + name + '%\'';   
            }
        
        	if( String.isNotBlank(generacion) && String.isNotBlank(condicion) ){
            	condicion += ' AND Generacion__c = ' + genInt ;
        	}else if( String.isNotBlank(generacion) ){
            	condicion += ' Generacion__c = ' + genInt ;
            }
        
        	if( String.isNotBlank(tipo) && String.isNotBlank(condicion) ){
            	condicion += ' AND  Tipos__c INCLUDES ' + '(\'' +tipo +'\')';
            }else if(String.isNotBlank(tipo)){
                condicion += ' Tipos__c INCLUDES ' + '(\'' +tipo +'\')';
            }
        
        	if( String.isNotBlank(condicion) ){
            	query = 'SELECT Generacion__c,Imagen__c,Name,ExtId__c,Tipos__c FROM Pokemon__c WHERE ' + condicion + 'ORDER BY EXTId__c';
        	}else{
            	query = 'SELECT Generacion__c,Imagen__c,Name,ExtId__c,Tipos__c FROM Pokemon__c ORDER BY EXTId__c';
        	}
        	List<Pokemon__c> respuestaQuery = Database.query(query);
        
        	return respuestaQuery;
        }catch (Exception e) {  //de surgir un error mostramos una excepción
            throw new AuraException('Ocurrio un error al realizar la consulta:: ' + e.getMessage());    
        }
        
	}
    //funcion que usamos para contar los pokemos resultantes de la query
    @AuraEnabled(cacheable=true)
    public static Integer cantidadDePokemonesListados(String tiposFilt, String generacionFilt, String nameFilt){
        Integer cantidad = getPokemons(tiposFilt, generacionFilt, nameFilt).size();
        return cantidad;
    }
}