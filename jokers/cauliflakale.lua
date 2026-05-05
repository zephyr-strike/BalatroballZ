
SMODS.Joker{ --[Super Saiyan 2] Caulifla & Kale
    key = "cauliflakale",
    config = {
        extra = {
            odds = 2,
            levels0 = 1
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan 2] Caulifla & Kale',
        ['text'] = {
            [1] = 'When a {C:attention}Pair{} is played, {C:green}1 in 2{}',
            [2] = 'chance to upgrade {C:attention}Pair{} by {C:attention}1{} level'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 7
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_cauliflakale') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if context.scoring_name == "Pair" then
                if SMODS.pseudorandom_probability(card, 'group_0_34c0901f', 1, card.ability.extra.odds, 'j_dbz_cauliflakale', false) then
                    local target_hand = "Pair"
                    level_up_hand(card, target_hand, true, 1)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "The strongest Saiyans around!", colour = G.C.RED})
                end
            end
        end
    end
}