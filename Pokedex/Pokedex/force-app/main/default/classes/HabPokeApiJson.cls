public class HabPokeApiJson{
	public cls_effect_changes[] effect_changes;
	public cls_effect_entries[] effect_entries;
	public cls_flavor_text_entries[] flavor_text_entries;
	public cls_generation generation;
	public Integer id;	//165
	public boolean is_main_series;
	public String name;	//aroma-veil
	public cls_names[] names;
	public cls_pokemon[] pokemon;
	public class cls_effect_changes {
	}
	public class cls_effect_entries {
		public String effect;	//Pokémon sind vor mentalen Attacken wie attract, disable, taunt oder encore geschützt, solange sich ein Pokémon mit dieser Fähigkeit im Team befindet. Das gilt auch, für das Pokémon selbst.
		public cls_language language;
		public String short_effect;	//Schützt Verbündete vor mentalen Attacken.
	}
	public class cls_language {
		public String name;	//ja-Hrkt
		public String url;	//https://pokeapi.co/api/v2/language/1/
	}
	public class cls_flavor_text_entries {
		public String flavor_text;	//みかたへの　メンタルこうげきを　ふせぐ。
		public cls_language language;
		public cls_version_group version_group;
	}
	public class cls_version_group {
		public String name;	//x-y
		public String url;	//https://pokeapi.co/api/v2/version-group/15/
	}
	public class cls_generation {
		public String name;	//generation-vi
		public String url;	//https://pokeapi.co/api/v2/generation/6/
	}
	public class cls_names {
		public cls_language language;
		public String name;	//アロマベール
	}
	public class cls_pokemon {
		public cls_pokemon pokemon;
		public String name;	//spritzee
		public String url;	//https://pokeapi.co/api/v2/pokemon/682/
		public Integer slot;	//3
	}
	public static HabPokeApiJson parse(String json){
		return (HabPokeApiJson) System.JSON.deserialize(json, HabPokeApiJson.class);
	}
}