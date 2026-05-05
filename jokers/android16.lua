
SMODS.Joker{ --Android 16
    key = "android16",
    config = {
        extra = {
            a16chips = 0,
            xmult0 = 1.6
        }
    },
    loc_txt = {
        ['name'] = 'Android 16',
        ['text'] = {
            [1] = '{C:attention}Steel{} Cards give {X:red,C:white}X1.6{} Mult',
            [2] = 'when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.a16chips}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_steel"] == true then
                return {
                    Xmult = 1.6
                }
            end
        end
    end
}