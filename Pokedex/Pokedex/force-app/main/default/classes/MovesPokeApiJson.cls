public class MovesPokeApiJson {
	public Integer accuracy;	//100
	public cls_contest_effect contest_effect;
	public cls_contest_type contest_type;
	public cls_damage_class damage_class;
	public Integer effect_chance;
	public cls_effect_changes[] effect_changes;
	public cls_effect_entries[] effect_entries;
	public cls_generation generation;
	public Integer id;	//1
	public cls_learned_by_pokemon[] learned_by_pokemon;
	public cls_machines[] machines;
	public cls_meta meta;
	public String name;	//pound
	public cls_names[] names;
	public cls_past_values[] past_values;
	public Integer power;	//40
	public Integer pp;	//35
	public Integer priority;	//0
	public cls_stat_changes[] stat_changes;
	public cls_super_contest_effect super_contest_effect;
	public cls_target target;
	public cls_type type;
    
	public class cls_normal {
		public cls_use_after use_after;
		public cls_use_before[] use_before;
	}
    
	public class cls_use_after {
	}
    
	public class cls_use_before {
	}
    
	public class cls_super {
		public cls_use_after use_after;
		public cls_use_before use_before;
	}
    
	public class cls_contest_effect {
		public String url;	//https://pokeapi.co/api/v2/contest-effect/1/
	}
    
	public class cls_contest_type {
		public String name;	//tough
		public String url;	//https://pokeapi.co/api/v2/contest-type/5/
	}
    
	public class cls_damage_class {
		public String name;	//physical
		public String url;	//https://pokeapi.co/api/v2/move-damage-class/2/
	}
    
	public class cls_effect_chance {
	}
    
	public class cls_effect_changes {
	}
    
	public class cls_effect_entries {
		public String effect;	//Inflicts regular damage.
		public cls_language language;
		public String short_effect;	//Inflicts regular damage with no additional effect.
	}
    
	public class cls_language {
		public String name;	//ja-Hrkt
		public String url;	//https://pokeapi.co/api/v2/language/1/
	}
    
	public class cls_version_group {
		public String name;	//gold-silver
		public String url;	//https://pokeapi.co/api/v2/version-group/3/
	}
    
	public class cls_generation {
		public String name;	//generation-i
		public String url;	//https://pokeapi.co/api/v2/generation/1/
	}
	public class cls_learned_by_pokemon {
		public String name;	//clefairy
		public String url;	//https://pokeapi.co/api/v2/pokemon/35/
	}
    
	public class cls_machines {
	}
    
	public class cls_meta {
		//public cls_ailment ailment;
		//public Integer ailment_chance;	//0
		//public cls_category category;
		//public Integer crit_rate;	//0
		//public Integer drain;	//0
		//public Integer flinch_chance;	//0
		//public Integer healing;	//0
		//public cls_max_hits max_hits;
		//public cls_max_turns max_turns;
		//public cls_min_hits min_hits;
		//public cls_min_turns min_turns;
		//public Integer stat_chance;	//0
	}
	public class cls_ailment {
		public String name;	//none
		public String url;	//https://pokeapi.co/api/v2/move-ailment/0/
	}
	public class cls_category {
		public String name;	//damage
		public String url;	//https://pokeapi.co/api/v2/move-category/0/
	}
	public class cls_max_hits {
	}
	public class cls_max_turns {
	}
	public class cls_min_hits {
	}
	public class cls_min_turns {
	}
	public class cls_names {
		public cls_language language;
		public String name;	//はたく
	}
	public class cls_past_values {
	}
	public class cls_stat_changes {
	}
	public class cls_super_contest_effect {
		public String url;	//https://pokeapi.co/api/v2/super-contest-effect/5/
	}
	public class cls_target {
		public String name;	//selected-pokemon
		public String url;	//https://pokeapi.co/api/v2/move-target/10/
	}
	public class cls_type {
		public String name;	//normal
		public String url;	//https://pokeapi.co/api/v2/type/1/
	}
	public static MovesPokeApiJson parse(String json){
		return (MovesPokeApiJson) System.JSON.deserialize(json, MovesPokeApiJson.class);
	}
}