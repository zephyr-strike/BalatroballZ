
SMODS.Joker{ --Majuub
    key = "majuub",
    config = {
        extra = {
            majuubdisable = 0,
            scale0 = 1,
            rotation0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Majuub',
        ['text'] = {
            [1] = 'After {C:attention}25 Consumables{} are',
            [2] = 'used, disable next {C:attention}Boss Blind{}',
            [3] = '{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/25){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 10
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.majuubdisable}}
    end,
    
    calculate = function(self, card, context)
        if context.first_hand_drawn  and not context.blueprint then
            if (G.GAME.blind.boss and to_big((card.ability.extra.majuubdisable or 0)) >= to_big(25)) then
                return {
                    func = function()
                        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Not a chance!", colour = G.C.GREEN})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.majuubdisable = 0
                            return true
                        end,
                        colour = G.C.BLUE
                    }
                }
            end
        end
        if context.using_consumeable  and not context.blueprint then
            if to_big((card.ability.extra.majuubdisable or 0)) >= to_big(25) then
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
                        card.ability.extra.majuubdisable = (card.ability.extra.majuubdisable) + 1
                        return true
                    end
                }
            end
        end
    end
}