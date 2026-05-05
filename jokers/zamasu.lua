
SMODS.Joker{ --Zamasu
    key = "zamasu",
    config = {
        extra = {
            zamasuseal = 0,
            odds = 2,
            odds2 = 2,
            odds3 = 2,
            odds4 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Zamasu',
        ['text'] = {
            [1] = 'When a playing card is {C:red}destroyed{},',
            [2] = '{C:green}1 in 2{} chance to create a',
            [3] = '{C:attention}random{} {C:spectral}Seal{} {C:spectral}Spectral{} card',
            [4] = '{C:inactive}(Must have room){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["c_deja_vu"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_deja_vu\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_1 = G.P_CENTERS["c_medium"]
        if info_queue_1 then
            info_queue[#info_queue + 1] = info_queue_1
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_medium\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_2 = G.P_CENTERS["c_trance"]
        if info_queue_2 then
            info_queue[#info_queue + 1] = info_queue_2
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_trance\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local info_queue_3 = G.P_CENTERS["c_talisman"]
        if info_queue_3 then
            info_queue[#info_queue + 1] = info_queue_3
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"c_talisman\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_zamasu')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_dbz_zamasu')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds3, 'j_dbz_zamasu')
        local new_numerator4, new_denominator4 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds4, 'j_dbz_zamasu')
        return {vars = {card.ability.extra.zamasuseal, new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3, new_numerator4, new_denominator4}}
    end,
    
    calculate = function(self, card, context)
        if context.remove_playing_cards  and not context.blueprint then
            if to_big((card.ability.extra.zamasuseal or 0)) == to_big(1) then
                return {
                    func = function()
                        card.ability.extra.zamasuseal = pseudorandom('RANGE:1|4', 1, 4)
                        return true
                    end
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_8687943f', 1, card.ability.extra.odds, 'j_dbz_zamasu', false) then
                            SMODS.calculate_effect({func = function()
                                
                                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.4,
                                        func = function()
                                            play_sound('timpani')
                                            SMODS.add_card({ set = 'Spectral', key = 'c_deja_vu'})                            
                                            card:juice_up(0.3, 0.5)
                                            return true
                                        end
                                    }))
                                end
                                delay(0.6)
                                
                                if created_consumable then
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Extinguish all life!", colour = G.C.SECONDARY_SET.Spectral})
                                end
                                return true
                            end}, card)
                        end
                        return true
                    end
                }
            elseif to_big((card.ability.extra.zamasuseal or 0)) == to_big(2) then
                return {
                    func = function()
                        card.ability.extra.zamasuseal = pseudorandom('RANGE:1|4', 1, 4)
                        return true
                    end
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_4ba9e603', 1, card.ability.extra.odds, 'j_dbz_zamasu', false) then
                            SMODS.calculate_effect({func = function()
                                
                                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.4,
                                        func = function()
                                            play_sound('timpani')
                                            SMODS.add_card({ set = 'Spectral', key = 'c_medium'})                            
                                            card:juice_up(0.3, 0.5)
                                            return true
                                        end
                                    }))
                                end
                                delay(0.6)
                                
                                if created_consumable then
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Enact our plan...", colour = G.C.SECONDARY_SET.Spectral})
                                end
                                return true
                            end}, card)
                        end
                        return true
                    end
                }
            elseif to_big((card.ability.extra.zamasuseal or 0)) == to_big(3) then
                return {
                    func = function()
                        card.ability.extra.zamasuseal = pseudorandom('RANGE:1|4', 1, 4)
                        return true
                    end
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_cd64bc87', 1, card.ability.extra.odds, 'j_dbz_zamasu', false) then
                            SMODS.calculate_effect({func = function()
                                
                                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.4,
                                        func = function()
                                            play_sound('timpani')
                                            SMODS.add_card({ set = 'Spectral', key = 'c_trance'})                            
                                            card:juice_up(0.3, 0.5)
                                            return true
                                        end
                                    }))
                                end
                                delay(0.6)
                                
                                if created_consumable then
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Bow before a god!", colour = G.C.SECONDARY_SET.Spectral})
                                end
                                return true
                            end}, card)
                        end
                        return true
                    end
                }
            elseif to_big((card.ability.extra.zamasuseal or 0)) == to_big(3) then
                return {
                    func = function()
                        card.ability.extra.zamasuseal = pseudorandom('RANGE:1|4', 1, 4)
                        return true
                    end
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_c70057a7', 1, card.ability.extra.odds, 'j_dbz_zamasu', false) then
                            SMODS.calculate_effect({func = function()
                                
                                for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 0.4,
                                        func = function()
                                            play_sound('timpani')
                                            SMODS.add_card({ set = 'Spectral', key = 'c_talisman'})                            
                                            card:juice_up(0.3, 0.5)
                                            return true
                                        end
                                    }))
                                end
                                delay(0.6)
                                
                                if created_consumable then
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Enact our plan...", colour = G.C.SECONDARY_SET.Spectral})
                                end
                                return true
                            end}, card)
                        end
                        return true
                    end
                }
            end
        end
    end
}