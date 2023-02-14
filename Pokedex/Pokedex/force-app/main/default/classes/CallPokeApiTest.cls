@istest
public class CallPokeApiTest {
    @istest 
    public static void batchTestCargaExitosa(){
        
        //enviamos nuestro Mock para usar la respuesta falsa y hacer las comparaciones 
        Test.setMock(HttpCalloutMock.class, new CallPokeApiMock());
        
        //creamos una instancia de Habilidad__c le damos al campo Name el nombre de la primer habilidad como valor ya que es el que la clase Batch asigna y lo insertamos
        Habilidad__c habilidad = new Habilidad__c();
        habilidad.Name = 'overgrow';
        
        insert habilidad;
		
        //repetimos lo anterior pero con movimientos, tomando los 4 primeros y los agregamos
        List<Movimiento__c> movimientos = new List<Movimiento__c>();
        Movimiento__C slot1 = new Movimiento__C();
        slot1.name = 'sunny-day';
        Movimiento__C slot2 = new Movimiento__C();
        slot2.name = 'fury-cutter';
        Movimiento__C slot3 = new Movimiento__C();
        slot3.name = 'substitute';
        Movimiento__C slot4 = new Movimiento__C();
        slot4.name = 'tackle';
        
       movimientos.add(slot1);
       movimientos.add(slot2);
       movimientos.add(slot3);
       movimientos.add(slot4);
        
       insert movimientos;
        
        //instanciamos la clase batch y ejecutamos
        Test.startTest();
		CallPokeApiBatch batch = new CallPokeApiBatch();
        database.executeBatch(batch, 898);
        Test.stopTest();
        
        //hacemos una query para recuperar los datos de nuestros campos 
        Pokemon__c pokemon = [SELECT Name, Altura__c, Ataque__c, Defensa__c, ExtId__c, Generacion__c, Habilidad__c, Imagen__c, Peso__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c, Tipos__c, Velocidad__c, Vida__c
                             FROM Pokemon__c];
        
        //comparamos los datos esperados con la respuesta
        system.assertEquals('Bulbasaur' ,pokemon.Name);
        system.assertEquals('Poison;Grass' ,pokemon.Tipos__c);
        system.assertEquals(slot1.Id ,pokemon.Slot1__c);
        system.assertEquals(slot2.Id ,pokemon.Slot2__c);
        system.assertEquals(slot3.Id ,pokemon.Slot3__c);
        system.assertEquals(slot4.Id ,pokemon.Slot4__c);
        system.assertEquals(1 ,pokemon.ExtId__c);
        system.assertEquals(45 ,pokemon.Velocidad__c);
        system.assertEquals(49 ,pokemon.Defensa__c);
        system.assertEquals(49 ,pokemon.Ataque__c);
        system.assertEquals(45 ,pokemon.Vida__c);
        system.assertEquals(1 ,pokemon.Generacion__c);
        system.assertEquals('0.7 mts.' ,pokemon.Altura__c);
        system.assertEquals(habilidad.Id ,pokemon.Habilidad__c);
        system.assertEquals('6.9 kg.' ,pokemon.Peso__c);
        system.assertEquals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png' ,pokemon.Imagen__c);
        
    }
    public static void batchTestCargaFallida(){
        
        //enviamos nuestro Mock para usar la respuesta falsa y hacer las comparaciones 
        Test.setMock(HttpCalloutMock.class, new CallPokeApiMock());
        
        //creamos una instancia de Habilidad__c le damos al campo Name el nombre de la primer habilidad como valor ya que es el que la clase Batch asigna y lo insertamos
        Habilidad__c habilidad = new Habilidad__c();
        habilidad.Name = 'overgrow';
        
        insert habilidad;
		
        //repetimos lo anterior pero con movimientos, tomando los 4 primeros y los agregamos
        List<Movimiento__c> movimientos = new List<Movimiento__c>();
        Movimiento__C slot1 = new Movimiento__C();
        slot1.name = 'sunny-day';
        Movimiento__C slot2 = new Movimiento__C();
        slot2.name = 'fury-cutter';
        Movimiento__C slot3 = new Movimiento__C();
        slot3.name = 'substitute';
        Movimiento__C slot4 = new Movimiento__C();
        slot4.name = 'tackle';
        
       movimientos.add(slot1);
       movimientos.add(slot2);
       movimientos.add(slot3);
       movimientos.add(slot4);
        
       insert movimientos;
        
        //instanciamos la clase batch y ejecutamos
        Test.startTest();
		CallPokeApiBatch batch = new CallPokeApiBatch();
        database.executeBatch(batch, 898);
        Test.stopTest();
        
        //hacemos una query para recuperar los datos de nuestros campos 
        List <Pokemon__c> pokemon = [SELECT Name, Altura__c, Ataque__c, Defensa__c, ExtId__c, Generacion__c, Habilidad__c, Imagen__c, Peso__c, Slot1__c, Slot2__c, Slot3__c, Slot4__c, Tipos__c, Velocidad__c, Vida__c
                             FROM Pokemon__c];
        
        //comparamos los datos esperados con la respuesta
        System.assertNotEquals(1, pokemon.size(), 'La cantidad de pokemons no fue la esperada, fue :: ' + pokemon.size());
        
    }
    
    @isTest
    static void noSeEstableceLaConexion(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getPokemonsResource');
        mock.setStatusCode(404);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatch api = new CallPokeApiBatch();
            Database.executeBatch(api, 898);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertEquals(0, [select count() from Pokemon__c],'No se pudo establecer la conexión para crear el registro');
    }
}