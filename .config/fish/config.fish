function fish_prompt
    set_color normal
    echo -n 'クリストファー'
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n '>'
end

function fish_greeting
    screenfetch -w
end
