
SMODS.Joker{ --[Power Awakening] Piccolo
    key = "piccolopa",
    config = {
        extra = {
            piccolot1 = 0,
            xmult0 = 1.5
        }
    },
    loc_txt = {
        ['name'] = '[Power Awakening] Piccolo',
        ['text'] = {
            [1] = 'Scored {C:attention}5s{}, {C:attention}7s{} and {C:attention}9s{}',
            [2] = 'give {X:red,C:white}X1.5{} Mult',
            [3] = '',
            [4] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/15 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = "dbz_transformed",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 3,
        y = 4
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.piccolot1}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.piccolot1 or 0)) >= to_big(15) then
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
                                    target_joker:shatter({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            
                            local created_joker = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_piccoloorange' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "All you had, plus a bit extra...", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            else
                return {
                    func = function()
                        card.ability.extra.piccolot1 = (card.ability.extra.piccolot1) + 1
                        return true
                    end
                }
            end
        end
        if context.individual and context.cardarea == G.play  then
            if (context.other_card:get_id() == 5 or context.other_card:get_id() == 7 or context.other_card:get_id() == 9) then
                return {
                    Xmult = 1.5
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Tougher than I thought...", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_piccolo = false
                    return true
                end
            }))
        end
        if context.setting_blind  then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "This wont end the way it did before!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_piccolo = true
                    return true
                end
            }))
        end
    end
}