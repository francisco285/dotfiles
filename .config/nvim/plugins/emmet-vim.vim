let g:user_emmet_leader_key=','

let g:user_emmet_install_global = 0
autocmd FileType html,css,js,jsx,ts,tsx EmmetInstall

let g:user_emmet_settings = {
  \"html": {
    \'indentation' : '  ',
    \'snippets': {
    \'html:5': "<!DOCTYPE html>\n"
              \."<html lang=\"${lang}\">\n"
              \.  "\t<head>\n"
              \.      "\t\t<meta charset=\"${charset}\">"
              \.      "\n\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n\n"
              \.      "\t\t<title>${1}</title>\n"
              \.    "\t</head>\n"
              \.    "\t<body>\n"
              \.      "\t\t${0}\n"
              \.  "\t</body>\n"
              \."</html>"
    \}
  \}
\}
