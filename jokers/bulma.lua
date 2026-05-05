
SMODS.Joker{ --Bulma
    key = "bulma",
    config = {
        extra = {
            bulmadragonballs = 0,
            bulmarandomiser = 1,
            dollars0 = 150,
            joker_slots0 = 1,
            levels0 = 20,
            odds = 7
        }
    },
    loc_txt = {
        ['name'] = 'Bulma',
        ['text'] = {
            [1] = '{C:green}1 in 7{} chance to {C:attention}collect{} a Dragonball',
            [2] = 'when {C:attention}Blind{} is defeated. Once {C:attention}7{}',
            [3] = 'Dragonballs have been collected,',
            [4] = 'does {C:attention}one{} of the following:',
            [5] = '{C:attention}+1{} Joker slot, {C:money}$150{}, level up {C:attention}most',
            [6] = 'played{} Poker Hand {C:attention}20{} times',
            [7] = '{C:inactive}(Currently{} {C:attention}#1#{}{C:inactive}/7){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 11
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_bulma') 
        return {vars = {card.ability.extra.bulmadragonballs, card.ability.extra.bulmarandomiser, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if (to_big((card.ability.extra.bulmadragonballs or 0)) >= to_big(7) and to_big((card.ability.extra.bulmarandomiser or 0)) == to_big(2)) then
                return {
                    func = function()
                        card.ability.extra.bulmadragonballs = 0
                        return true
                    end,
                    message = "I wish for wealth!",
                    extra = {
                        func = function()
                            card.ability.extra.bulmarandomiser = pseudorandom('RANGE:1|3', 1, 3)
                            return true
                        end,
                        colour = G.C.BLUE,
                        extra = {
                            
                            func = function()
                                
                                local current_dollars = G.GAME.dollars
                                local target_dollars = G.GAME.dollars + 150
                                local dollar_value = target_dollars - current_dollars
                                ease_dollars(dollar_value)
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(150), colour = G.C.MONEY})
                                return true
                            end,
                            colour = G.C.MONEY
                        }
                    }
                }
            elseif (to_big((card.ability.extra.bulmadragonballs or 0)) >= to_big(7) and to_big((card.ability.extra.bulmarandomiser or 0)) == to_big(3)) then
                return {
                    func = function()
                        card.ability.extra.bulmadragonballs = 0
                        return true
                    end,
                    message = "I wish for allies!",
                    extra = {
                        func = function()
                            card.ability.extra.bulmarandomiser = pseudorandom('RANGE:1|3', 1, 3)
                            return true
                        end,
                        colour = G.C.BLUE,
                        extra = {
                            func = function()
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1).." Joker Slot", colour = G.C.DARK_EDITION})
                                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                                return true
                            end,
                            colour = G.C.DARK_EDITION
                        }
                    }
                }
            elseif (to_big((card.ability.extra.bulmadragonballs or 0)) >= to_big(7) and to_big((card.ability.extra.bulmarandomiser or 0)) == to_big(1)) then
                local temp_played = 0
                local temp_order = math.huge
                local target_hand
                for hand, value in pairs(G.GAME.hands) do 
                    if value.played > temp_played and value.visible then
                        temp_played = value.played
                        temp_order = value.order
                        target_hand = hand
                    elseif value.played == temp_played and value.visible then
                        if value.order < temp_order then
                            temp_order = value.order
                            target_hand = hand
                        end
                    end
                end
                
                level_up_hand(card, target_hand, true, 20)
                return {
                    func = function()
                        card.ability.extra.bulmadragonballs = 0
                        return true
                    end,
                    message = "I wish for power!",
                    extra = {
                        func = function()
                            card.ability.extra.bulmarandomiser = pseudorandom('RANGE:1|3', 1, 3)
                            return true
                        end,
                        colour = G.C.BLUE,
                        extra = {
                            message = localize('k_level_up_ex'),
                            colour = G.C.RED
                        }
                    }
                }
            elseif true then
                return {
                    func = function()
                        card.ability.extra.bulmarandomiser = pseudorandom('RANGE:1|3', 1, 3)
                        return true
                    end
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_0ae831ca', 1, card.ability.extra.odds, 'j_dbz_bulma', false) then
                            SMODS.calculate_effect({func = function()
                                card.ability.extra.bulmadragonballs = (card.ability.extra.bulmadragonballs) + 1
                                return true
                            end}, card)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Found one!", colour = G.C.GREEN})
                        end
                        return true
                    end
                }
            end
        end
        if context.selling_card  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.bulmadragonballs = 7
                    return true
                end
            }
        end
    end
}