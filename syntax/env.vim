" Clear existing syntax rules to avoid conflicts
syntax clear

" Key (environment variable names)
syntax match EnvKey /^\zs.\{-}\ze=/ " Matches valid keys (e.g., MY_KEY)

" Assignment operator (the `=` sign itself)
syntax match EnvAssign /=/ containedin=ALL

" Value Types
syntax match EnvValueBoolean /=\(false\|true\)/ containedin=ALL   " Boolean values
syntax match EnvValueNumber /=\d\+/ containedin=ALL               " Numeric values
syntax match EnvValueQuoted /="\([^"]*\)"/ containedin=ALL        " Double-quoted string values
syntax match EnvValueUnquoted /=[^"#]\+/ containedin=ALL          " Unquoted string values

" Comments
syntax match EnvComment /#.*/ " Comments starting with `#`

" Highlighting links
highlight link EnvKey Identifier
highlight link EnvValueQuoted String
highlight link EnvValueUnquoted String
highlight link EnvValueBoolean Boolean
highlight link EnvValueNumber Number
highlight link EnvComment Comment
highlight link EnvAssign Operator