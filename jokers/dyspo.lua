
SMODS.Joker{ --Dyspo
    key = "dyspo",
    config = {
        extra = {
            dyspohand = 0,
            dollars0 = 6
        }
    },
    loc_txt = {
        ['name'] = 'Dyspo',
        ['text'] = {
            [1] = 'If {C:attention}Blind{} is defeated',
            [2] = 'in {C:attention}1{} hand, earn {C:money}$6{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 7
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.dyspohand}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if to_big((card.ability.extra.dyspohand or 0)) == to_big(1) then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + 6
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(6), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if G.GAME.current_round.hands_played == 0 then
                card.ability.extra.dyspohand = 1
            elseif not (G.GAME.current_round.hands_played == 0) then
                card.ability.extra.dyspohand = 0
            end
        end
    end
}