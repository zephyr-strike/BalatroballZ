
SMODS.Joker{ --John Dragonball
    key = "johndragonball",
    config = {
        extra = {
            chips0 = 100,
            xchips0 = 10,
            mult0 = 100,
            xmult0 = 10
        }
    },
    loc_txt = {
        ['name'] = 'John Dragonball',
        ['text'] = {
            [1] = '{C:money}keep it 1000{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 13
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
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' 
            or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                swap = true,
                message = "keep",
                extra = {
                    chips = 100,
                    colour = G.C.CHIPS,
                    extra = {
                        x_chips = 10,
                        colour = G.C.DARK_EDITION,
                        extra = {
                            message = "it",
                            colour = G.C.PURPLE,
                            extra = {
                                mult = 100,
                                extra = {
                                    Xmult = 10,
                                    extra = {
                                        swap = true,
                                        message = "1000!",
                                        colour = G.C.CHIPS
                                    }
                                }
                            }
                        }
                    }
                }
            }
        end
    end
}