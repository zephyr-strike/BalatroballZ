
SMODS.Joker{ --[Super Saiyan] Future Trunks
    key = "trunksss",
    config = {
        extra = {
            blind_size0 = 0.8
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan] Future Trunks',
        ['text'] = {
            [1] = 'Decreases {C:attention}Blind{} requirement by {C:attention}20%{}. Creates a',
            [2] = '{C:dark_edition}Negative{} {C:tarot}Justice{} when {C:attention}Blind{} is selected'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "dbz_transformed",
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 9,
        y = 3
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
        
        local info_queue_0 = G.P_CENTERS["c_justice"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_justice\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if not ((G.GAME.pool_flags.dbz_no_trunks or false)) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "...Theres another one, right here!", colour = G.C.BLUE})
                        G.GAME.pool_flags.dbz_no_trunks = true
                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("slice1")
                        
                        return true
                    end,
                }))
                return {
                    
                    func = function()
                        if G.GAME.blind.in_blind then
                            
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Take this!", colour = G.C.GREEN})
                            G.GAME.blind.chips = G.GAME.blind.chips * 0.8
                            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                            G.HUD_blind:recalculate()
                            return true
                        end
                    end,
                    extra = {
                        func = function()
                            
                            for i = 1, 1 do
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.4,
                                    func = function()
                                        if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                        end
                                        
                                        play_sound('timpani')
                                        SMODS.add_card({ set = 'Tarot', edition = 'e_negative', key = 'c_justice'})                            
                                        card:juice_up(0.3, 0.5)
                                        return true
                                    end
                                }))
                            end
                            delay(0.6)
                            
                            if created_consumable then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                            end
                            return true
                        end,
                        colour = G.C.PURPLE
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
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Farewell!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_trunks = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_trunksss" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_trunksss" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end