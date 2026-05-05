
SMODS.Joker{ --Jeice & Burter
    key = "jeiceburter",
    config = {
        extra = {
            odds = 2,
            repetitions0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Jeice & Burter',
        ['text'] = {
            [1] = '{C:green}1 in 2{} chance to {C:attention}retrigger{}',
            [2] = 'scored {C:clubs}Clubs{} {C:attention}twice{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 9
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_jeiceburter') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Clubs") then
                if SMODS.pseudorandom_probability(card, 'group_0_9fe52fa7', 1, card.ability.extra.odds, 'j_dbz_jeiceburter', false) then
                    
                    return {repetitions = 2}
                end
            end
        end
    end
}