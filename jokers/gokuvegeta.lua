
SMODS.Joker{ --Goku & Vegeta
    key = "gokuvegeta",
    config = {
        extra = {
            gvmult = 1,
            gvt = 0,
            xmult0 = 1.25
        }
    },
    loc_txt = {
        ['name'] = 'Goku & Vegeta',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X0.25{} Mult when {C:attention}Blind{} is selected.',
            [2] = 'Scored {C:attention}face{} cards give {X:red,C:white}X1.25{} Mult.',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}',
            [4] = '',
            [5] = '{C:inactive}({C:attention}Transforms{} in {C:attention}#2#{}{C:inactive}/3 Rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 5
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 3,
        y = 5
    },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_no_gv
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.gvmult, card.ability.extra.gvt}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_face() then
                return {
                    Xmult = 1.25
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.gvmult = (card.ability.extra.gvmult) + 0.25
                    return true
                end,
                message = "Getting excited!",
                extra = {
                    func = function()
                        card.ability.extra.gvt = (card.ability.extra.gvt) + 1
                        return true
                    end,
                    colour = G.C.GREEN
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.gvt or 0)) >= to_big(3) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_gvss' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "HAAA!!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.gvmult
            }
        end
    end
}