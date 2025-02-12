module golphook

import utils
import offsets
import rand

#flag -lwinmm

#include "mmsystem.h"

fn C.PlaySound(voidptr, voidptr, u32) bool

fn get_sound_for_kill(kills int) string {

	if kills > 5 {
		return "k_five"
	}

	match kills {
		1 { return "k_one" }
		2 { return  "k_two"}
		3 { return "k_three" }
		4 { return "k_four" }
		else { return "k_five" }
	}
}


struct KillSound {
pub mut:
	old_kill int
	old_kill_hs int
	kill_streak int
}

fn (k &KillSound) play_sound(withSound string) {

	sounds := {
		"k_one": $embed_file('../ressources/sounds/k_one.wav'),
		"k_two": $embed_file('../ressources/sounds/k_two.wav'),
		"k_three": $embed_file('../ressources/sounds/k_three.wav'),
		"k_four": $embed_file('../ressources/sounds/k_four.wav'),
		"k_five": $embed_file('../ressources/sounds/k_five.wav'),
		"hs": $embed_file('../ressources/sounds/hs.wav')

		"woof": $embed_file('../ressources/sounds/woof.wav')
		"db_woof": $embed_file('../ressources/sounds/db_woof.wav')
	}

	mut file := sounds[withSound]

	C.PlaySound(voidptr(file.data()), 0, u32(C.SND_ASYNC | C.SND_MEMORY))
}

fn (mut k KillSound) get_kill() int {

	mut app_ctx := unsafe { app() }

	a := *(&usize(usize(app_ctx.h_client) + offsets.db.signatures.player_resource))
	lcp_id := app_ctx.ent_cacher.local_player.index()
	kills_total := &int(a + usize(offsets.db.netvars.match_stats_kills_total) + usize(lcp_id * 0x4))
	return *kills_total
}

fn (mut k KillSound) get_kill_hs() int {

	mut app_ctx := unsafe { app() }

	a := *(&usize(usize(app_ctx.h_client) + offsets.db.signatures.player_resource))
	lcp_id := app_ctx.ent_cacher.local_player.index()
	hs_kills := &int(a + usize(offsets.db.netvars.match_stats_headshot_kills_total) + usize(lcp_id * 0x4))
	return *hs_kills
}

fn (mut k KillSound) is_freeze_time() bool {

	mut app_ctx := unsafe { app() }

	a := *(&usize(usize(app_ctx.h_client) + offsets.db.signatures.game_rules_proxy))
	is_freeze_time := &bool(a + usize(offsets.db.netvars.freeze_period))
	return *is_freeze_time
}


fn (mut k KillSound) on_frame() {
	
	mut app_ctx := unsafe { app() }

	if k.is_freeze_time() {
		k.kill_streak = 0
	}

	if k.get_kill() > k.old_kill {

		if app_ctx.config.active_config.killsay {
			// using rand module cause crash
			// user array[idx] cause crash ...
			// using a const array don't give any result

			messages := [
				"level 180 sur steam mais je cheat, t'as raison oui",
			    "mon steam vaut plus cher que ta vie",
			    "jsuis a moitié dans l'coma les yeux rouges et jrecois des nudes",
			    "Depuis le vacban les filles on prit leur jambe à leur cou",
			    "ya des fois jaimerais etre gay, les mecs c moins compliqués",
			    "facile a hacker les succes steam mdrr",
				"Tout mon détail, j’le foutais dans ma p'tite trousse",
				"Et j'm'en rappelle du premier jour d'la rentrée: cent-trente euros en barrette",
				"ma Beyoncé elle msuce la bite negro",
				"mon gar je trouve que jeter de l'argent sur un account sa va servir a rien je gaspile de l'argent sur quelque chose qui vaut la peine sale geek et mon main coute dans les 800 dollar il est locked par volvo",
				"merci qd mm la mission local pr la garantie jeune ca ma bien depannnn",
				"Mets ça sur ton pain ça sera moins sec",
				"Attention les filles en mode enflure",
				"et ma bitch a toujours le xanax et la og dans le purse",
				"truc d'africain de ce lever pour le pain"
			]

			a := C.rand() % messages.len
			mut f_msg := ""

			for idx, msg in messages {
				if idx == a {
					f_msg = msg
				}
			}

			app_ctx.interfaces.cdll_int.client_cmd("say $f_msg")
		}

		if app_ctx.config.active_config.killsound {
			if k.get_kill_hs() > k.old_kill_hs {
				k.kill_streak++
				if app_ctx.config.active_config.killsound_type == 1  {
					k.play_sound("hs")
				} else {
					k.play_sound("db_woof")
				}

			} else {
				k.kill_streak++
				if app_ctx.config.active_config.killsound_type == 1 {
					k.play_sound(get_sound_for_kill(k.kill_streak))
				} else {
					k.play_sound("woof")
				}
			}
		}


	}

	k.old_kill = k.get_kill()
	k.old_kill_hs = k.get_kill_hs()

}
