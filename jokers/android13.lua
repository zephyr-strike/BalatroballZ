
SMODS.Joker{ --Android 13
    key = "android13",
    config = {
        extra = {
            a13 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Android 13',
        ['text'] = {
            [1] = 'Gains {X:blue,C:white}X0.13{} Chips and {X:red,C:white}X0.13{} Mult when',
            [2] = 'an {C:attention}Overdrive{} Card is held or scored',
            [3] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips and{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 8
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
        
        local info_queue_0 = G.P_CENTERS["m_dbz_overdrive"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_dbz_overdrive\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.a13}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.a13,
                extra = {
                    Xmult = card.ability.extra.a13
                }
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true then
                card.ability.extra.a13 = (card.ability.extra.a13) + 0.13
                return {
                    message = "13 is your lucky number!"
                }
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true then
                return {
                    func = function()
                        card.ability.extra.a13 = (card.ability.extra.a13) + 0.13
                        return true
                    end
                }
            end
        end
    end
}