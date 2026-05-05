
SMODS.Joker{ --[Super Saiyan 3] Gotenks
    key = "supersaiyan3gotenks",
    config = {
        extra = {
            gotenkschips = 100,
            gotenksmult = 1,
            odds = 33
        }
    },
    loc_txt = {
        ['name'] = '[Super Saiyan 3] Gotenks',
        ['text'] = {
            [1] = 'Gains {C:blue}33{} Chips and {X:red,C:white}X0.3{} Mult and',
            [2] = 'has a {C:green}1 in 33{} chance to {C:red}self',
            [3] = 'destruct{} when {C:attention}Blind{} is defeated',
            [4] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips and{} {X:red,C:white}X#2#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 8
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
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
        and G.GAME.pool_flags.dbz_gotenks_active
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_dbz_supersaiyan3gotenks') 
        return {vars = {card.ability.extra.gotenkschips, card.ability.extra.gotenksmult, new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.gotenkschips,
                extra = {
                    Xmult = card.ability.extra.gotenksmult
                }
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  and not context.blueprint then
            if true then
                return {
                    func = function()
                        card.ability.extra.gotenkschips = (card.ability.extra.gotenkschips) + 33
                        return true
                    end,
                    message = "Behold the Grim Reaper of Justice!",
                    extra = {
                        func = function()
                            card.ability.extra.gotenksmult = (card.ability.extra.gotenksmult) + 0.3
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_0ddf432a', 1, card.ability.extra.odds, 'j_dbz_supersaiyan3gotenks', false) then
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                func = function()
                                    card:juice_up(0.3, 0.5)
                                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = "gotenks_active", colour = G.C.BLUE})
                                    G.GAME.pool_flags.dbz_gotenks_active = false
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
                                            target_joker:explode({G.C.RED}, nil, 1.6)
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "UWAAA!!", colour = G.C.RED})
                                end
                                return true
                            end}, card)
                        end
                        return true
                    end
                }
            end
        end
    end
}