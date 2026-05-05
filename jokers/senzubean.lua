
SMODS.Joker{ --Senzu Bean
    key = "senzubean",
    config = {
        extra = {
            beanmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Senzu Bean',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult, loses {X:red,C:white}X0.5{}',
            [2] = 'per hand played',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
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
    pools = { ["dbz_bbz"] = true, ["dbz_food_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.beanmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.beanmult
            }
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big((card.ability.extra.beanmult or 0)) == to_big(0) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end
                }
            else
                return {
                    func = function()
                        card.ability.extra.beanmult = math.max(0, (card.ability.extra.beanmult) - 0.5)
                        return true
                    end,
                    message = "*Crunch*"
                }
            end
        end
    end
}