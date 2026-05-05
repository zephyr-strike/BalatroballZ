
SMODS.Joker{ --[Full Power] Frieza
    key = "friezafp",
    config = {
        extra = {
            friezat2 = 0
        }
    },
    loc_txt = {
        ['name'] = '[Full Power] Frieza',
        ['text'] = {
            [1] = 'Create a {C:tarot}The Emperor{}',
            [2] = 'when {C:attention}Blind{} is defeated',
            [3] = '{C:inactive}(Must have room){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/20 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 4
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
        x = 9,
        y = 4
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
        
        local info_queue_0 = G.P_CENTERS["c_emperor"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_emperor\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.friezat2}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if to_big((card.ability.extra.friezat2 or 0)) >= to_big(20) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_friezagolden' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Behold, this is GOLDEN FRIEZA!", colour = G.C.BLUE})
                            end
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            else
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'Tarot', key = 'c_emperor'})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "I am the strongest!", colour = G.C.PURPLE})
                        end
                        return true
                    end
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            if not ((G.GAME.pool_flags.dbz_no_frieza or false)) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "You must die by my hand!", colour = G.C.BLUE})
                        G.GAME.pool_flags.dbz_no_frieza = true
                        return true
                    end
                }))
            else
                return {
                    func = function()
                        card.ability.extra.friezat2 = (card.ability.extra.friezat2) + 1
                        return true
                    end
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "How...?!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_frieza = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_friezafp" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_friezafp" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end