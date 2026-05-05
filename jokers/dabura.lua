
SMODS.Joker{ --Dabura
    key = "dabura",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Dabura',
        ['text'] = {
            [1] = '{C:attention}First{} and {C:attention}last{} scored',
            [2] = 'cards become {C:attention}Stone{} cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
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
            if (context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[#context.scoring_hand]) then
                local scored_card = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        scored_card:set_ability(G.P_CENTERS.m_stone)
                        card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Petrify!", colour = G.C.ORANGE})
                        return true
                    end
                }))
            end
        end
    end
}