/// keybind_check(keybindobj, checkscript)
/// @arg keybindobj
/// @arg checkscript

function keybind_check(keybindobj, checkscript)
{
	var keybind, charcheck;
	keybind = keybindobj.keybind
	charcheck = (keybind[e_keybind_key.CHAR] = null || keybind_check_char(keybind[e_keybind_key.CHAR], checkscript))

	if (checkscript = "keyboard_check")
	{
		keybindobj.check_ctrl = keybind_check_modifier(vk_control, keybind[e_keybind_key.CTRL], keybindobj.navigation)
		keybindobj.check_shift = keybind_check_modifier(vk_shift, keybind[e_keybind_key.SHIFT], keybindobj.navigation)
		keybindobj.check_alt = keybind_check_modifier(vk_alt, keybind[e_keybind_key.ALT], keybindobj.navigation)
	}

	return (charcheck && keybindobj.check_ctrl && keybindobj.check_shift && keybindobj.check_alt)
}

function keybind_check_char(key, checkscript)
{
	var scriptres;
	scriptres = keybind_check_raw_key(key, checkscript)

	if (platform_get() = e_platform.MAC_OS)
	{
		switch (key)
		{
			case vk_delete:
				scriptres = scriptres || keybind_check_raw_key(vk_backspace, checkscript)
				break;
		}
	}

	return scriptres
}

function keybind_check_raw_key(key, checkscript)
{
	if (key = null)
		return false

	switch (checkscript)
	{
		case "keyboard_check": return keyboard_check(key)
		case "keyboard_check_pressed": return keyboard_check_pressed(key)
		case "keyboard_check_released": return keyboard_check_released(key)
	}

	return false
}

function keybind_check_modifier(key, required, navigation)
{
	return (keyboard_check(key) = required) || (navigation && !required)
}
