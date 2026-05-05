
SMODS.Joker{ --Fruit of Might
    key = "fruitofmight",
    config = {
        extra = {
            hand_size0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Fruit of Might',
        ['text'] = {
            [1] = 'Sell this card to permanently',
            [2] = 'gain {C:attention}+1{} hand size'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = "dbz_z",
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.selling_self  and not context.blueprint then
            return {
                
                func = function()
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "*Munch*", colour = G.C.BLUE})
                    
                    G.hand:change_size(1)
                    return true
                end
            }
        end
    end
}