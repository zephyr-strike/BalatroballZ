SMODS.Rarity {
    key = "z",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('e76a24'),
    loc_txt = {
        name = "Z"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "transformed",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('fbbc42'),
    loc_txt = {
        name = "Transformed"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Rarity {
    key = "fusion",
    pools = {
        ["Joker"] = true
    },
    default_weight = 0,
    badge_colour = HEX('63ddd1'),
    loc_txt = {
        name = "Fusion"
    },
    get_weight = function(self, weight, object_type)
        return weight
    end,
}