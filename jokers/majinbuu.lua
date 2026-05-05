
SMODS.Joker{ --Majin Buu
    key = "majinbuu",
    config = {
        extra = {
            buumult = 1,
            buut = 0
        }
    },
    loc_txt = {
        ['name'] = 'Majin Buu',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X0.1{} Mult when any',
            [2] = '{C:attention}consumable{} is used',
            [3] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#2#{}{C:inactive}/3 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
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
        x = 1,
        y = 2
    },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_buu
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.buumult, card.ability.extra.buut}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.buumult = (card.ability.extra.buumult) + 0.1
                    return true
                end,
                message = "Yummy!!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.buumult
            }
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.buut = (card.ability.extra.buut) + 1
                    return true
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.buut or 0)) >= to_big(3) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_evilbuu' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "...", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
    end
}