
SMODS.Joker{ --Farmer with a Shotgun
    key = "farmershotgun",
    config = {
        extra = {
            odds = 5,
            dollars0 = 5
        }
    },
    loc_txt = {
        ['name'] = 'Farmer with a Shotgun',
        ['text'] = {
            [1] = 'Played {C:spades}Spades{} have a',
            [2] = '{C:green}1 in 5{} chance to give {C:money}$5{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_farmershotgun') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Spades") then
                if SMODS.pseudorandom_probability(card, 'group_0_bf6233ee', 1, card.ability.extra.odds, 'j_dbz_farmershotgun', false) then
                    SMODS.calculate_effect({
                        func = function()
                            
                            local current_dollars = G.GAME.dollars
                            local target_dollars = G.GAME.dollars + 5
                            local dollar_value = target_dollars - current_dollars
                            ease_dollars(dollar_value)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(5), colour = G.C.MONEY})
                            return true
                        end}, card)
                    end
                end
            end
        end
    }