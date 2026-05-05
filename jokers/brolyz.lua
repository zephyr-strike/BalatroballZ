
SMODS.Joker{ --[Legendary Super Saiyan] Broly
    key = "brolyz",
    config = {
        extra = {
            brolysellmult = 1
        }
    },
    loc_txt = {
        ['name'] = '[Legendary Super Saiyan] Broly',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected, destroy adjacent',
            [2] = '{C:attention}Jokers{} and permanently add {C:attention}20%{} of their',
            [3] = 'sell values to this {X:mult,C:white}XMult{}',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 6,
        y = 12
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.brolysellmult}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    local my_pos = nil
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i] == card then
                            my_pos = i
                            break
                        end
                    end
                    local target_joker = nil
                    if my_pos and my_pos > 1 then
                        local joker = G.jokers.cards[my_pos - 1]
                        if not SMODS.is_eternal(joker) and not joker.getting_sliced then
                            target_joker = joker
                        end
                    end
                    
                    if target_joker then
                        local joker_sell_value = target_joker.sell_cost or 0
                        local sell_value_gain = joker_sell_value * 0.2
                        card.ability.extra.brolysellmult = card.ability.extra.brolysellmult + sell_value_gain
                        target_joker.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                target_joker:explode({G.C.RED}, nil, 1.6)
                                return true
                            end
                        }))
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Die!", colour = G.C.RED})
                    end
                    return true
                end,
                extra = {
                    func = function()
                        local my_pos = nil
                        for i = 1, #G.jokers.cards do
                            if G.jokers.cards[i] == card then
                                my_pos = i
                                break
                            end
                        end
                        local target_joker = nil
                        if my_pos and my_pos < #G.jokers.cards then
                            local joker = G.jokers.cards[my_pos + 1]
                            if not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                target_joker = joker
                            end
                        end
                        
                        if target_joker then
                            local joker_sell_value = target_joker.sell_cost or 0
                            local sell_value_gain = joker_sell_value * 0.2
                            card.ability.extra.brolysellmult = card.ability.extra.brolysellmult + sell_value_gain
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:explode({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Die!", colour = G.C.RED})
                        end
                        return true
                    end,
                    colour = G.C.RED
                }
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.brolysellmult
            }
        end
    end
}