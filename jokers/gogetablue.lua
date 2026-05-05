
SMODS.Joker{ --Gogeta Blue
    key = "gogetablue",
    config = {
        extra = {
            xchips0 = 3,
            xmult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Gogeta Blue',
        ['text'] = {
            [1] = '{C:attention}Numbered Cards{} give',
            [2] = '{X:red,C:white}X3{} Mult and {X:blue,C:white}X3{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 15
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "dbz_transformed",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 3,
        y = 15
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
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if not (context.other_card:is_face()) then
                return {
                    x_chips = 3,
                    extra = {
                        Xmult = 3
                    }
                }
            end
        end
        if context.selling_self  then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Heh...", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_gogeta = false
                    return true
                end
            }))
        end
    end
}