@isTest
public class pokemonsControllerTest {
    
    static testMethod void testGetPokemons(){
        
        Test.setMock(HttpCalloutMock.class, new PokemonsControllerMock());
        
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
        
        //ejecutamos el batch para despues hacer las consultas
        Test.startTest();
		CallPokeApiBatch batch = new CallPokeApiBatch();
        database.executeBatch(batch, 898);
        Test.stopTest();
        
        List<Pokemon__c> pokemons1 = pokemonsController.getPokemons(null, null, 'bul');
        List<Pokemon__c> pokemons2 = pokemonsController.getPokemons('Poison', null, 'ba');
        List<Pokemon__c> pokemons3 = pokemonsController.getPokemons(null, '2', null);
        List<Pokemon__c> pokemons4 = pokemonsController.getPokemons('Grass', '1', 'a');
        //Integer cantidad = PokemonsController.cantidadDePokemonesListados(null, null, 'saur');
        
        // Realizar pruebas con diferentes criterios de búsqueda 
        System.assertEquals(1, pokemons1.size());
        System.assertEquals('Bulbasaur', pokemons1[0].Name);
        System.assertEquals(1, pokemons2.size());
        System.assertEquals(0, pokemons3.size());
        System.assertEquals('Bulbasaur', pokemons4[0].Name);
        //System.assertEquals(1,cantidad);
    }
}