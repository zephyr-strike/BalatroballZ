
SMODS.Joker{ --Cell Max
    key = "cellmax",
    config = {
        extra = {
            cellmaxbal = 0,
            scale0 = 1,
            rotation0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Cell Max',
        ['text'] = {
            [1] = 'When {C:attention}5 Overdrive{} Cards are held',
            [2] = 'or scored, {C:attention}Balance{} next hand\'s',
            [3] = '{C:blue}Chips{} and {C:red}Mult{}',
            [4] = '{C:inactive}(Currently {}{C:attention}#1#{}{C:inactive}/5){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_dbz_overdrive"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_dbz_overdrive\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.cellmaxbal}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true then
                card.ability.extra.cellmaxbal = (card.ability.extra.cellmaxbal) + 1
            end
        end
        if context.individual and context.cardarea == G.hand and not context.end_of_round  and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_dbz_overdrive"] == true then
                return {
                    func = function()
                        card.ability.extra.cellmaxbal = (card.ability.extra.cellmaxbal) + 1
                        return true
                    end
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  and not context.blueprint then
            if to_big((card.ability.extra.cellmaxbal or 0)) >= to_big(5) then
                card.ability.extra.cellmaxbal = 0
                return {
                    balance = true,
                    message = "URAAAAAHH!"
                }
            end
        end
        if context.after and context.cardarea == G.jokers  and not context.blueprint then
            if to_big((card.ability.extra.cellmaxbal or 0)) >= to_big(5) then
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
            end
        end
    end
}