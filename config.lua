Config = {
    SellPrices = {
        -- ['item'] = {min, max} --
        ['stone'] = {10, 20},
        ['diamond'] = {40, 60},
        ['emeral'] = {50, 70},
        ['ruby'] = {60, 80}
    },
    Sell = vector3(247.48, 3169.72, 42.79), -- ['sell global location'] --
    GetConfigDistance = 100.0, -- ['distance to get props/effects etc'] --
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe'  -- ['tool name'] = "prop name" --
    },
    Items = {
        ["v_res_fa_crystal01"] = "diamond",  -- ['mineral prop'] = "item name" --
        ["v_res_fa_crystal02"] = "iron",
        ["v_res_fa_crystal03"] = "copper"
    },
    Mine = vector3(2955.53, 2793.64, 40.75), -- ['mine global location'] --
    Rocks = {
        {   
            rock = "prop_rock_3_f",
            GetMineralChance = 50,
            coords = vector3(2944.218, 2772.041, 38.21),
            mineral = "v_res_fa_crystal01",
            ResetTimer = 1, -- number in minutes -- 
            active = false,
            minerals = {
                {
                    active = false,
                    pos = vector3(0.0, 0.0, 1.15),
                    rot = vector3(0.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.3, 1.15),
                    rot = vector3(-20.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.8, 0.65),
                    rot = vector3(-60.0, 10.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(1.0, 0.4, 0.62),
                    rot = vector3(0.0, 90.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.65, 0.65, 0.62),
                    rot = vector3(140.0, -140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.65, -0.65, 0.86),
                    rot = vector3(-140.0, 140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.7, -0.4, 0.65),
                    rot = vector3(60.0, -30.0, 0.0)
                }
            }
        },
        {   
            rock = "prop_rock_3_f",
            GetMineralChance = 50,
            coords = vector3(2994.03, 2756.4, 41.8),
            mineral = "v_res_fa_crystal02",
            ResetTimer = 1, 
            active = false,
            minerals = {
                {
                    active = false,
                    pos = vector3(0.0, 0.0, 1.15),
                    rot = vector3(0.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.3, 1.15),
                    rot = vector3(-20.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.8, 0.65),
                    rot = vector3(-60.0, 10.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(1.0, 0.4, 0.62),
                    rot = vector3(0.0, 90.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.65, 0.65, 0.62),
                    rot = vector3(140.0, -140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.65, -0.65, 0.86),
                    rot = vector3(-140.0, 140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.7, -0.4, 0.65),
                    rot = vector3(60.0, -30.0, 0.0)
                }
            }
        },
        {
            rock = "prop_rock_3_f",
            GetMineralChance = 50,
            coords = vector3(2970.09, 2784.60, 38.26),
            mineral = "v_res_fa_crystal03",
            ResetTimer = 1, 
            active = false,
            minerals = {
                {
                    active = false,
                    pos = vector3(0.0, 0.0, 1.15),
                    rot = vector3(0.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.3, 1.15),
                    rot = vector3(-20.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.8, 0.65),
                    rot = vector3(-60.0, 10.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(1.0, 0.4, 0.62),
                    rot = vector3(0.0, 90.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.65, 0.65, 0.62),
                    rot = vector3(140.0, -140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.65, -0.65, 0.86),
                    rot = vector3(-140.0, 140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.7, -0.4, 0.65),
                    rot = vector3(60.0, -30.0, 0.0)
                }
            }
        },
        {   
            rock = "prop_rock_3_f",
            GetMineralChance = 50,
            coords = vector3(2837.66, 2787.30, 38.88),
            mineral = "v_res_fa_crystal01",
            ResetTimer = 1, 
            active = false,
            minerals = {
                {
                    active = false,
                    pos = vector3(0.0, 0.0, 1.15),
                    rot = vector3(0.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.3, 1.15),
                    rot = vector3(-20.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.8, 0.65),
                    rot = vector3(-60.0, 10.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(1.0, 0.4, 0.62),
                    rot = vector3(0.0, 90.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.65, 0.65, 0.62),
                    rot = vector3(140.0, -140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.65, -0.65, 0.86),
                    rot = vector3(-140.0, 140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.7, -0.4, 0.65),
                    rot = vector3(60.0, -30.0, 0.0)
                }
            }
        },
        {   
            rock = "prop_rock_3_f",
            GetMineralChance = 50,
            coords = vector3(2929.23, 2800.604, 40.0),
            mineral = "v_res_fa_crystal03",
            ResetTimer = 1, 
            active = false,
            minerals = {
                {
                    active = false,
                    pos = vector3(0.0, 0.0, 1.15),
                    rot = vector3(0.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.3, 1.15),
                    rot = vector3(-20.0, -20.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.5, 0.8, 0.65),
                    rot = vector3(-60.0, 10.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(1.0, 0.4, 0.62),
                    rot = vector3(0.0, 90.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.65, 0.65, 0.62),
                    rot = vector3(140.0, -140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(0.65, -0.65, 0.86),
                    rot = vector3(-140.0, 140.0, 0.0)
                },
                {
                    active = false,
                    pos = vector3(-0.7, -0.4, 0.65),
                    rot = vector3(60.0, -30.0, 0.0)
                }
            }
        }
    }
}

Locales = {
    ['hit_rock'] = 'Appui sur ~INPUT_CONTEXT~ pour miner.',
    ['info_text'] = 'Appui sur ~INPUT_ATTACK~ pour tapper, ~INPUT_FRONTEND_RRIGHT~ pour annuler.',
    ['click_sell'] = 'Appui sur ~INPUT_CONTEXT~ pour vendre tous les minerais.',
    ['someone_close'] = 'Il y a une personne très proche!',
    ['mining_blip'] = 'Mine',
    ['you_sold'] = 'Tu as vendu %sx %s pour %s €',
    ['sell_mine'] = 'Vente de Minerais'
}