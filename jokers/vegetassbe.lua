
SMODS.Joker{ --[Blue Evolution] Vegeta
    key = "vegetassbe",
    config = {
        extra = {
            vegetachips = 450,
            vegetamult = 25,
            vegetaxmult = 1,
            vegetat3 = 0
        }
    },
    loc_txt = {
        ['name'] = '[Blue Evolution] Vegeta',
        ['text'] = {
            [1] = 'Gain {C:blue}+30{} Chips, {C:red}+10{} Mult and {X:red,C:white}X0.1{}',
            [2] = 'Mult when a {C:attention}face{} card is scored',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{}{C:inactive} Chips,{}',
            [4] = '{C:red}+#2#{} {C:inactive} Mult and{} {X:mult,C:white}X#3#{}{C:inactive} Mult){}',
            [5] = '',
            [6] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#4#{}{C:inactive}/30 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 10,
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
        y = 1
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' and args.source ~= 'rta' and args.source ~= 'uta' and args.source ~= 'wra' 
            or args.source == 'rif' or args.source == 'sou'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.vegetachips, card.ability.extra.vegetamult, card.ability.extra.vegetaxmult, card.ability.extra.vegetat3}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.vegetachips,
                extra = {
                    mult = card.ability.extra.vegetamult,
                    extra = {
                        Xmult = card.ability.extra.vegetaxmult
                    }
                }
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.vegetachips = (card.ability.extra.vegetachips) + 30
                card.ability.extra.vegetamult = (card.ability.extra.vegetamult) + 10
                card.ability.extra.vegetaxmult = (card.ability.extra.vegetaxmult) + 0.1
                return {
                    message = "Break my limits...",
                    extra = {
                        message = "In my own way!",
                        colour = G.C.GREEN,
                        extra = {
                            message = "On my own terms!",
                            colour = G.C.GREEN
                        }
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.vegetat3 = (card.ability.extra.vegetat3) + 1
                    return true
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.vegetat3 or 0)) >= to_big(30) then
                return {
                    func = function()
                        local target_joker = card
                        
                        if target_joker then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_vegetaue' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "This power, its intoxicating!", colour = G.C.BLUE})
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
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Tch! Weakling...", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_vegeta = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_vegetassbe" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_vegetassbe" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end