
SMODS.Joker{ --Turles
    key = "turles",
    config = {
        extra = {
            odds = 5,
            odds2 = 20
        }
    },
    loc_txt = {
        ['name'] = 'Turles',
        ['text'] = {
            [1] = 'When {C:attention}Blind{} is selected, {C:green}1 in 5{} chance to',
            [2] = 'create a {C:attention}Fruit of Might{} and {C:green}1 in 20{}',
            [3] = 'chance to {C:red}self destruct{}',
            [4] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 12
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
        
        local info_queue_0 = G.P_CENTERS["j_dbz_fruitofmight"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"j_dbz_fruitofmight\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_turles')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_dbz_turles')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind  and not context.blueprint then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_cc7f0f7c', 1, card.ability.extra.odds, 'j_dbz_turles', false) then
                    SMODS.calculate_effect({func = function()
                        
                        local created_joker = false
                        if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                            created_joker = true
                            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_dbz_fruitofmight' })
                                    if joker_card then
                                        
                                        
                                    end
                                    G.GAME.joker_buffer = 0
                                    return true
                                end
                            }))
                        end
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "The Fruit from the Tree of Might...!", colour = G.C.BLUE})
                        end
                        return true
                    end}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_a4baa85d', 1, card.ability.extra.odds2, 'j_dbz_turles', false) then
                    SMODS.calculate_effect({func = function()
                        local target_joker = card
                        
                        if target_joker then
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:explode({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "GAAAAHHH!!!", colour = G.C.RED})
                        end
                        return true
                    end}, card)
                end
            end
        end
    end
}