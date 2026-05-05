
SMODS.Joker{ --Kid Buu
    key = "kidbuu",
    config = {
        extra = {
            buumult = 5,
            odds = 3
        }
    },
    loc_txt = {
        ['name'] = 'Kid Buu',
        ['text'] = {
            [1] = 'Gain {X:red,C:white}X0.2{} Mult when any {C:attention}consumable{}',
            [2] = 'is used. {C:green}1 in 3{} chance to gain',
            [3] = '{X:red,C:white}X0.2{} Mult when any card is scored',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 2
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
        x = 9,
        y = 2
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_kidbuu') 
        return {vars = {card.ability.extra.buumult, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.using_consumeable  and not context.blueprint then
            return {
                func = function()
                    card.ability.extra.buumult = (card.ability.extra.buumult) + 0.2
                    return true
                end,
                message = "GYA HA HA HA!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.buumult
            }
        end
        if context.individual and context.cardarea == G.play  and not context.blueprint then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_412f8cf8', 1, card.ability.extra.odds, 'j_dbz_kidbuu', false) then
                    card.ability.extra.buumult = (card.ability.extra.buumult) + 0.2
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "OOO YA YA YA!", colour = G.C.GREEN})
                end
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "HEEEHEHEHEE!", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_buu = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_kidbuu" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_kidbuu" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end