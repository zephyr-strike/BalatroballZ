
SMODS.Joker{ --Super 17
    key = "super17",
    config = {
        extra = {
            super17 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Super 17',
        ['text'] = {
            [1] = 'When an {C:attention}Overdrive{} card is {C:attention}scored{},',
            [2] = 'removes card {C:attention}Enhancement{}{}',
            [3] = 'and gain {X:blue,C:white}X1.7{} Chips',
            [4] = '{C:inactive}(Currently{} {X:blue,C:white}X#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 10
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
        return {vars = {card.ability.extra.super17}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if (function()
                local enhancements = SMODS.get_enhancements(context.other_card)
                for k, v in pairs(enhancements) do
                    if v then
                        return true
                    end
                end
                return false
            end)() then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        scored_card:set_ability(G.P_CENTERS.c_base)
                        card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Ha Ha!", colour = G.C.ORANGE})
                        return true
                    end
                }))
                card.ability.extra.super17 = (card.ability.extra.super17) + 1.7
                return {
                    message = "No-one can beat me when Im Super 17!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                x_chips = card.ability.extra.super17
            }
        end
    end
}