
SMODS.Joker{ --Future Trunks
    key = "trunksbase",
    config = {
        extra = {
            trunkst1 = 0,
            blind_size0 = 0.9
        }
    },
    loc_txt = {
        ['name'] = 'Future Trunks',
        ['text'] = {
            [1] = 'Decreases {C:attention}Blind{} requirement by {C:attention}10%{}',
            [2] = '',
            [3] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/12 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 7,
        y = 3
    },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_trunks
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.trunkst1}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("slice1")
                    
                    return true
                end,
            }))
            return {
                
                func = function()
                    if G.GAME.blind.in_blind then
                        
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "For the future!", colour = G.C.GREEN})
                        G.GAME.blind.chips = G.GAME.blind.chips * 0.9
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.HUD_blind:recalculate()
                        return true
                    end
                end,
                extra = {
                    func = function()
                        card.ability.extra.trunkst1 = (card.ability.extra.trunkst1) + 1
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.trunkst1 or 0)) >= to_big(12) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_trunksss' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Goku isnt the only Super Saiyan...", colour = G.C.BLUE})
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