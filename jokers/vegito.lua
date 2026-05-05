
SMODS.Joker{ --Vegito
    key = "vegito",
    config = {
        extra = {
            vegitot = 0,
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Vegito',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} played {C:attention}Face',
            [2] = 'Cards twice{}',
            [3] = '',
            [4] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/3 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = "dbz_fusion",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true, ["dbz_fusionpack"] = true },
    soul_pos = {
        x = 1,
        y = 14
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_vegito
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.vegitot}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.vegitot or 0)) >= to_big(3) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_vegitoss' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Alright!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.vegitot = (card.ability.extra.vegitot) + 1
                    return true
                end
            }
        end
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:is_face() then
                return {
                    repetitions = 2,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}