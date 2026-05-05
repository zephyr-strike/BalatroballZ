
SMODS.Joker{ --[Super Saiyan 2] Kefla
    key = "kefla",
    config = {
        extra = {
            keflamult = 1,
            levels0 = 2
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan 2] Kefla',
        ['text'] = {
            [1] = 'When hand contains a',
            [2] = '{C:attention}Pair{}, upgrade {C:attention}Pair{} by {C:attention}2',
            [3] = 'levels{} and gain {X:red,C:white}X0.2{} Mult',
            [4] = '{C:inactive}(Currently {X:red,C:white}X#1#{} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 13
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 15,
    rarity = "dbz_fusion",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true, ["dbz_fusionpack"] = true },
    soul_pos = {
        x = 5,
        y = 13
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.keflamult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if context.scoring_name == "Pair" then
                local target_hand = "Pair"
                level_up_hand(card, target_hand, true, 2)
                card.ability.extra.keflamult = (card.ability.extra.keflamult) + 0.2
                return {
                    message = localize('k_level_up_ex')
                }
            else
                return {
                    Xmult = card.ability.extra.keflamult
                }
            end
        end
    end
}