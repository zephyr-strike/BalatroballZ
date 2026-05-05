
SMODS.Joker{ --Hercule
    key = "hercule",
    config = {
        extra = {
            herculeactive = 0,
            scale0 = 1,
            rotation0 = 1,
            shop_slots0 = 1,
            voucher_slots0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Hercule',
        ['text'] = {
            [1] = 'After {C:attention}5{} rounds, sell this Joker to gain',
            [2] = '{C:attention}+1{} Shop Slots and {C:attention}+1{} Booster Slots',
            [3] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/5){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.herculeactive}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if to_big((card.ability.extra.herculeactive or 0)) >= to_big(5) then
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
                        card.ability.extra.herculeactive = (card.ability.extra.herculeactive) + 1
                        return true
                    end
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            if to_big((card.ability.extra.herculeactive or 0)) >= to_big(5) then
                return {
                    
                    func = function()
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Im the Champ!", colour = G.C.BLUE})
                        
                        change_shop_size(1)
                        return true
                    end,
                    extra = {
                        
                        func = function()
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Voucher Slots", colour = G.C.BLUE})
                            
                            SMODS.change_voucher_limit(1)
                            return true
                        end,
                        colour = G.C.WHITE
                    }
                }
            end
        end
    end
}