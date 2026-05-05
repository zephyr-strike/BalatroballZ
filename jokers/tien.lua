
SMODS.Joker{ --Tien
    key = "tien",
    config = {
        extra = {
            tienchips = 0,
            hands0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Tien',
        ['text'] = {
            [1] = '{C:blue}+2{} Hands. {C:blue}+3{} Chips',
            [2] = 'for every hand played',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 8
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
        
        return {vars = {card.ability.extra.tienchips}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            card.ability.extra.tienchips = (card.ability.extra.tienchips) + 3
            return {
                chips = card.ability.extra.tienchips
            }
        end
        if context.setting_blind  and not context.blueprint then
            return {
                
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Four witches!", colour = G.C.GREEN})
                    
                    G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 2
                    return true
                end
            }
        end
    end
}