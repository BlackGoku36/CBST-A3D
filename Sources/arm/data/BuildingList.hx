package arm.data;

import arm.data.Buildings;

class BuildingList {

	public static var House: Building = {
		name: "House_Community",
		object: null,
		type: Community,
		cost: {
			money: 0,
			wood: 10,
			stone: 10,
			electricity: 5
		},
		produce:{
			money: 5,
			wood: 0,
			stone: 0,
			electricity: 0
		}
	};
	public static var Park: Building = {
		name: "Park_Community",
		object: null,
		type: Community,
		cost: {
			money: 0,
			wood: 20,
			stone: 20,
			electricity: 5
		},
		produce:{
			money: 5,
			wood: 0,
			stone: 0,
			electricity: 0
		}
	};

	public static var Sawmill: Building = {
		name: "Sawmill_Factory",
		object: null,
		type: Factory,
		cost: {
			money: 10,
			wood: 0,
			stone: 0,
			electricity: 5
		},
		produce:{
			money: 0,
			wood: 5,
			stone: 0,
			electricity: 0
		}
	};
	public static var Quarry: Building = {
		name: "Quarry_Factory",
		object: null,
		type: Factory,
		cost: {
			money: 10,
			wood: 0,
			stone: 0,
			electricity: 5
		},
		produce:{
			money: 0,
			wood: 0,
			stone: 5,
			electricity: 0
		}
	};
	public static var Powerplant: Building = {
		name: "Powerplant_Factory",
		object: null,
		type: Factory,
		cost: {
			money: 20,
			wood: 0,
			stone: 0,
			electricity: 0
		},
		produce:{
			money: 0,
			wood: 0,
			stone: 0,
			electricity: 10
		}
	};

}
