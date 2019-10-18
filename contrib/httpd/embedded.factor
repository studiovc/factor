IN: embedded
USING: sequences kernel parser math namespaces io lists ;

! if example.fhtml contains:
! <html>
!     <head><title>Simple Embedded Factor Example</title></head>
!     <body>
! 	<% 5 [ %><p>I like repetition</p>
!       <% drop ] each %>
!     </body>
! </html>
!
! then "example.fhtml" run-embedded-file prints to stdout:
! <html>
!     <head><title>Simple Embedded Factor Example</title></head>
!     <body>
!         <p>I like repetition</p>
!         <p>I like repetition</p>
!         <p>I like repetition</p>
!         <p>I like repetition</p>
!         <p>I like repetition</p>
! 
!     </body>
! </html>

: get-text ( string -- remainder chunk )
    "<%" over start dup -1 = [
	drop "" swap
    ] [
	swap 2dup head >r tail r>
    ] if ;

: get-embedded ( "<%code%>blah" -- "blah" "code" )
    ! regexps where art thou?
    "%>" over 2 start* 2dup swap 2 -rot subseq >r 2 + swap tail r> ;

: get-first-chunk ( string -- string )
    dup "<%" head? [
	get-embedded parse %
    ] [
	get-text , \ write ,
    ] if ;

: embedded>factor ( string -- )
    dup length 0 > [
	get-first-chunk embedded>factor
    ] [ drop ] if ;

: parse-embedded ( string -- quot )
    #! simple example: "numbers: <% 3 [ 1 + pprint ] each %>"
    #! => "\"numbers: \" write 3 [ 1 + pprint ] each"
    [ embedded>factor ] f make ;

: eval-embedded ( string -- ) parse-embedded call ;

: open-embedded-file ( filename -- str )
    <file-reader> lines "\n" join ;

: with-embedded-file ( filename quot -- )
    [
        over file set ! so that reload works properly
        >r <file-reader> lines "\n" join r> call
    ] with-scope ;

: parse-embedded-file ( filename -- quot )
    [ parse-embedded ] with-embedded-file ;

: run-embedded-file ( filename -- )
    [ eval-embedded ] with-embedded-file ;
