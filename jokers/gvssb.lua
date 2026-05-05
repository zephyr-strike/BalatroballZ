
SMODS.Joker{ --[Super Saiyan Blue] Goku & Vegeta
    key = "gvssb",
    config = {
        extra = {
            gvmult = 21,
            gvt = 0,
            gvchip = 2.25,
            xchips0 = 2,
            xmult0 = 3
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan Blue] Goku & Vegeta',
        ['text'] = {
            [1] = 'Gain {X:blue,C:white}X1{} Chips and {X:red,C:white}X2{} Mult',
            [2] = 'when {C:attention}Blind{} is selected.',
            [3] = 'Scored {C:attention}face{} cards give',
            [4] = '{X:blue,C:white}X2{} Chips and {X:red,C:white}X3{} Mult.',
            [5] = '{C:inactive}(Currently{} {X:blue,C:white}X#3#{} {C:inactive}Chips and{} {X:red,C:white}X#1#{} {C:inactive}Mult){}',
            [6] = '',
            [7] = '{C:inactive}({C:attention}Transforms{} in {C:attention}#2#{}{C:inactive}/5 Rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 6
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "dbz_transformed",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 5,
        y = 6
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
        
        return {vars = {card.ability.extra.gvmult, card.ability.extra.gvt, card.ability.extra.gvchip}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_face() then
                return {
                    x_chips = 2,
                    extra = {
                        Xmult = 3
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.gvmult = (card.ability.extra.gvmult) + 2
                    return true
                end,
                message = "Break through...",
                extra = {
                    func = function()
                        card.ability.extra.gvchip = (card.ability.extra.gvchip) + 1
                        return true
                    end,
                    message = "...the limit!",
                    colour = G.C.GREEN,
                    extra = {
                        func = function()
                            card.ability.extra.gvt = (card.ability.extra.gvt) + 1
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.gvt or 0)) >= to_big(5) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_gvuioevo' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "The power of trust!", colour = G.C.BLUE})
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
                x_chips = card.ability.extra.gvchip,
                extra = {
                    Xmult = card.ability.extra.gvmult
                }
            }
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Looks like we had our limits...", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_gv = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_gvssb" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_gvssb" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end