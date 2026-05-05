
SMODS.Joker{ --[Super Saiyan] Son Goku
    key = "gokuss",
    config = {
        extra = {
            xmult = 1.75,
            gokut2 = 0
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan] Son Goku',
        ['text'] = {
            [1] = 'When {C:attention}Big Blind{} or {C:attention}Boss Blind{} is',
            [2] = 'selected, gain {X:red,C:white}X0.59{} Mult{}',
            [3] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#2#{}{C:inactive}/9 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 3,
        y = 0
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'wra' 
            or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.xmult, card.ability.extra.gokut2}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if not (G.GAME.blind:get_type() == 'Small') then
                return {
                    func = function()
                        card.ability.extra.xmult = (card.ability.extra.xmult) + 0.59
                        return true
                    end,
                    message = "Gonna pay..."
                }
            elseif not ((G.GAME.pool_flags.dbz_no_goku or false)) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Ally to good! Nightmare to you!", colour = G.C.BLUE})
                        G.GAME.pool_flags.dbz_no_goku = true
                        return true
                    end
                }))
            else
                return {
                    func = function()
                        card.ability.extra.gokut2 = (card.ability.extra.gokut2) + 1
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
            if to_big((card.ability.extra.gokut2 or 0)) >= to_big(9) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_gokussb' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Ill show you a neat trick!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "See ya!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_goku = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_gokuss" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_gokuss" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end