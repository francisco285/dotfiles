" Hitting enter between html tags inserts new line and indents cursor position
call lexima#add_rule({'char': '<CR>', 'at': '>\%#<', 'input_after': '<CR>', 'filetype': 'html'})
