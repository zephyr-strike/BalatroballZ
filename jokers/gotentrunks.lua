
SMODS.Joker{ --[Super Saiyan] Goten & Trunks
    key = "gotentrunks",
    config = {
        extra = {
            chips0 = 100,
            mult0 = 10,
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan] Goten & Trunks',
        ['text'] = {
            [1] = '{C:blue}+100{} Chips and {C:red}+10{} Mult. {C:green}1 in 4{} chance to',
            [2] = '{C:red}self destruct{} when {C:attention}Blind{} is defeated'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["dbz_bbz"] = true },
    in_pool = function(self, args)
        return (
            not args 
            
            or args.source == 'sho' or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and not G.GAME.pool_flags.dbz_gotenks_active
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_gotentrunks') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = 100,
                extra = {
                    mult = 10
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_27ff0c41', 1, card.ability.extra.odds, 'j_dbz_gotentrunks', false) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            card:juice_up(0.3, 0.5)
                            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Ok!", colour = G.C.BLUE})
                            G.GAME.pool_flags.dbz_gotenks_active = true
                            return true
                        end
                    }))
                    SMODS.calculate_effect({func = function()
                        local target_joker = card
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Lets go, Goten.", colour = G.C.RED})
                        end
                        return true
                    end}, card)
                end
            end
        end
    end
}