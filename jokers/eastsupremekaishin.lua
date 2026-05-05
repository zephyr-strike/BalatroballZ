
SMODS.Joker{ --East Supreme Kai Shin
    key = "eastsupremekaishin",
    config = {
        extra = {
            xchips0 = 2.5
        }
    },
    loc_txt = {
        ['name'] = 'East Supreme Kai Shin',
        ['text'] = {
            [1] = 'Scored {C:attention}Stone Cards{} give',
            [2] = '{X:blue,C:white}X2.5{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
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
        
        local info_queue_0 = G.P_CENTERS["m_stone"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_stone\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    x_chips = 2.5
                }
            end
        end
    end
}