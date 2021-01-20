Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 1000 * 7
}

Config.DrugDealerItems = {
	marijuana = 91
}

Config.LicenseEnable = true -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(2220.72, 5582.52, 53.81), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(2344.7, 2567.94, 46.63), name = _U('blip_weedprocessing'), color = 25, sprite = 496},

	DrugDealer = {coords = vector3(-1178.31, -1572.07, 4.36), name = _U('blip_drugdealer'), color = 6, sprite = 378},
}