
SMODS.Joker{ --[Full Power Super Saiyan] Broly
    key = "brolyfpss",
    config = {
        extra = {
            brolyxmult = 1
        }
    },
    loc_txt = {
        ['name'] = '[Full Power Super Saiyan] Broly',
        ['text'] = {
            [1] = 'This Joker gains {X:red,C:white}X0.5{} Mult for',
            [2] = 'each played hand that {C:attention}doesn\'t win{}',
            [3] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 1
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
        y = 1
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
        
        return {vars = {card.ability.extra.brolyxmult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.brolyxmult
            }
        end
        if context.before and context.cardarea == G.jokers  and not context.blueprint then
            if (to_big(G.GAME.chips / G.GAME.blind.chips) >= to_big(0.01) and to_big(G.GAME.chips / G.GAME.blind.chips) < to_big(1)) then
                return {
                    func = function()
                        card.ability.extra.brolyxmult = (card.ability.extra.brolyxmult) + 0.5
                        return true
                    end,
                    message = "GRAAAAHH!!"
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            if not ((G.GAME.pool_flags.dbz_no_broly or false)) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        card:juice_up(0.3, 0.5)
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "GGGRRAAAAAHHH!!!", colour = G.C.BLUE})
                        G.GAME.pool_flags.dbz_no_broly = true
                        return true
                    end
                }))
            end
        end
        if context.selling_self  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    card:juice_up(0.3, 0.5)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Guh?", colour = G.C.BLUE})
                    G.GAME.pool_flags.dbz_no_broly = false
                    return true
                end
            }))
        end
    end
}

local check_for_buy_space_ref = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.config.center.key == "j_dbz_brolyfpss" then -- ignore slot limit when bought
        return true
    end
    return check_for_buy_space_ref(card)
end

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    	if e.config.ref_table.config.center.key == "j_dbz_brolyfpss" then
        		e.config.colour = G.C.GREEN
        		e.config.button = "use_card"
    	else
        		can_select_card_ref(e)
    	end
end