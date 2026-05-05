
SMODS.Joker{ --Gamma 1 & 2
    key = "gammas",
    config = {
        extra = {
            chips0 = 10,
            mult0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'Gamma 1 & 2',
        ['text'] = {
            [1] = '{C:attention}First{} and {C:attention}second{} scored {C:attention}Overdrive{}',
            [2] = 'cards give {C:blue}+10{} Chips and {C:red}+5{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_dbz_overdrive"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_dbz_overdrive\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if (SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true and context.other_card == context.scoring_hand[1] or SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true and context.other_card == context.scoring_hand[2]) then
                return {
                    chips = 10,
                    extra = {
                        mult = 5
                    }
                }
            end
        end
    end
}