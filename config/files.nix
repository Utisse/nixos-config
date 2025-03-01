{ config, ...}:
let 
  colors = config.lib.stylix.colors;
in
{
home.file = {
    ".config/waybar/watch_course.sh".text = ''
      #!/bin/bash
      cat /tmp/current_course'';
    #".config/wallpaper/recolor_wallpaper.sh".text = ''
    # gm convert -background "#${colors.base00}" -flatten nix-transp.png /home/lorev/nixos-config/config/wallpaper/nix-colored.png
    #'';
    ".config/wallpaper/nix-transp.png".source = ./wallpaper/nix-transp.png;
    #".config/emacs/init.el".source = ./config/emacs/init.el;
    ".config/godot/minimal_theme.tres".text = ''
    [gd_resource type="Theme" load_steps=2 format=3 uid="uid://bcibt73qths3g"]

[sub_resource type="GDScript" id="GDScript_hhmc0"]
script/source = "@tool
extends Theme

var base_color : Color
var contrast : float
var scale : float
var dark_theme : bool

func _init() -> void:
	# Editor Settings

	var settings : EditorSettings = EditorInterface.get_editor_settings()

	@warning_ignore('unsafe_cast')
	base_color = Color(${colors.base00-dec-r}, ${colors.base00-dec-g}, ${colors.base00-dec-b},1)
        @warning_ignore('unsafe_cast')
	contrast = settings.get_setting('interface/theme/contrast')
	scale = EditorInterface.get_editor_scale()

	@warning_ignore('unsafe_cast')
	var accent_color : Color = Color(${colors.base03-dec-r}, ${colors.base03-dec-g}, ${colors.base03-dec-b},1)
	@warning_ignore('unsafe_cast')
	var base_spacing : int = settings.get_setting('interface/theme/base_spacing')
	@warning_ignore('unsafe_cast')
	var extra_spacing : int = settings.get_setting('interface/theme/additional_spacing')
	@warning_ignore('unsafe_cast')
	var corner_radius : int = settings.get_setting('interface/theme/corner_radius')
	@warning_ignore('unsafe_cast')
	var icon_and_font_color : int = settings.get_setting('interface/theme/icon_and_font_color')
	@warning_ignore('unsafe_cast')
	var relationship_line_opacity : float = settings.get_setting('interface/theme/relationship_line_opacity')
	@warning_ignore('unsafe_cast')
	var draw_extra_borders : bool = settings.get_setting('interface/theme/draw_extra_borders')

	# Globals

	base_spacing = maxi(base_spacing, 2) # Base spacing below 2 looks broken

	var base_margin : float = base_spacing
	var increased_margin : float = base_spacing + extra_spacing * 0.75
	var popup_margin : float = maxf(base_margin * 2.4, 4.0 * scale)

	dark_theme = base_color.get_luminance() < 0.5
	if icon_and_font_color != 0: # ColorMode.AUTO_COLOR
		dark_theme = icon_and_font_color == 1 # ColorMode.DARK

	var mono_color : Color = Color.WHITE if dark_theme else Color.BLACK

	var extra_border_color_1 : Color = Color(1, 1, 1, 0.4) if dark_theme else Color(0, 0, 0, 0.4)
	var extra_border_color_2 : Color = Color(1, 1, 1, 0.2) if dark_theme else Color(0, 0, 0, 0.2)

	# Ensure minimum contrast with the light theme. The default
	# contrast makes it hard to see the UI elements
	if not dark_theme and contrast < 0 and contrast > -0.4:
		contrast = -0.4

	# Main stylebox that most styleboxes duplicate
	var base_sb : StyleBoxFlat = StyleBoxFlat.new()
	base_sb.bg_color = base_color
	base_sb.set_content_margin_all(base_margin * scale)
	base_sb.set_corner_radius_all(int(corner_radius * scale))

	# Non-transparent buttons will potentially blend worse with background
	# than transparent ones, however this is currently only noticeable on the Close
	# button of editor settings, and it probably shouldn't even exist
	var button_sb : StyleBoxFlat = base_sb.duplicate()
	button_sb.bg_color = _get_base_color(0.3, 0.8)
	if draw_extra_borders:
		_set_border(button_sb, extra_border_color_1, floorf(scale))
	else:
		_set_border(button_sb, _get_base_color(0.5, 0.7), 1, true)
	_set_margin(button_sb, base_margin * 2, base_margin * 1.5, base_margin * 2, base_margin * 1.5)

	var button_hover_sb : StyleBoxFlat = button_sb.duplicate()
	button_hover_sb.bg_color = _get_base_color(0.5, 0.7)
	if draw_extra_borders:
		_set_border(button_hover_sb, extra_border_color_1, floorf(scale))
	else:
		_set_border(button_hover_sb, _get_base_color(0.7, 0.7), 1, true)

	var button_pressed_sb : StyleBoxFlat = button_sb.duplicate()
	button_pressed_sb.bg_color = _get_base_color(0.7, 0.7)
	if draw_extra_borders:
		_set_border(button_pressed_sb, extra_border_color_1, floorf(scale))
	else:
		_set_border(button_pressed_sb, _get_base_color(0.9, 0.7), 1, true)

	var button_disabled_sb : StyleBoxFlat = button_sb.duplicate()
	button_disabled_sb.set_border_width_all(0)
	button_disabled_sb.bg_color = _get_base_color(0.2, 0.7)
	if draw_extra_borders:
		_set_border(button_disabled_sb, extra_border_color_2 * Color(1, 1, 1, 0.5), floorf(scale))

	var flat_button_hover_sb : StyleBoxFlat = base_sb.duplicate()
	_set_margin(flat_button_hover_sb, base_margin * 1.5, base_margin, base_margin * 1.5, base_margin)
	flat_button_hover_sb.bg_color = _get_base_color(0.3, 0.7)
	if draw_extra_borders:
		_set_border(flat_button_hover_sb, extra_border_color_1, floorf(scale))

	var flat_button_pressed_sb : StyleBoxFlat = flat_button_hover_sb.duplicate()
	flat_button_pressed_sb.bg_color = _get_base_color(0.5, 0.7)

	var base_empty_sb : StyleBoxFlat = base_sb.duplicate()
	base_empty_sb.draw_center = false
	base_empty_sb.set_content_margin_all(0)

	var base_empty_wide_sb : StyleBoxFlat = base_sb.duplicate()
	base_empty_wide_sb.draw_center = false
	# Ensure minimum margin for wide flat buttons otherwise the topbar looks broken
	var base_empty_wide_margin : float = maxf(base_margin, 3.0)
	_set_margin(base_empty_wide_sb, base_empty_wide_margin * 1.5, base_empty_wide_margin, base_empty_wide_margin * 1.5, base_empty_wide_margin)

	# Animation editor

	set_color('focus_color', 'AnimationBezierTrackEdit', Color.TRANSPARENT)
	set_color('h_line_color', 'AnimationBezierTrackEdit', mono_color * Color(1, 1, 1, 0.12))
	set_color('track_focus_color', 'AnimationBezierTrackEdit', mono_color * Color(1, 1, 1, 0.1))
	set_color('v_line_color', 'AnimationBezierTrackEdit', Color.TRANSPARENT)

	set_color('font_primary_color', 'AnimationTimelineEdit', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_secondary_color', 'AnimationTimelineEdit', mono_color * Color(1, 1, 1, 0.4))
	set_color('h_line_color', 'AnimationTimelineEdit', Color.TRANSPARENT)
	set_color('v_line_primary_color', 'AnimationTimelineEdit', mono_color * Color(1, 1, 1, 0.4))
	set_color('v_line_secondary_color', 'AnimationTimelineEdit', mono_color * Color(1, 1, 1, 0.08))

	set_constant('text_primary_margin', 'AnimationTimelineEdit', int(base_margin * 0.75 * scale))
	set_constant('text_secondary_margin', 'AnimationTimelineEdit', int(base_margin * 0.5 * scale))
	set_constant('v_line_primary_margin', 'AnimationTimelineEdit', int(base_margin * scale))
	set_constant('v_line_primary_width', 'AnimationTimelineEdit', int(ceilf(2 * scale)))
	set_constant('v_line_secondary_margin', 'AnimationTimelineEdit', int(base_margin * 1.5 * scale))
	set_constant('v_line_secondary_width', 'AnimationTimelineEdit', int(ceilf(scale)))

	var sb : StyleBoxFlat = base_sb.duplicate()
	sb.bg_color = _get_base_color(0.55, 0.7)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_1, floorf(scale))
	set_stylebox('time_available', 'AnimationTimelineEdit', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(0.2, 0.8)
	set_stylebox('time_unavailable', 'AnimationTimelineEdit', sb)

	set_color('h_line_color', 'AnimationTrackEdit', Color.TRANSPARENT)
	set_constant('h_separation', 'AnimationTrackEdit', int(base_margin * 1.5 * scale))

	sb = base_sb.duplicate()
	sb.draw_center = false
	_set_border(sb, _get_base_color(0.3, 0.6), 2)
	_set_margin(sb, base_margin * 1.5, base_margin, base_margin * 1.5, base_margin)
	set_stylebox('focus', 'AnimationTrackEdit', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(0.2, 0.9)
	set_stylebox('hover', 'AnimationTrackEdit', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.2)
	set_stylebox('odd', 'AnimationTrackEdit', sb)

	set_color('bg_color', 'AnimationTrackEditGroup', _get_base_color(-0.2))
	set_color('h_line_color', 'AnimationTrackEditGroup', Color.TRANSPARENT)
	set_color('v_line_color', 'AnimationTrackEditGroup', Color.TRANSPARENT)
	set_constant('h_separation', 'AnimationTrackEditGroup', int(base_margin * 2 * scale))

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.6)
	_set_margin(sb, base_margin * 4, base_margin, 0, base_margin)
	set_stylebox('header', 'AnimationTrackEditGroup', sb)

	# Bottom panel

	# Use bigger margin for buttons in bottom panel to make them easier to press
	var empty_sb : StyleBoxFlat = base_empty_sb.duplicate()
	_set_margin(empty_sb, base_margin * 2, base_margin * 1.2, base_margin * 2, base_margin * 1.2)
	set_stylebox('normal', 'BottomPanelButton', base_empty_wide_sb)

	sb = flat_button_hover_sb.duplicate()
	_set_margin(sb, base_margin * 2, base_margin * 1.2, base_margin * 2, base_margin * 1.2)
	set_stylebox('hover', 'BottomPanelButton', sb)
	set_stylebox('pressed', 'BottomPanelButton', sb)

	sb = flat_button_pressed_sb.duplicate()
	_set_margin(sb, base_margin * 2, base_margin * 1.2, base_margin * 2, base_margin * 1.2)
	set_stylebox('hover_pressed', 'BottomPanelButton', sb)

	# Button

	set_color('font_color', 'Button', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_disabled_color', 'Button', mono_color * Color(1, 1, 1, 0.3))
	set_color('font_focus_color', 'Button', mono_color)
	set_color('font_hover_color', 'Button', mono_color)
	set_color('font_hover_pressed_color', 'Button', mono_color)
	set_color('font_pressed_color', 'Button', mono_color)
	set_color('icon_disabled_color', 'Button', mono_color * Color(1, 1, 1, 0.3))
	set_color('icon_normal_color', 'Button', mono_color * Color(1, 1, 1, 0.7))
	set_constant('outline_size', 'Button', 0)
	set_stylebox('disabled', 'Button', button_disabled_sb)
	set_stylebox('disabled_mirrored', 'Button', button_disabled_sb)
	set_stylebox('focus', 'Button', base_empty_sb)
	set_stylebox('hover', 'Button', button_hover_sb)
	set_stylebox('hover_mirrored', 'Button', button_hover_sb)
	set_stylebox('hover_pressed', 'Button', button_pressed_sb)
	set_stylebox('hover_pressed_mirrored', 'Button', button_pressed_sb)
	set_stylebox('normal', 'Button', button_sb)
	set_stylebox('normal_mirrored', 'Button', button_sb)
	set_stylebox('pressed', 'Button', button_pressed_sb)
	set_stylebox('pressed_mirrored', 'Button', button_pressed_sb)

	# Checkbox

	set_color('font_hover_pressed_color', 'CheckBox', mono_color)
	set_color('font_pressed_color', 'CheckBox', mono_color * Color(1, 1, 1, 0.7))

	sb = base_sb.duplicate()
	sb.draw_center = false
	_set_margin(sb, base_margin * 1.5, base_margin * 0.5, base_margin * 1.5, base_margin * 0.5)
	set_stylebox('normal', 'CheckBox', sb)
	set_stylebox('normal_mirrored', 'CheckBox', sb)

	# CheckButton

	set_color('font_focus_color', 'CheckButton', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_hover_pressed_color', 'CheckButton', mono_color)
	set_color('font_pressed_color', 'CheckButton', mono_color * Color(1, 1, 1, 0.7))

	# Editor

	set_color('background', 'Editor', _get_base_color(-0.6))
	set_color('box_selection_fill_color', 'Editor', mono_color * Color(1, 1, 1, 0.12))
	set_color('box_selection_stroke_color', 'Editor', mono_color * Color(1, 1, 1, 0.4))
	# Ruler in 2D view:
	set_color('dark_color_2', 'Editor', Color(0, 0, 0, 0.3) if dark_theme else Color(1, 1, 1, 0.3))
	# Shortcut tree cell background:
	set_color('dark_color_3', 'Editor', _get_base_color(-0.6))

	set_color('forward_plus_color', 'Editor', Color(0.54902, 0.752941, 0.392157))
	set_color('gl_compatibility_color', 'Editor', Color(0.447059, 0.698039, 0.890196))
	set_color('mobile_color', 'Editor', Color(0.862745, 0.482353, 0.584314))
	set_color('property_color_w', 'Editor', mono_color * Color(1, 1, 1, 0.8))
	set_color('property_color_x', 'Editor', Color('#E16277') if dark_theme else Color('#670A18'))
	set_color('property_color_y', 'Editor', Color('#C3EF65') if dark_theme else Color('#455E10'))
	set_color('property_color_z', 'Editor', Color('#6AABF6') if dark_theme else Color('#143862'))
	set_color('warning_color', 'Editor', Color(0.95, 0.855, 0.57) if dark_theme else Color(0.82, 0.56, 0.1))

	set_color('prop_subsection', 'Editor', Color.TRANSPARENT)
	set_constant('top_bar_separation', 'Editor', int(base_margin * scale))
	set_constant('window_border_margin', 'Editor', int(base_margin * scale))

	# EditorHelpBit

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.3 if dark_theme else -0.7)
	_set_margin(sb, base_margin * 2, base_margin, base_margin * 2, base_margin)
	sb.set_corner_radius_all(0)
	sb.corner_radius_bottom_right = int(corner_radius * scale)
	sb.corner_radius_bottom_left = int(corner_radius * scale)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('normal', 'EditorHelpBitContent', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.55 if dark_theme else -0.9) # Same as secondary tree
	_set_margin(sb, base_margin * 2, base_margin, base_margin * 2, base_margin)
	sb.set_corner_radius_all(0)
	sb.corner_radius_top_right = int(corner_radius * scale)
	sb.corner_radius_top_left = int(corner_radius * scale)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('normal', 'EditorHelpBitTitle', sb)

	# EditorInspector

	set_constant('v_separation', 'EditorInspector', int(base_margin * 0.85 * scale))
	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(0.2, 0.8)
	_set_margin(sb, 0, base_margin * 1.2, 0, base_margin * 1.2)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('bg', 'EditorInspectorCategory', sb)
	set_constant('h_separation', 'EditorInspectorSection', int(base_margin * scale))

	# EditorLogFilterButton

	# Hover and pressed styles are swapped for toggle buttons on purpose
	set_stylebox('hover', 'EditorLogFilterButton', flat_button_pressed_sb)
	set_stylebox('pressed', 'EditorLogFilterButton', flat_button_hover_sb)
	set_stylebox('normal', 'EditorLogFilterButton', base_empty_sb)


	# EditorProperty

	set_color('property_color', 'EditorProperty', mono_color * Color(1, 1, 1, 0.6))
	set_color('warning_color', 'EditorProperty', Color(0.95, 0.855, 0.57, 1) if dark_theme else Color(0.82, 0.56, 0.1))
	set_stylebox('bg', 'EditorProperty', base_empty_sb)
	set_stylebox('bg_selected', 'EditorProperty', base_empty_sb)
	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.8) # Same as LineEdit normal
	sb.set_content_margin_all(base_margin * scale)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('child_bg', 'EditorProperty', sb)

	# EditorSpinSlider

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.8)
	sb.set_content_margin_all(base_margin * scale)
	set_stylebox('label_bg', 'EditorSpinSlider', sb)

	# Viewport

	sb = base_sb.duplicate()
	sb.draw_center = false
	sb.set_corner_radius_all(0)
	_set_border(sb, mono_color * Color(1, 1, 1, 0.07), 2, false)
	set_stylebox('FocusViewport', 'EditorStyles', sb)

	sb = base_sb.duplicate()
	sb.bg_color = Color(0, 0, 0, 0.3) if dark_theme else Color(1, 1, 1, 0.3)
	_set_margin(sb, base_margin * 2, base_margin * 1.5, base_margin * 2, base_margin * 1.5)
	set_stylebox('Information3dViewport', 'EditorStyles', sb)

	# LaunchPad

	set_color('movie_writer_icon_hover', 'EditorStyles', Color(1, 1, 1, 0.8))
	set_color('movie_writer_icon_hover_pressed', 'EditorStyles', Color(1, 1, 1, 0.8))
	set_color('movie_writer_icon_normal', 'EditorStyles', Color(1, 1, 1, 0.7))
	set_color('movie_writer_icon_pressed', 'EditorStyles', Color(1, 1, 1, 0.941176))

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.5)
	_set_margin(sb, base_margin * 1.5, base_margin, base_margin * 1.5, base_margin)
	sb.set_expand_margin_all(scale)
	sb.set_border_width_all(0)
	set_stylebox('LaunchPadMovieMode', 'EditorStyles', sb)

	sb = sb.duplicate()
	sb.draw_center = false
	sb.border_color = Color.TRANSPARENT
	set_stylebox('LaunchPadNormal', 'EditorStyles', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(0.5)
	sb.set_content_margin_all(0)
	set_stylebox('MovieWriterButtonPressed', 'EditorStyles', sb)

	# EditorValidationPanel

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.5)
	_set_margin(sb, base_margin, base_margin * 0.5, base_margin, base_margin * 0.5)
	set_stylebox('panel', 'EditorValidationPanel', sb)

	# FlatButton

	set_color('font_color', 'FlatButton', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_disabled_color', 'FlatButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('font_focus_color', 'FlatButton', mono_color)
	set_color('font_hover_color', 'FlatButton', mono_color)
	set_color('font_hover_pressed_color', 'FlatButton', mono_color)
	set_color('font_pressed_color', 'FlatButton', mono_color)
	set_color('icon_disabled_color', 'FlatButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('icon_normal_color', 'FlatButton', mono_color * Color(1, 1, 1, 0.7))

	set_stylebox('disabled', 'FlatButton', base_empty_wide_sb)
	set_stylebox('disabled_mirrored', 'FlatButton', base_empty_wide_sb)
	set_stylebox('normal', 'FlatButton', base_empty_wide_sb)
	set_stylebox('normal_mirrored', 'FlatButton', base_empty_wide_sb)
	set_stylebox('hover', 'FlatButton', flat_button_hover_sb)
	set_stylebox('hover_mirrored', 'FlatButton', flat_button_hover_sb)
	set_stylebox('hover_pressed', 'FlatButton', flat_button_pressed_sb)
	set_stylebox('hover_pressed_mirrored', 'FlatButton', flat_button_pressed_sb)
	set_stylebox('pressed', 'FlatButton', flat_button_pressed_sb)
	set_stylebox('pressed_mirrored', 'FlatButton', flat_button_pressed_sb)


	# FlatMenuButton

	set_color('font_color', 'FlatMenuButton', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_disabled_color', 'FlatMenuButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('font_focus_color', 'FlatMenuButton', mono_color)
	set_color('font_hover_color', 'FlatMenuButton', mono_color)
	set_color('font_hover_pressed_color', 'FlatMenuButton', mono_color)
	set_color('font_pressed_color', 'FlatMenuButton', mono_color)
	set_color('icon_disabled_color', 'FlatMenuButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('icon_normal_color', 'FlatMenuButton', mono_color * Color(1, 1, 1, 0.7))

	set_stylebox('disabled', 'FlatMenuButton', base_empty_wide_sb)
	set_stylebox('disabled_mirrored', 'FlatMenuButton', base_empty_wide_sb)
	set_stylebox('focus', 'FlatMenuButton', base_empty_wide_sb)
	set_stylebox('normal', 'FlatMenuButton', base_empty_wide_sb)
	set_stylebox('normal_mirrored', 'FlatMenuButton', base_empty_wide_sb)
	set_stylebox('hover', 'FlatMenuButton', flat_button_hover_sb)
	set_stylebox('hover_mirrored', 'FlatMenuButton', flat_button_hover_sb)
	set_stylebox('hover_pressed', 'FlatMenuButton', flat_button_pressed_sb)
	set_stylebox('hover_pressed_mirrored', 'FlatMenuButton', flat_button_pressed_sb)
	set_stylebox('pressed', 'FlatMenuButton', flat_button_pressed_sb)
	set_stylebox('pressed_mirrored', 'FlatMenuButton', flat_button_pressed_sb)

	# GraphStateMachine

	set_color('focus_color', 'GraphStateMachine', Color.TRANSPARENT)

	# Box Containers

	set_constant('separation', 'HBoxContainer', int(2 * scale))
	set_constant('separation', 'VBoxContainer', int(2 * scale))

	# Split Containers

	set_constant('autohide', 'HSplitContainer', 1)
	set_constant('minimum_grab_thickness', 'HSplitContainer', int(base_margin * 1.5 * scale))
	set_constant('separation', 'HSplitContainer', int(ceilf(2 * scale)))

	set_constant('autohide', 'VSplitContainer', 1)
	set_constant('minimum_grab_thickness', 'VSplitContainer', int(base_margin * 1.5 * scale))
	set_constant('separation', 'VSplitContainer', int(ceilf(2 * scale)))

	# InspectorActionButton

	set_constant('h_separation', 'InspectorActionButton', int(base_margin * 2 * scale))
	set_stylebox('disabled', 'InspectorActionButton', button_disabled_sb)
	set_stylebox('disabled_mirrored', 'InspectorActionButton', button_disabled_sb)
	set_stylebox('normal', 'InspectorActionButton', button_sb)
	set_stylebox('normal_mirrored', 'InspectorActionButton', button_sb)
	set_stylebox('hover', 'InspectorActionButton', button_hover_sb)
	set_stylebox('hover_mirrored', 'InspectorActionButton', button_hover_sb)
	set_stylebox('pressed', 'InspectorActionButton', button_pressed_sb)
	set_stylebox('pressed_mirrored', 'InspectorActionButton', button_pressed_sb)

	# ItemList

	set_color('guide_color', 'ItemList', Color.TRANSPARENT)
	set_constant('v_separation', 'ItemList', int(base_margin * 1.5 * scale))

	sb = base_sb.duplicate()
	sb.bg_color = mono_color * Color(1, 1, 1, 0.04)
	set_stylebox('cursor', 'ItemList', sb)
	set_stylebox('cursor_unfocused', 'ItemList', sb)
	set_stylebox('focus', 'ItemList', base_empty_sb)

	set_stylebox('hovered', 'ItemList', flat_button_hover_sb)
	set_stylebox('selected', 'ItemList', flat_button_hover_sb)
	set_stylebox('selected_focus', 'ItemList', flat_button_hover_sb)
	set_stylebox('hovered_selected', 'ItemList', flat_button_hover_sb)
	set_stylebox('hovered_selected_focus', 'ItemList', flat_button_hover_sb)

	sb = base_sb.duplicate()
	sb.set_content_margin_all(base_margin * 2 * scale)
	set_stylebox('panel', 'ItemList', sb)

	# Label

	set_color('font_color', 'Label', mono_color * Color(1, 1, 1, 0.7))

	empty_sb = base_empty_sb.duplicate()
	# Keeping vertical margin low otherwise quick open looks bad
	_set_margin(empty_sb, base_margin * 2, base_margin, base_margin * 2, base_margin)
	set_stylebox('normal', 'Label', empty_sb)

	# LineEdit and TextEdit

	set_color('font_placeholder_color', 'LineEdit', mono_color * Color(1, 1, 1, 0.4))

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-1.2 if dark_theme else -2.0)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_1, floorf(scale))
	_set_margin(sb, base_margin * 2, base_margin * 0.75, base_margin * 2, base_margin * 0.75)
	set_stylebox('focus', 'LineEdit', sb)
	set_stylebox('focus', 'TextEdit', sb)

	sb = sb.duplicate()
	sb.bg_color = _get_base_color(-0.8 if dark_theme else -1.6)
	set_stylebox('normal', 'LineEdit', sb)
	set_stylebox('normal', 'TextEdit', sb)

	# Using transparent background for readonly otherwise it looks bad in the master audio bus
	sb = sb.duplicate()
	sb.bg_color = Color(0, 0, 0, 0.1) if dark_theme else Color(1, 1, 1, 0.1)
	set_stylebox('read_only', 'LineEdit', sb)
	set_stylebox('read_only', 'TextEdit', sb)

	# MainMenuBar

	set_stylebox('normal', 'MainMenuBar', base_empty_wide_sb)
	set_stylebox('hover', 'MainMenuBar', flat_button_hover_sb)
	set_stylebox('hover_pressed', 'MainMenuBar', flat_button_pressed_sb)
	set_stylebox('pressed', 'MainMenuBar', flat_button_pressed_sb)

	# MainScreenButton

	set_stylebox('normal', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('normal_mirrored', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('hover', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('hover_mirrored', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('hover_pressed', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('hover_pressed_mirrored', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('pressed', 'MainScreenButton', base_empty_wide_sb)
	set_stylebox('pressed_mirrored', 'MainScreenButton', base_empty_wide_sb)

	# MenuButton

	set_stylebox('disabled', 'MenuButton', base_empty_wide_sb)
	set_stylebox('disabled_mirrored', 'MenuButton', base_empty_wide_sb)
	set_stylebox('focus', 'MenuButton', base_empty_wide_sb)
	set_stylebox('normal', 'MenuButton', base_empty_wide_sb)
	set_stylebox('normal_mirrored', 'MenuButton', base_empty_wide_sb)
	set_stylebox('pressed', 'MenuButton', flat_button_pressed_sb)
	set_stylebox('pressed_mirrored', 'MenuButton', flat_button_pressed_sb)
	set_stylebox('hover', 'MenuButton', flat_button_hover_sb)
	set_stylebox('hover_mirrored', 'MenuButton', flat_button_hover_sb)
	set_stylebox('hover_pressed', 'MenuButton', flat_button_hover_sb)
	set_stylebox('hover_pressed_mirrored', 'MenuButton', flat_button_hover_sb)

	# OptionButton

	set_constant('arrow_margin', 'OptionButton', int(base_margin * 3.5))

	set_color('font_color', 'OptionButton', mono_color * Color(1, 1, 1, 0.7))
	set_color('font_disabled_color', 'OptionButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('font_focus_color', 'OptionButton', mono_color)
	set_color('font_hover_color', 'OptionButton', mono_color)
	set_color('font_hover_pressed_color', 'OptionButton', mono_color)
	set_color('font_pressed_color', 'OptionButton', mono_color)
	set_color('icon_disabled_color', 'OptionButton', mono_color * Color(1, 1, 1, 0.3))
	set_color('icon_normal_color', 'OptionButton', mono_color * Color(1, 1, 1, 0.7))

	set_stylebox('disabled', 'OptionButton', button_disabled_sb)
	set_stylebox('disabled_mirrored', 'OptionButton', button_disabled_sb)
	set_stylebox('focus', 'OptionButton', base_empty_sb)
	set_stylebox('normal', 'OptionButton', button_sb)
	set_stylebox('normal_mirrored', 'OptionButton', button_sb)
	set_stylebox('pressed', 'OptionButton', button_pressed_sb)
	set_stylebox('pressed_mirrored', 'OptionButton', button_pressed_sb)
	set_stylebox('hover', 'OptionButton', button_hover_sb)
	set_stylebox('hover_mirrored', 'OptionButton', button_hover_sb)
	set_stylebox('hover_pressed', 'OptionButton', button_pressed_sb)
	set_stylebox('hover_pressed_mirrored', 'OptionButton', button_pressed_sb)

	# Popups

	set_constant('item_start_padding', 'PopupMenu', int(popup_margin * scale))
	set_constant('v_separation', 'PopupMenu', int(base_margin * 1.75 * scale))

	set_stylebox('hover', 'PopupMenu', flat_button_hover_sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.8, 0.9)
	sb.set_content_margin_all(int(popup_margin * scale))
	sb.set_corner_radius_all(0)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('panel', 'PopupMenu', sb)

	var line_sb : StyleBoxLine = StyleBoxLine.new()
	line_sb.color = _get_base_color(0.1, 0.8)
	line_sb.grow_begin = base_margin * -1.5 * scale
	line_sb.grow_end = base_margin * -1.5 * scale
	line_sb.thickness = int(ceilf(scale))
	set_stylebox('labeled_separator_left', 'PopupMenu', line_sb)
	set_stylebox('labeled_separator_right', 'PopupMenu', line_sb)
	set_stylebox('separator', 'PopupMenu', line_sb)

	set_stylebox('panel', 'PanelContainer', base_empty_wide_sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.8, 0.9)
	sb.shadow_color = Color(0, 0, 0, 0.3)
	sb.shadow_size = int(base_margin * 0.75 * scale)
	sb.set_content_margin_all(int(popup_margin * scale))
	sb.set_corner_radius_all(0)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('panel', 'PopupPanel', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.8, 0.9)
	sb.set_content_margin_all(0)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('panel', 'TooltipPanel', sb)

	sb = base_sb.duplicate()
	sb.set_content_margin_all(int(popup_margin * scale))
	set_stylebox('panel', 'PopupDialog', sb)
	set_stylebox('panel', 'AcceptDialog', sb)

	sb = sb.duplicate()
	sb.bg_color = _get_base_color(-1)
	set_stylebox('panel', 'EditorSettingsDialog', sb)
	set_stylebox('panel', 'ProjectSettingsEditor', sb)
	set_stylebox('panel', 'EditorAbout', sb)

	# ProgressBar

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-1.2, 0.9)
	sb.expand_margin_top = base_margin * 0.5 * scale
	sb.expand_margin_bottom = base_margin * 0.5 * scale
	sb.set_content_margin_all(base_margin * scale)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('background', 'ProgressBar', sb)

	sb = sb.duplicate()
	sb.bg_color = _get_base_color(0.4, 0.8)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_1, floorf(scale))
	set_stylebox('fill', 'ProgressBar', sb)

	# RichTextLabel

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.5)
	sb.set_content_margin_all(base_margin * 1.5 * scale)
	set_stylebox('normal', 'RichTextLabel', sb)

	# ScrollContainer

	set_stylebox('focus', 'ScrollContainer', base_empty_sb)

	# SplitContainer

	set_constant('minimum_grab_thickness', 'SplitContainer', int(base_margin * 1.5 * scale))
	set_constant('separation', 'SplitContainer', int(base_margin * 0.75 * scale))

	var empty_texture : PlaceholderTexture2D = PlaceholderTexture2D.new()
	empty_texture.size = Vector2(0, 0)
	set_icon('h_grabber', 'SplitContainer', empty_texture)
	set_icon('v_grabber', 'SplitContainer', empty_texture)

	# TabContainer

	sb = base_sb.duplicate()
	_set_margin(sb, base_margin * 3.5, base_margin * 2, base_margin * 3.5, base_margin * 1.5)
	sb.set_corner_radius_all(0)
	sb.border_width_top = int(2 * scale)
	var col : Color = accent_color
	col.v = 0.5
	col.s = 0.5
	sb.border_color = col
	set_stylebox('tab_selected', 'TabBar', sb)
	set_stylebox('tab_selected', 'TabContainer', sb)

	sb = sb.duplicate()
	sb.bg_color = _get_base_color(-0.35)
	set_stylebox('tab_selected', 'TabContainerOdd', sb)

	sb = sb.duplicate()
	sb.bg_color = base_color
	sb.border_color = accent_color
	set_stylebox('tab_focus', 'TabBar', sb)
	set_stylebox('tab_focus', 'TabContainer', sb)

	sb = sb.duplicate()
	sb.bg_color = Color.TRANSPARENT
	sb.set_border_width_all(0)
	set_stylebox('tab_unselected', 'TabBar', sb)
	set_stylebox('tab_unselected', 'TabContainer', sb)

	sb = sb.duplicate()
	sb.bg_color = _get_base_color(-0.5)
	set_stylebox('tab_hovered', 'TabBar', sb)
	set_stylebox('tab_hovered', 'TabContainer', sb)

	sb = base_sb.duplicate()
	sb.set_content_margin_all(increased_margin * 1.5 * scale)
	sb.set_corner_radius_all(0)
	sb.corner_radius_bottom_right = int(corner_radius * scale)
	sb.corner_radius_bottom_left = int(corner_radius * scale)
	set_stylebox('panel', 'TabContainer', sb)

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-1.0)
	sb.set_content_margin_all(0)
	sb.set_corner_radius_all(0)	
	set_stylebox('tabbar_background', 'TabContainer', sb)

	# Tree

	set_color('drop_position_color', 'Tree', mono_color * Color(1, 1, 1, 0.4))
	set_color('font_color', 'Tree', mono_color * Color(1, 1, 1, 0.7))
	set_color('guide_color', 'Tree', Color.TRANSPARENT)
	set_color('parent_hl_line_color', 'Tree', mono_color * Color(1, 1, 1, relationship_line_opacity))
	set_constant('children_hl_line_width', 'Tree', 0)
	set_constant('draw_guides', 'Tree', 0)
	set_constant('draw_relationship_lines', 'Tree', 1)
	set_constant('inner_item_margin_left', 'Tree', int(base_margin * scale))
	set_constant('inner_item_margin_right', 'Tree', int(base_margin * scale))
	set_constant('parent_hl_line_width', 'Tree', int(ceilf(scale)))
	set_constant('relationship_line_width', 'Tree', 0)
	set_constant('v_separation', 'Tree', int(base_margin * 0.25 * scale))

	sb = base_sb.duplicate()
	sb.set_content_margin_all(base_margin * 2 * scale)
	set_stylebox('panel', 'Tree', sb)

	# Leaving focus empty for trees and scroll containers because there's no way to
	# make focus indication look not janky when only a part of a dock is highlighted
	set_stylebox('focus', 'Tree', base_empty_sb)

	# Rounded corners look a little janky in tree titles because there's no way to
	# introduce gaps between columns, however not having rounded corners looks even worse
	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-1.2 if dark_theme else -1.8)
	set_stylebox('title_button_hover', 'Tree', sb)
	set_stylebox('title_button_normal', 'Tree', sb)
	set_stylebox('title_button_pressed', 'Tree', sb)

	sb = flat_button_hover_sb.duplicate()
	sb.set_content_margin_all(0)
	set_stylebox('button_hover', 'Tree', sb)
	set_stylebox('hover', 'Tree', sb)
	set_stylebox('hovered_dimmed', 'Tree', sb)
	set_stylebox('custom_button_hover', 'Tree', sb)
	set_stylebox('hovered', 'Tree', sb)
	set_stylebox('selected', 'Tree', sb)
	set_stylebox('selected_focus', 'Tree', sb)

	set_stylebox('button_pressed', 'Tree', flat_button_pressed_sb)
	set_stylebox('custom_button_pressed', 'Tree', flat_button_pressed_sb)

	# Cursor is drawn on top of the item so it needs to be transparent
	sb = base_sb.duplicate()
	sb.bg_color = mono_color * Color(1, 1, 1, 0.04)
	set_stylebox('cursor', 'Tree', sb)
	set_stylebox('cursor_unfocused', 'Tree', sb)

	# Sidebars

	sb = base_sb.duplicate()
	sb.bg_color = _get_base_color(-0.55 if dark_theme else -0.9)
	if draw_extra_borders:
		_set_border(sb, extra_border_color_2, floorf(scale))
	set_stylebox('panel', 'TreeSecondary', sb)
	set_stylebox('panel', 'ItemListSecondary', sb)

# Lighten base color in dark theme, darken in light theme, clamp
func _get_base_color(brightness_offset: float = 0, saturation_multiplier: float = 1) -> Color:
	var dark : bool = dark_theme if brightness_offset >= 0 else !dark_theme
	var color : Color = Color(base_color)
	color.v = clampf(lerpf(color.v, 1 if dark else 0, absf(contrast * brightness_offset)), 0, 1)
	color.s *= saturation_multiplier
	return color

# Shorthand content margin setter
func _set_margin(sb: StyleBox, left: float, top: float, right: float = left, bottom: float = top) -> void:
	sb.content_margin_left = left * scale
	sb.content_margin_top = top * scale
	sb.content_margin_right = right * scale
	sb.content_margin_bottom = bottom * scale

# Shorthand border setter
func _set_border(sb: StyleBoxFlat, color: Color, width: float = 1, blend: bool = false) -> void:
	sb.border_color = color
	sb.border_blend = blend
	sb.set_border_width_all(int(ceilf(width * scale)))
"


[resource]
script = SubResource("GDScript_hhmc0")
    '';
  };
}
