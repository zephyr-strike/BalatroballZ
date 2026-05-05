
SMODS.Joker{ --[Final Form] Frieza
    key = "friezabase",
    config = {
        extra = {
            friezat1 = 0
        }
    },
    loc_txt = {
        ['name'] = '[Final Form] Frieza',
        ['text'] = {
            [1] = 'Create a {C:tarot}The Emperor{} when',
            [2] = '{C:attention}Small Blind{} is defeated',
            [3] = '{C:inactive}(Must have room){}',
            [4] = '',
            [5] = '{C:inactive}({}{C:attention}Transforms{} {C:inactive}in{} {C:attention}#1#{}{C:inactive}/5 rounds){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 4
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 7,
        y = 4
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'rta' and args.source ~= 'wra' 
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'sou' or args.source == 'uta'
        )
        and not G.GAME.pool_flags.dbz_no_frieza
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["c_emperor"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_emperor\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.friezat1}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.GAME.blind:get_type() == 'Small' then
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
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Bow before Lord Frieza!", colour = G.C.PURPLE})
                        end
                        return true
                    end
                }
            elseif to_big((card.ability.extra.friezat1 or 0)) >= to_big(5) then
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
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_friezafp' })
                                    if joker_card then
                                        
                                        
                                    end
                                    
                                    return true
                                end
                            }))
                            
                            if created_joker then
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "100%!", colour = G.C.BLUE})
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
                    card.ability.extra.friezat1 = (card.ability.extra.friezat1) + 1
                    return true
                end
            }
        end
    end
}