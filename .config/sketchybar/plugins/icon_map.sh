#!/bin/bash

function icon_map() {
  case "$1" in
    "Calendar" | "Fantastical" | "Cron" | "Amie")
      icon_result=":calendar:"
      ;;
    "Signal")
      icon_result=":signal:"
      ;;
    "Mattermost")
      icon_result=":mattermost:"
      ;;
    "Microsoft To Do" | "Things")
      icon_result=":things:"
      ;;
    "Godot")
      icon_result=":godot:"
      ;;
    "Neovide" | "neovide")
      icon_result=":neovide:"
      ;;
    "Spotlight")
      icon_result=":spotlight:"
      ;;
    "Dropbox")
      icon_result=":dropbox:"
      ;;
    "Transmit")
      icon_result=":transmit:"
      ;;
    "Rider" | "JetBrains Rider")
      icon_result=":rider:"
      ;;
    "Docker" | "Docker Desktop")
      icon_result=":docker:"
      ;;
    "Pages")
      icon_result=":pages:"
      ;;
    "Bear")
      icon_result=":bear:"
      ;;
    "Keyboard Maestro")
      icon_result=":keyboard_maestro:"
      ;;
    "zoom.us")
      icon_result=":zoom:"
      ;;
    "Music" | "Plexamp")
      icon_result=":music:"
      ;;
    "Discord" | "Discord Canary" | "Discord PTB")
      icon_result=":discord:"
      ;;
    "Neovide" | "MacVim" | "Vim" | "VimR")
      icon_result=":vim:"
      ;;
    "Keynote")
      icon_result=":keynote:"
      ;;
    "iTerm")
      icon_result=":iterm:"
      ;;
    "Finder")
      icon_result=":finder:"
      ;;
    "Xcode")
      icon_result=":xcode:"
      ;;
    "Alfred")
      icon_result=":alfred:"
      ;;
    "Color Picker")
      icon_result=":color_picker:"
      ;;
    "Microsoft Word")
      icon_result=":microsoft_word:"
      ;;
    "Microsoft PowerPoint")
      icon_result=":microsoft_power_point:"
      ;;
    "Notes")
      icon_result=":notes:"
      ;;
    "Sequel Ace")
      icon_result=":sequel_ace:"
      ;;
    "Folx")
      icon_result=":folx:"
      ;;
    "Sequel Pro")
      icon_result=":sequel_pro:"
      ;;
    "Skype")
      icon_result=":skype:"
      ;;
    "PyCharm")
      icon_result=":pycharm:"
      ;;
    "Mail" | "Mailspring" | "Postbox")
      icon_result=":mail:"
      ;;
    "Default")
      icon_result=":default:"
      ;;
    "App Store")
      icon_result=":app_store:"
      ;;
    "Calibre")
      icon_result=":book:"
      ;;
    "Todoist")
      icon_result=":todoist:"
      ;;
    "Messenger")
      icon_result=":messenger:"
      ;;
    "Tower")
      icon_result=":tower:"
      ;;
    "Drafts")
      icon_result=":drafts:"
      ;;
    "Cypress")
      icon_result=":cypress:"
      ;;
    "GitHub Desktop")
      icon_result=":git_hub:"
      ;;
    "Firefox Developer Edition" | "Firefox Nightly")
      icon_result=":firefox_developer_edition:"
      ;;
    "Min")
      icon_result=":min_browser:"
      ;;
    "Sketch")
      icon_result=":sketch:"
      ;;
    "System Preferences" | "System Settings") 
      icon_result=":gear:"
      ;;
    "Arc")
      icon_result=":arc:"
      ;;
    "Chromium" | "Google Chrome" | "Google Chrome Canary")
      icon_result=":google_chrome:"
      ;;
    "Zulip")
      icon_result=":zulip:"
      ;;
    "1Password")
      icon_result=":one_password:"
      ;;
    "FaceTime")
      icon_result=":face_time:"
      ;;
    "Citrix Workspace" | "Citrix Viewer")
      icon_result=":citrix:"
      ;;
    "Logseq")
      icon_result=":logseq:"
      ;;
    "Reeder")
      icon_result=":reeder5:"
      ;;
    "Code" | "Code - Insiders")
      icon_result=":code:"
      ;;
    "Notion")
      icon_result=":notion:"
      ;;
    "Final Cut Pro")
      icon_result=":final_cut_pro:"
      ;;
    "Safari" | "Safari Technology Preview")
      icon_result=":safari:"
      ;;
    "Podcasts") 
      icon_result=":podcasts:"
      ;;
    "NordVPN")
      icon_result=":nord_vpn:"
      ;;
    "Notability")
      icon_result=":notability:"
      ;;
    "Numbers")
      icon_result=":numbers:"
      ;;
    "Microsoft Excel")
      icon_result=":microsoft_excel:"
      ;;
    "Pi-hole Remote")
      icon_result=":pihole:"
      ;;
    "OmniFocus")
      icon_result=":omni_focus:"
      ;;
    "Terminal")
      icon_result=":terminal:"
      ;;
    "Reminders")
      icon_result=":reminders:"
      ;;
    "OBS")
      icon_result=":obsstudio:"
      ;;
    "VMware Fusion")
      icon_result=":vmware_fusion:"
      ;;
    "Microsoft Teams" | "Microsoft Teams classic")
      icon_result=":microsoft_teams:"
      ;;
    "Slack")
      icon_result=":slack:"
      ;;
    "TIDAL")
      icon_result=":tidal:"
      ;;
    "Messages")
      icon_result=":messages:"
      ;;
    "Brave Browser")
      icon_result=":brave_browser:"
      ;;
    "Preview")
      icon_result=":pdf:"
      ;;
    "Obsidian")
      icon_result=":obsidian:"
      ;;
    "Thunderbird")
      icon_result=":thunderbird:"
      ;;
    "Firefox")
      icon_result=":firefox:"
      ;;
    "WezTerm")
      icon_result=":wezterm:"
      ;;
    *)
      icon_result=":default:"
      ;;
  esac
}

icon_map "$1"
echo "$icon_result"
