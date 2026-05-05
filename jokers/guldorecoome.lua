
SMODS.Joker{ --Guldo & Recoome
    key = "guldorecoome",
    config = {
        extra = {
            odds = 2,
            xchips0 = 1.5,
            dollars0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Guldo & Recoome',
        ['text'] = {
            [1] = '{C:green}1 in 2{} chance for {C:attention}scored{} {C:clubs}Clubs{}',
            [2] = 'to give {X:blue,C:white}X1.5{} Chips and/or {C:money}$1{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_guldorecoome')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_dbz_guldorecoome')
        return {vars = {new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_0c541de5', 1, card.ability.extra.odds, 'j_dbz_guldorecoome', false) then
                    SMODS.calculate_effect({x_chips = 1.5}, card)
                end
                if SMODS.pseudorandom_probability(card, 'group_1_0f989666', 1, card.ability.extra.odds, 'j_dbz_guldorecoome', false) then
                    SMODS.calculate_effect({
                        func = function()
                            
                            local current_dollars = G.GAME.dollars
                            local target_dollars = G.GAME.dollars + 1
                            local dollar_value = target_dollars - current_dollars
                            ease_dollars(dollar_value)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1), colour = G.C.MONEY})
                            return true
                        end}, card)
                    end
                end
            end
        end
    }