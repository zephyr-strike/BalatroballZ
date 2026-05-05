
SMODS.Joker{ --[Wrathful] Broly
    key = "broly",
    config = {
        extra = {
            brolyxmult = 1,
            brolyt1 = 0
        }
    },
    loc_txt = {
        ['name'] = '[Wrathful] Broly',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X1.5{} Mult for',
            [2] = 'each played hand that {C:attention}doesn\'t win{}.',
            [3] = 'Resets when {C:attention}Blind{} is defeated',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}',
            [5] = '',
            [6] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#2#{}{C:inactive}/15 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 7,
        y = 1
    },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_broly
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.brolyxmult, card.ability.extra.brolyt1}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.brolyt1 or 0)) >= to_big(15) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_brolyfpss' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "RAAAAAAHHH!!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            else
                return {
                    func = function()
                        card.ability.extra.brolyxmult = 1
                        return true
                    end,
                    message = "Grrr...."
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.brolyxmult
            }
        end
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(0.01) and to_big(G.GAME.chips / G.GAME.blind.chips) < to_big(1)) then
                return {
                    func = function()
                        card.ability.extra.brolyxmult = (card.ability.extra.brolyxmult) + 1.5
                        return true
                    end,
                    message = "GRAAAAHH!!"
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.brolyt1 = (card.ability.extra.brolyt1) + 1
                    return true
                end
            }
        end
    end
}