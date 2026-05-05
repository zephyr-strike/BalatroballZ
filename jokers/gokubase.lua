
SMODS.Joker{ --Son Goku
    key = "gokubase",
    config = {
        extra = {
            xmult = 1,
            gokut1 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Son Goku',
        ['text'] = {
            [1] = 'When {C:attention}Big Blind{} or {C:attention}Boss Blind{} is',
            [2] = 'selected, gain {X:red,C:white}X0.25{} Mult{}',
            [3] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#2#{}{C:inactive}/5 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
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
        y = 0
    },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_goku
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.gokut1}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if not (G.GAME.blind:get_type() == 'Small') then
                return {
                    func = function()
                        card.ability.extra.xmult = (card.ability.extra.xmult) + 0.25
                        return true
                    end,
                    message = "Getting excited!"
                }
            else
                return {
                    func = function()
                        card.ability.extra.gokut1 = (card.ability.extra.gokut1) + 1
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.gokut1 or 0)) >= to_big(5) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_gokuss' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "I am the Super Saiyan, SON GOKU!", colour = G.C.BLUE})
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