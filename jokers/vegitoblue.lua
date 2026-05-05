
SMODS.Joker{ --Vegito Blue
    key = "vegitoblue",
    config = {
        extra = {
            repetitions0 = 4
        }
    },
    loc_txt = {
        ['name'] = 'Vegito Blue',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} played',
            [2] = '{C:attention}Face Cards four times{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 14
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 13,
    rarity = "dbz_transformed",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 5,
        y = 14
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:is_face() then
                return {
                    repetitions = 4,
                    message = localize('k_again_ex')
                }
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "You cant even keep up with me, can you?", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_vegito = false
                    return true
                end
            }))
        end
    end
}