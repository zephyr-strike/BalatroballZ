
SMODS.Joker{ --Merged Zamasu
    key = "mergedzamasu",
    config = {
        extra = {
            slot_change = '1',
            zamasut = 0
        }
    },
    loc_txt = {
        ['name'] = 'Merged Zamasu',
        ['text'] = {
            [1] = 'Creates a random {C:spectral}Spectral{} card',
            [2] = 'when {C:attention}Blind{} is selected.',
            [3] = '{C:attention}+1{} Consumable slots',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/6 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
    rarity = "dbz_fusion",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true, ["dbz_fusionpack"] = true },
    soul_pos = {
        x = 7,
        y = 13
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_zamasu
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.zamasut}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.zamasut or 0)) >= to_big(7) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_zamasucm' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "My tears shall sanctify this blighted world!", colour = G.C.BLUE})
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
                    card.ability.extra.zamasut = (card.ability.extra.zamasut) + 1
                    return true
                end,
                extra = {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Spectral', })                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                        end
                        return true
                    end,
                    colour = G.C.SECONDARY_SET.Spectral
                }
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true
        end }))
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
            return true
        end }))
    end
}