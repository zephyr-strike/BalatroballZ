
SMODS.Booster {
    key = 'capsule1',
    loc_txt = {
        name = "Hoi Poi Capsule",
        text = {
            [1] = 'Choose {C:attention}1{} of {C:attention}2{} {C:diamonds}Training Grounds{}',
            [2] = '{C:attention}Cards{} to be drawn to consumables'
        },
        group_name = "gokutest_boosters"
    },
    config = { extra = 2, choose = 1 },
    weight = 0.5,
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "training_grounds",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "dbz_capsule1"
        }
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}


SMODS.Booster {
    key = 'silver_capsule',
    loc_txt = {
        name = "Silver Capsule",
        text = {
            [1] = 'Choose {C:attention}1{} of {C:attention}3{} {C:diamonds}Training Grounds{}',
            [2] = '{C:attention}Cards{} to be drawn to consumables'
        },
        group_name = "gokutest_boosters"
    },
    config = { extra = 3, choose = 1 },
    cost = 6,
    weight = 0.4,
    atlas = "CustomBoosters",
    pos = { x = 1, y = 0 },
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "training_grounds",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "dbz_silver_capsule"
        }
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}


SMODS.Booster {
    key = 'golden_capsule',
    loc_txt = {
        name = "Golden Capsule",
        text = {
            [1] = 'Choose {C:attention}2{} of {C:attention}3{} {C:diamonds}Training Grounds{}',
            [2] = '{C:attention}Cards{} to be drawn to consumables'
        },
        group_name = "gokutest_boosters"
    },
    config = { extra = 3, choose = 2 },
    cost = 8,
    weight = 0.25,
    atlas = "CustomBoosters",
    pos = { x = 2, y = 0 },
    select_card = "consumeables",
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "training_grounds",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "dbz_golden_capsule"
        }
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}


SMODS.Booster {
    key = 'fusion_pack',
    loc_txt = {
        name = "Fusion Pack",
        text = {
            [1] = 'Choose {C:attention}1{} {C:attention}base form{}',
            [2] = '{C:planet}Fusion{} card'
        },
        group_name = "dbz_boosters"
    },
    config = { extra = 1, choose = 1 },
    cost = 10,
    weight = 0.05,
    atlas = "CustomBoosters",
    pos = { x = 3, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "Joker",
            rarity = "dbz_fusion",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "dbz_fusion_pack"
        }
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    