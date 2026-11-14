function player_groundpound()
{
	if vsp >= 2
	{
		if vsp > 17
		{
			aftimg_timers.mach.do_it = true
			if particle_timer > 0
				particle_timer--
			else
			{
				if !particle_contains_sprite(spr_piledrivereffect)
				{
					with create_effect(x, y, spr_piledrivereffect)
						depth = -150
				}
				if !particle_contains_sprite(spr_groundpoundcharge)
				{	
					with create_followingeffect(spr_groundpoundcharge, states.groundpound, 1)
					{
						depth = -100
						image_speed = 0.35
					}
				}
				particle_timer = 15
			}
		}
		vsp += 0.5
	}
	
	if particle_timer2 > 0
		particle_timer2--
	else
	{
		create_effect(x, y, spr_cloudeffect)
		particle_timer2 = 10
	}
	
	if anim_ended() && sprite_index == spr_sponge_bodyslamstart
		sprite_index = spr_sponge_bodyslam
	else if sprite_index == spr_player_shotgun_shootdown
		reset_anim_on_end(spr_player_shotgun_shootdown_loop)
	
	if (!grounded)
	{
		hsp = sprite_index != spr_player_rockethitwall ? P_MOVE * movespeed : 0
		if (P_MOVE != xscale && !place_meeting(x + xscale, y, obj_solid) && movespeed != 0)
			movespeed -= 0.1
		if (P_MOVE != dir && P_MOVE != 0)
		{
			dir = P_MOVE
			movespeed = 0
		}
		if (P_MOVE == 0)
			movespeed = 0
		
		if (P_MOVE != 0 && movespeed < 7)
			movespeed += 0.25
		if (movespeed > 7)
			movespeed -= 0.05
		if (place_meeting(x + P_MOVE, y, obj_solid))
		{
			hsp = 0
			movespeed = 0
		}
		if (P_MOVE != 0 && sprite_index != spr_player_poundcancel1 && sprite_index != spr_player_rockethitwall)
			xscale = P_MOVE
	}
	if (vsp > 0)
		freefallsmash++
	else if (vsp < 0)
		freefallsmash = -14
	if (grounded && vsp >= 0)
	{
			var landanim = spr_sponge_bodyslamend
			if sprite_index == spr_player_poundcancel1
				landanim = spr_player_poundcancel2
			else if has_shotgun
				landanim = spr_player_shotgun_shootdownland
			reset_anim(landanim)
			image_index = 0
			state = states.bump
			hsp = 0
			movespeed = 0
			shake_camera(5, 15 / room_speed)
			scr_sound_3d(sfx_groundpound, x, y)
			create_effect(x, y + 2, spr_groundpoundeffect)
			if freefallsmash >= 10
			{
				with par_enemy
				{
					if (grounded && vsp >= 0 && bbox_in_camera())
					{
						state = states.stun
						stun_timer = 60
						vsp = -11
						xscale *= -1
						hsp = 0
					}
				}
				shake_camera(10, 30 / room_speed)
			}
				if input_check(INPUTS.jump){
					state = states.superjump
					sprite_index = spr_sponge_hurt
				}
	}
	
	image_speed = 0.35
	aftimg_timers.blur.do_it = true
	instakill = true
}