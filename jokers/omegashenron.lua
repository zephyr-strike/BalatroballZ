
SMODS.Joker{ --Omega Shenron
    key = "omegashenron",
    config = {
        extra = {
            repetitions0 = 7
        }
    },
    loc_txt = {
        ['name'] = 'Omega Shenron',
        ['text'] = {
            [1] = 'Retrigger played {C:attention}7s 7{} times'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 12
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    soul_pos = {
        x = 0,
        y = 13
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if context.other_card:get_id() == 7 then
                return {
                    repetitions = 7,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}