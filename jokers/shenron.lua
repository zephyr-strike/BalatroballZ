
SMODS.Joker{ --Shenron
    key = "shenron",
    config = {
        extra = {
            odds = 7,
            chips0 = 70,
            xchips0 = 1.7,
            mult0 = 7,
            xmult0 = 1.7,
            dollars0 = 7,
            echips0 = 1.07,
            emult0 = 1.07
        }
    },
    loc_txt = {
        ['name'] = 'Shenron',
        ['text'] = {
            [1] = 'When hand is played, {C:green}1 in 7 chance{}',
            [2] = 'for each of the following {C:attention}effects{}:',
            [3] = '{C:blue}+70{} Chips, {C:red}+7{} Mult, {X:blue,C:white}X1.7{} Chips,',
            [4] = '{X:red,C:white}X1.7{} Mult, {X:spectral,C:white}^1.07{} Chips, {X:spectral,C:white}^1.07{} Mult,',
            [5] = 'and/or {C:money}$7{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 10
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_shenron')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_dbz_shenron')
        local new_numerator3, new_denominator3 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds3, 'j_dbz_shenron')
        local new_numerator4, new_denominator4 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds4, 'j_dbz_shenron')
        local new_numerator5, new_denominator5 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds5, 'j_dbz_shenron')
        local new_numerator6, new_denominator6 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds6, 'j_dbz_shenron')
        local new_numerator7, new_denominator7 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds7, 'j_dbz_shenron')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2, new_numerator3, new_denominator3, new_numerator4, new_denominator4, new_numerator5, new_denominator5, new_numerator6, new_denominator6, new_numerator7, new_denominator7}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_7e6114d7', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                    SMODS.calculate_effect({chips = 70}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_296c31a9', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                    SMODS.calculate_effect({x_chips = 1.7}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_2_f519ce29', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                    SMODS.calculate_effect({mult = 7}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_3_401ebd2c', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                    SMODS.calculate_effect({Xmult = 1.7}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_4_53c29743', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                    SMODS.calculate_effect({
                        func = function()
                            
                            local current_dollars = G.GAME.dollars
                            local target_dollars = G.GAME.dollars + 7
                            local dollar_value = target_dollars - current_dollars
                            ease_dollars(dollar_value)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(7), colour = G.C.MONEY})
                            return true
                        end}, card)
                    end
                    if SMODS.pseudorandom_probability(card, 'group_5_6d208b63', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                        SMODS.calculate_effect({e_chips = 1.07}, card)
                    end
                    if SMODS.pseudorandom_probability(card, 'group_6_34b42df5', 1, card.ability.extra.odds, 'j_dbz_shenron', false) then
                        SMODS.calculate_effect({e_mult = 1.07}, card)
                    end
                end
            end
        end
    }