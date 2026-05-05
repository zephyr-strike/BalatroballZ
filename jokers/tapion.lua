
SMODS.Joker{ --Tapion
    key = "tapion",
    config = {
        extra = {
            repetitions0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Tapion',
        ['text'] = {
            [1] = 'Retrigger {C:attention}played{} {C:attention}Steel{}',
            [2] = 'Cards {C:attention}3{} times'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_steel"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_steel\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_steel"] == true then
                return {
                    repetitions = 3,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}