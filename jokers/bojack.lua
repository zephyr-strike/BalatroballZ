
SMODS.Joker{ --Bojack
    key = "bojack",
    config = {
        extra = {
            bojackchip = 0
        }
    },
    loc_txt = {
        ['name'] = 'Bojack',
        ['text'] = {
            [1] = 'Gains {C:blue}+10{} Chips when',
            [2] = 'a {C:planet}Planet{} is used',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.bojackchip}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  and not context.blueprint then
            if context.consumeable and context.consumeable.ability.set == 'Planet' then
                return {
                    func = function()
                        card.ability.extra.bojackchip = (card.ability.extra.bojackchip) + 10
                        return true
                    end,
                    message = "Yarr!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.bojackchip
            }
        end
    end
}