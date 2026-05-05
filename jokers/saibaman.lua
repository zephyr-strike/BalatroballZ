
SMODS.Joker{ --Saibaman
    key = "saibaman",
    config = {
        extra = {
            xmult0 = 10
        }
    },
    loc_txt = {
        ['name'] = 'Saibaman',
        ['text'] = {
            [1] = '{X:red,C:white}X10{} Mult on final hand.',
            [2] = '{C:red}Self destructs{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                local target_joker = card
                
                if target_joker then
                    if target_joker.ability.eternal then
                        target_joker.ability.eternal = nil
                    end
                    target_joker.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            target_joker:explode({G.C.RED}, nil, 1.6)
                            return true
                        end
                    }))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "GYAH!", colour = G.C.RED})
                end
                return {
                    Xmult = 10
                }
            end
        end
    end
}