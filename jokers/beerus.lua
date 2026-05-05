
SMODS.Joker{ --Beerus
    key = "beerus",
    config = {
        extra = {
            beeruschips = 1
        }
    },
    loc_txt = {
        ['name'] = 'Beerus',
        ['text'] = {
            [1] = 'Gains {X:blue,C:white}X0.2{} Chips when a',
            [2] = '{C:attention}Divine{} Card is scored',
            [3] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
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
        
        local info_queue_0 = G.P_CENTERS["m_dbz_divine"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_dbz_divine\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.beeruschips}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_dbz_divine"] == true then
                card.ability.extra.beeruschips = (card.ability.extra.beeruschips) + 0.2
                return {
                    message = "Now then..."
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.beeruschips
            }
        end
    end
}