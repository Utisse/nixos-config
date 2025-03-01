{ config,...}:
{
home.file = {
    ".config/waybar/watch_course.sh".text = ''
      #!/bin/bash
      cat /tmp/current_course'';
    #".config/wallpaper/recolor_wallpaper.sh".text = ''
    # gm convert -background "#${config.lib.stylix.colors.base00}" -flatten nix-transp.png /home/lorev/nixos-config/config/wallpaper/nix-colored.png
    #'';
    ".config/wallpaper/nix-transp.png".source = ./config/wallpaper/nix-transp.png;
    #".config/emacs/init.el".source = ./config/emacs/init.el;
    ".config/godot/editor_settings-4.3.tres".text = '' 
   [gd_resource type="EditorSettings" format=3]

[resource]
interface/editor/display_scale = 3
interface/editor/show_update_spinner = false
interface/theme/base_color = ${config.lib.stylix.colors.base00} 
interface/theme/accent_color =${config.lib.stylix.colors.base01} 
interface/theme/contrast = 0.3
text_editor/theme/highlighting/symbol_color = Color(0.67, 0.79, 1, 1)
text_editor/theme/highlighting/keyword_color = Color(1, 0.44, 0.52, 1)
text_editor/theme/highlighting/control_flow_keyword_color = Color(1, 0.55, 0.8, 1)
text_editor/theme/highlighting/base_type_color = Color(0.26, 1, 0.76, 1)
text_editor/theme/highlighting/engine_type_color = Color(0.56, 1, 0.86, 1)
text_editor/theme/highlighting/user_type_color = Color(0.78, 1, 0.93, 1)
text_editor/theme/highlighting/comment_color = Color(0.8025, 0.81, 0.8225, 0.5)
text_editor/theme/highlighting/doc_comment_color = Color(0.6, 0.7, 0.8, 0.8)
text_editor/theme/highlighting/string_color = Color(1, 0.93, 0.63, 1)
text_editor/theme/highlighting/background_color = Color(0.1155, 0.132, 0.1595, 1)
text_editor/theme/highlighting/completion_background_color = Color(0.21, 0.24, 0.29, 1)
text_editor/theme/highlighting/completion_selected_color = Color(1, 1, 1, 0.07)
text_editor/theme/highlighting/completion_existing_color = Color(1, 1, 1, 0.14)
text_editor/theme/highlighting/completion_font_color = Color(0.8025, 0.81, 0.8225, 1)
text_editor/theme/highlighting/text_color = Color(0.8025, 0.81, 0.8225, 1)
text_editor/theme/highlighting/line_number_color = Color(0.8025, 0.81, 0.8225, 0.5)
text_editor/theme/highlighting/safe_line_number_color = Color(0.8025, 0.972, 0.8225, 0.75)
text_editor/theme/highlighting/caret_color = Color(1, 1, 1, 1)
text_editor/theme/highlighting/selection_color = Color(0.44, 0.73, 0.98, 0.4)
text_editor/theme/highlighting/brace_mismatch_color = Color(1, 0.47, 0.42, 1)
text_editor/theme/highlighting/current_line_color = Color(1, 1, 1, 0.07)
text_editor/theme/highlighting/line_length_guideline_color = Color(0.21, 0.24, 0.29, 1)
text_editor/theme/highlighting/word_highlighted_color = Color(1, 1, 1, 0.07)
text_editor/theme/highlighting/number_color = Color(0.63, 1, 0.88, 1)
text_editor/theme/highlighting/function_color = Color(0.34, 0.7, 1, 1)
text_editor/theme/highlighting/member_variable_color = Color(0.736, 0.88, 1, 1)
text_editor/theme/highlighting/mark_color = Color(1, 0.47, 0.42, 0.3)
text_editor/theme/highlighting/breakpoint_color = Color(1, 0.47, 0.42, 1)
text_editor/theme/highlighting/code_folding_color = Color(1, 1, 1, 0.27)
text_editor/theme/highlighting/search_result_color = Color(1, 1, 1, 0.07)
text_editor/appearance/lines/word_wrap = 1
text_editor/behavior/files/auto_reload_scripts_on_external_change = true
text_editor/completion/idle_parse_delay = 0.81
editors/tiles_editor/display_grid = false
run/platforms/linuxbsd/prefer_wayland = true
network/connection/network_mode = 1
asset_library/available_urls = {
"godotengine.org (Official)": "https://godotengine.org/asset-library/api"
}
asset_library/use_threads = true
export/android/java_sdk_path = "/home/lorev/.nix-profile/bin/java"
export/android/android_sdk_path = ""
export/android/debug_keystore = ""
export/android/debug_keystore_user = "androiddebugkey"
export/android/debug_keystore_pass = "android"
export/android/force_system_user = false
export/android/shutdown_adb_on_exit = true
export/android/one_click_deploy_clear_previous_install = false
export/android/use_wifi_for_remote_debug = false
export/android/wifi_remote_debug_host = "localhost"
export/macos/rcodesign = ""
export/web/http_host = "localhost"
export/web/http_port = 8060
export/web/use_tls = false
export/web/tls_key = ""
export/web/tls_certificate = ""
export/windows/rcedit = ""
export/windows/osslsigncode = ""
export/windows/wine = ""
_default_feature_profile = ""
interface/editors/show_scene_tree_root_selection = true
interface/editors/derive_script_globals_by_name = true
docks/scene_tree/ask_before_deleting_related_animation_tracks = true
_use_favorites_root_selection = false
filesystem/file_server/port = 6010
filesystem/file_server/password = ""
editors/3d/manipulator_gizmo_size = 80
editors/3d/manipulator_gizmo_opacity = 0.9
editors/3d/navigation/show_viewport_rotation_gizmo = true
editors/3d/navigation/show_viewport_navigation_gizmo = false
text_editor/behavior/files/auto_reload_and_parse_scripts_on_save = true
text_editor/behavior/files/open_dominant_script_on_scene_change = true
text_editor/external/use_external_editor = true
text_editor/external/exec_path = "/home/lorev/archive/godot_projects/godot_open_in_nvim.sh"
text_editor/script_list/script_temperature_enabled = true
text_editor/script_list/script_temperature_history_size = 15
text_editor/script_list/group_help_pages = true
text_editor/script_list/sort_scripts_by = 0
text_editor/script_list/list_script_names_as = 0
text_editor/external/exec_flags = "{file}"
version_control/username = ""
version_control/ssh_public_key_path = ""
version_control/ssh_private_key_path = ""
editors/bone_mapper/handle_colors/unset = Color(0.3, 0.3, 0.3, 1)
editors/bone_mapper/handle_colors/set = Color(0.1, 0.6, 0.25, 1)
editors/bone_mapper/handle_colors/missing = Color(0.8, 0.2, 0.8, 1)
editors/bone_mapper/handle_colors/error = Color(0.8, 0.2, 0.2, 1)
network/debug_adapter/remote_port = 6006
network/debug_adapter/request_timeout = 1000
network/debug_adapter/sync_breakpoints = true
editors/3d_gizmos/gizmo_settings/path3d_tilt_disk_size = 0.8
editors/3d_gizmos/gizmo_colors/path = Color(0.5, 0.5, 1, 0.9)
editors/3d_gizmos/gizmo_colors/path_tilt = Color(1, 1, 0.4, 0.9)
editors/3d_gizmos/gizmo_colors/skeleton = Color(1, 0.8, 0.4, 1)
editors/3d_gizmos/gizmo_colors/selected_bone = Color(0.8, 0.3, 0, 1)
editors/3d_gizmos/gizmo_settings/bone_axis_length = 0.1
editors/3d_gizmos/gizmo_settings/bone_shape = 1
editors/3d_gizmos/gizmo_colors/csg = Color(0, 0.4, 1, 0.15)
editors/grid_map/editor_side = 1
editors/grid_map/palette_min_width = 230
editors/grid_map/preview_size = 64
export/ssh/ssh = ""
export/ssh/scp = ""
network/language_server/remote_host = "127.0.0.1"
network/language_server/remote_port = 6005
network/language_server/enable_smart_resolve = true
network/language_server/show_native_symbols_in_editor = true
network/language_server/use_thread = false
network/language_server/poll_limit_usec = 100000
editors/3d_gizmos/gizmo_colors/camera = Color(0.8, 0.4, 0.8, 1)
editors/3d_gizmos/gizmo_colors/stream_player_3d = Color(0.4, 0.8, 1, 1)
editors/3d_gizmos/gizmo_colors/occluder = Color(0.8, 0.5, 1, 1)
editors/3d_gizmos/gizmo_colors/visibility_notifier = Color(0.8, 0.5, 0.7, 1)
editors/3d_gizmos/gizmo_colors/particles = Color(0.8, 0.7, 0.4, 1)
editors/3d_gizmos/gizmo_colors/particle_attractor = Color(1, 0.7, 0.5, 1)
editors/3d_gizmos/gizmo_colors/particle_collision = Color(0.5, 0.7, 1, 1)
editors/3d_gizmos/gizmo_colors/reflection_probe = Color(0.6, 1, 0.5, 1)
editors/3d_gizmos/gizmo_colors/decal = Color(0.6, 0.5, 1, 1)
editors/3d_gizmos/gizmo_colors/voxel_gi = Color(0.5, 1, 0.6, 1)
editors/3d_gizmos/gizmo_colors/lightmap_lines = Color(0.5, 0.6, 1, 1)
editors/3d_gizmos/gizmo_colors/lightprobe_lines = Color(0.5, 0.6, 1, 1)
editors/3d_gizmos/gizmo_colors/joint_body_a = Color(0.6, 0.8, 1, 1)
editors/3d_gizmos/gizmo_colors/joint_body_b = Color(0.6, 0.9, 1, 1)
editors/3d_gizmos/gizmo_colors/fog_volume = Color(0.5, 0.7, 1, 1)
text_editor/theme/highlighting/gdscript/function_definition_color = Color(0.4, 0.9, 1, 1)
text_editor/theme/highlighting/gdscript/global_function_color = Color(0.64, 0.64, 0.96, 1)
text_editor/theme/highlighting/gdscript/node_path_color = Color(0.72, 0.77, 0.49, 1)
text_editor/theme/highlighting/gdscript/node_reference_color = Color(0.39, 0.76, 0.35, 1)
text_editor/theme/highlighting/gdscript/annotation_color = Color(1, 0.7, 0.45, 1)
text_editor/theme/highlighting/gdscript/string_name_color = Color(1, 0.76, 0.65, 1)
text_editor/theme/highlighting/comment_markers/critical_color = Color(0.77, 0.35, 0.35, 1)
text_editor/theme/highlighting/comment_markers/warning_color = Color(0.72, 0.61, 0.48, 1)
text_editor/theme/highlighting/comment_markers/notice_color = Color(0.56, 0.67, 0.51, 1)
text_editor/theme/highlighting/comment_markers/critical_list = "ALERT,ATTENTION,CAUTION,CRITICAL,DANGER,SECURITY"
text_editor/theme/highlighting/comment_markers/warning_list = "BUG,DEPRECATED,FIXME,HACK,TASK,TBD,TODO,WARNING"
text_editor/theme/highlighting/comment_markers/notice_list = "INFO,NOTE,NOTICE,TEST,TESTING"
text_editor/help/sort_functions_alphabetically = true
editors/animation/lines/word_wrap = 0
metadata/script_setup_templates_dictionary = {
"Area2D": "0NodeDefault",
"Button": "0NodeDefault",
"CharacterBody2D": "0CharacterBody2DBasic Movement",
"Label": "0NodeDefault",
"Node": "0NodeDefault",
"Node2D": "0NodeDefault",
"Sprite2D": "0NodeDefault"
}
metadata/script_setup_use_script_templates = true
metadata/export_template_download_directory = "/home/lorev/.cache/godot"
''; 
  };
}
