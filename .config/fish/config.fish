function fish_prompt
    # set_color normal
    # echo -n 'クリストファー'
    # set_color $fish_color_cwd
    # echo -n (prompt_pwd)
    # set_color normal
    # echo -n '>'

    set_color normal
    echo -n 'chris'
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n '>'

    powerline-daemon -q
    set POWERLINE_BASH_CONTINUATION 1
    set POWERLINE_BASH_SELECT 1
end

function fish_greeting
    set -g -x NAME 'クリストファー'
    neofetch --ascii_distro "Windows 10"
    # powerline-setup
end

