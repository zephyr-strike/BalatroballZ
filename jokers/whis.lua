
SMODS.Joker{ --Whis
    key = "whis",
    config = {
        extra = {
            whisplanet = 0,
            scale0 = 1,
            rotation0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Whis',
        ['text'] = {
            [1] = 'When 2 {C:attention}Blinds{} are defeated, create',
            [2] = 'a {C:diamonds}Beerus Planet{} when {C:attention}Blind{} is selected',
            [3] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/2){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["c_dbz_beerusplanet"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_dbz_beerusplanet\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.whisplanet}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.whisplanet or 0)) >= to_big(2) then
                local target_card = context.other_card
                local function juice_card_until_(card, eval_func, first, delay) -- balatro function doesn't allow for custom scale and rotation
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',delay = delay or 0.1, blocking = false, blockable = false, timer = 'REAL',
                    func = (function() if eval_func(card) then if not first or first then card:juice_up(1, 1) end;juice_card_until_(card, eval_func, nil, 0.8) end return true end)
                    }))
                end
                return {
                    func = function()
                    local eval = function() return not G.RESET_JIGGLES end
                        juice_card_until_(card, eval, true)
                        return true
                    end
                }
            else
                return {
                    func = function()
                        card.ability.extra.whisplanet = (card.ability.extra.whisplanet) + 1
                        return true
                    end
                }
            end
        end
        if context.setting_blind  then
            if to_big((card.ability.extra.whisplanet or 0)) >= to_big(2) then
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    play_sound('timpani')
                                    SMODS.add_card({ set = 'training_grounds', key = 'c_dbz_beerusplanet'})                            
                                    card:juice_up(0.3, 0.5)
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Perhaps I could train you...", colour = G.C.PURPLE})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.whisplanet = 0
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
    end
}