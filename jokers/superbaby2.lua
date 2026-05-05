
SMODS.Joker{ --Super Baby 2
    key = "superbaby2",
    config = {
        extra = {
            babymult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Super Baby 2',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.1{} Mult when a',
            [2] = '{C:attention}numbered{} card is scored. Played',
            [3] = '{C:attention}face{} cards are {C:red}destroyed{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.babymult}}
    end,
    
    calculate = function(self, card, context)
        if context.destroy_card and context.destroy_card.should_destroy  then
            return { remove = true }
        end
        if context.individual and context.cardarea == G.play  then
            context.other_card.should_destroy = false
            if not (context.other_card:is_face()) then
                card.ability.extra.babymult = (card.ability.extra.babymult) + 0.1
            elseif context.other_card:is_face() then
                context.other_card.should_destroy = true
                return {
                    message = "Tuffles Reign!"
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.babymult
            }
        end
    end
}