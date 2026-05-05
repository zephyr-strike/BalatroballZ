
SMODS.Joker{ --Hit
    key = "hit",
    config = {
        extra = {
            hitmult = 1,
            set_probability0 = 0
        }
    },
    loc_txt = {
        ['name'] = 'Hit',
        ['text'] = {
            [1] = '{C:attention}Glass{} cards give an additional',
            [2] = '{X:red,C:white}X0.1{} Mult per {C:attention}Glass{} card {C:attention}scored{}',
            [3] = 'and cannot be {C:red}destroyed{}',
            [4] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
        x = 8,
        y = 12
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local info_queue_0 = G.P_CENTERS["m_glass"]
        if info_queue_0 then
            info_queue[#info_queue + 1] = info_queue_0
        else
            error("JOKERFORGE: Invalid key in infoQueues. \"m_glass\" isn't a valid Object key, Did you misspell it or forgot a modprefix?")
        end
        return {vars = {card.ability.extra.hitmult}}
    end,
    
    calculate = function(self, card, context)
        if context.fix_probability  then
            local numerator, denominator = context.numerator, context.denominator
            if context.identifier == "glass" then
                numerator = 0
            end
            return {
                numerator = numerator, 
                denominator = denominator
            }
        end
        if context.individual and context.cardarea == G.play  then
            if SMODS.get_enhancements(context.other_card)["m_glass"] == true then
                card.ability.extra.hitmult = (card.ability.extra.hitmult) + 0.1
                return {
                    Xmult = card.ability.extra.hitmult
                }
            end
        end
    end
}