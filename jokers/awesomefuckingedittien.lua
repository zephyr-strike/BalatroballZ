
SMODS.Joker{ --[Awesome Fucking Edit] Tien
    key = "awesomefuckingedittien",
    config = {
        extra = {
            awesomemult = 1,
            xmult = 3
        }
    },
    loc_txt = {
        ['name'] = '[Awesome Fucking Edit] Tien',
        ['text'] = {
            [1] = 'When a {C:attention}3{} is scored, give',
            [2] = '{X:red,C:white}X3{} Mult and this Joker',
            [3] = 'gains {X:red,C:white}X0.3{} Mult',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
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
    soul_pos = {
        x = 2,
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
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.awesomemult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.awesomemult
            }
        end
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound("dbz_awesometien")
                    SMODS.calculate_effect({message = "I Hate Everything About You!"}, card)
                    return true
                end,
            }))
        end
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 3 then
                card.ability.extra.awesomemult = (card.ability.extra.awesomemult) + 0.3
                return {
                    Xmult = 3,
                    extra = {
                        message = "Three Days Grace!",
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.setting_blind  and not context.blueprint then
            if G.GAME.blind.boss then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("dbz_awesometien")
                        SMODS.calculate_effect({message = "I Hate Everything About You!"}, card)
                        return true
                    end,
                }))
            end
        end
    end
}