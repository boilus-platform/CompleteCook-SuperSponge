function player_slap() //scr_player_slap
{
        hsp = (xscale * movespeed)
			move = (INPUTS.left + INPUTS.right);
    if (sprite_index != spr_sponge_slap)
    {
        if move
            movespeed -= 0.5
        if (((scr_solid((x + 1), y) && hsp == 1) || (scr_solid((x - 1), y) && hsp == -1)) && (!(place_meeting((x + sign(hsp)), y, obj_slope))))
            movespeed = 0
    }
    landAnim = 0
    if (INPUTS.grab && sprite_index != spr_sponge_slap)
	sprite_index = spr_sponge_slap
	switch (sprite_index)
	{
		case spr_sponge_slap:
		with (instance_place(x, y, par_enemy))
		{
			if enemy_can_die()
				instance_destroy()
		}
		break_destroyables()
		if anim_ended() {// im a stupid ass hoe bruuuhhhh
		state = states.normal
		}
		break;
	}
}