; macros -----------------------------------------------------------------------
%macro printString 1
mov si, %1	                ; Put string position into SI
call print_string	        ; Call our string-printing routine
%endmacro

%macro printLine 1          ; argv si pointer to string
mov si, %1	
call print_string	
call print_newline
%endmacro
; macros -----------------------------------------------------------------------
