tell application "TextWrangler"
	set w to window 1
	if w is missing value then set w to disk browser window 1
	if w is missing value then return false
	set firstLine to startLine of selection of w
	set lastLine to endLine of selection of w
	shift selection of w direction left without shifting by spaces
	if firstLine = lastLine then
		find "^[	 ]+" searching in selection of text window 1 options {search mode:grep, starting at top:false, wrap around:false, backwards:false, case sensitive:false, match words:false, extend selection:false} with selecting match
		set col to endColumn of selection of w
		if col = 1 then
			select insertion point before selection of w
		else
			select insertion point after selection of w
		end if
	end if
end tell
