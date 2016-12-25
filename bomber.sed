# Originally developed by Andrey Bova
# 10/12/2016

/^\[cmd/ {
    /\[cmd_1_up\]/    { g; b 1_up;        }
    /\[cmd_1_down\]/  { g; b 1_down;      }
    /\[cmd_1_left\]/  { g; b 1_left;      }
    /\[cmd_1_right\]/ { g; b 1_right;     }
    /\[cmd_1_plant\]/ { g; b 1_terrorist; }
    /\[cmd_2_up\]/    { g; b 2_up;        }
    /\[cmd_2_down\]/  { g; b 2_down;      }
    /\[cmd_2_left\]/  { g; b 2_left;      }
    /\[cmd_2_right\]/ { g; b 2_right;     }
    /\[cmd_2_plant\]/ { g; b 2_terrorist; }
    /\[cmd_3_up\]/    { g; b 3_up;        }
    /\[cmd_3_down\]/  { g; b 3_down;      }
    /\[cmd_3_left\]/  { g; b 3_left;      }
    /\[cmd_3_right\]/ { g; b 3_right;     }
    /\[cmd_3_plant\]/ { g; b 3_terrorist; }
    /\[cmd_4_up\]/    { g; b 4_up;        }
    /\[cmd_4_down\]/  { g; b 4_down;      }
    /\[cmd_4_left\]/  { g; b 4_left;      }
    /\[cmd_4_right\]/ { g; b 4_right;     }
    /\[cmd_4_plant\]/ { g; b 4_terrorist; }
    /\[cmd_nothing\]/ { g; b print;       }
    b end;
}

#$ s/$/\n\n\n\n/
H; b end

:print
    /bomb/b terrorism_handler
:print_flashback
/\[ai_[2-4]_cmd_complete\]/b print_to_ai_handler
    b distance_check
:print_to_ai_handler    
/^.*2.*\[FIELD_END\]/ b second_terrorist_ai
:ai_2_finish
/^.*3.*\[FIELD_END\]/ b third_terrorist_ai
:ai_3_finish
/^.*4.*\[FIELD_END\]/ b fourth_terrorist_ai
:ai_4_finish
b  ai_cmds_completed
:print_after_ai
    #remove last command and save current game state to hold buffer
    s/\n{2,}//
    s/\[cmd_.*\]\n//; h

    #bomb's blinking
    /first_bomb_timer_1+\]/ {
        /first_bomb_timer_1{,10}\]/ {
            /first_bomb_timer_(11)+\]/     s/([1-4.=#])@/\1./
        }
        /first_bomb_timer_1{10,20}\]/ {
            /first_bomb_timer_(111)+\]/     s/([1-4.=#])@/\1./
        }
        /first_bomb_timer_1{20}\]/ {
            /first_bomb_timer_(1111111)+\]/ s/([1-4.=#])@/\1./
        }
    }

    /second_bomb_timer_1+\]/ {
        /second_bomb_timer_1{,10}\]/ {
            /second_bomb_timer_(11)+\]/      s/([1-4.=#])a/\1./
        }
        /second_bomb_timer_1{10,20}\]/ {
            /second_bomb_timer_(111)+\]/     s/([1-4.=#])a/\1./
        }
        /second_bomb_timer_1{20}\]/ {
            /second_bomb_timer_(111111)+\]/  s/([1-4.=#])a/\1./
        }
    }

    /third_bomb_timer_1+\]/ {
        /third_bomb_timer_1{,10}\]/ {
            /third_bomb_timer_(11)+\]/      s/0/./
        }
        /third_bomb_timer_1{10,20}\]/ {
            /third_bomb_timer_(111)+\]/     s/0/./
        }
        /third_bomb_timer_1{20}\]/ {
            /third_bomb_timer_(111111)+\]/  s/0/./
        }
    }

    /fourth_bomb_timer_1+\]/ {
        /fourth_bomb_timer_1{,10}\]/ {
            /fourth_bomb_timer_(11)+\]/      s/([1-4.=#])o/\1./
        }
        /fourth_bomb_timer_1{10,20}\]/ {
            /fourth_bomb_timer_(111)+\]/     s/([1-4.=#])o/\1./
        }
        /fourth_bomb_timer_1{20}\]/ {
            /fourth_bomb_timer_(111111)+\]/  s/([1-4.=#])o/\1./
        }
    }


    #planting player's blinking
    /first_planting/    { /first_bomb_timer_(111)+\]/  s/1/@/ }
    /first_bomb_blast/  { s/([1-4.=#*])@/\1*/;    
                          /first_planting/  s/([1-4.=#])1/\1*/ }

    /second_planting/   { /second_bomb_timer_(111)+\]/ s/2/a/ }
    /second_bomb_blast/ { s/([1-4.=#*])a/\1*/;    
                          /second_planting/ s/([1-4.=#])2/\1*/ }

    /third_planting/    { /third_bomb_timer_(111)+\]/  s/3/0/ }
    /third_bomb_blast/  { s/([1-4.=#*])0/\1*/;    
                          /third_planting/  s/([1-4.=#])3/\1*/ }

    /fourth_planting/   { /fourth_bomb_timer_(111)+\]/ s/4/o/ }
    /fourth_bomb_blast/ { s/([1-4.=#*])o/\1*/;
                          /fourth_planting/ s/([1-4.=#])4/\1*/ }

    s/\./ /g
    /\[DEBUG_MODE\]/ {
        /\[DEBUG_MODE_NODIST\]/ s/\[dis.*:dis.{3}\]//g
        s/\]/\]\n/g
        s/^/[2J/
    }
    /\[DEBUG_MODE\]/! { 
        s/\[.*\]//g
        s/^/[H/
    }
    p; b end

:1_left
    s/\.1/1MOVED./g
    /1MOVED.*first_planting/ {
        s/1MOVED\./1@/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:1_right
    s/1\./.1MOVED/
    /1MOVED.*first_planting/ {
        s/\.1MOVED/@1/
        s/\[status_first_planting\]//
    }
    s/1MOVED/1/    
    b print

:1_up
    s/\.(.{79})1/1MOVED\1./
    /1MOVED.*first_planting/ {
        s/1MOVED(.{79})\./1\1@/
        s/\[status_first_planting\]//
    }
    s/1MOVED/1/
    b print

:1_down
    s/1(.{79})\./.\11MOVED/ 
    /1MOVED.*first_planting/ {
        s/\.(.{79})1MOVED/@\11/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:1_terrorist
    /first_bomb_/ {
        b print
    }
    s/$/\[status_first_planting\]/
    s/$/\[status_first_bomb_timer_1111111111111111111111111111111\]/
    b print

#SECOND PLAYER
:2_left
    s/\.2/2MOVED./
    /2MOVED.*second_planting/ {
        s/2MOVED\./2a/
        s/\[status_second_planting\]//
    }
    s/2MOVED/2/    
    b print

:2_right
    s/2\./.2MOVED/
    /2MOVED.*second_planting/ {
        s/\.2MOVED/a2/
        s/\[status_second_planting\]//
    }
    s/2MOVED/2/    
    b print

:2_up
    s/\.(.{79})2/2MOVED\1./
    /2MOVED.*second_planting/ {
        s/2MOVED(.{79})\./2\1a/
        s/\[status_second_planting\]//
    }
    s/2MOVED/2/
    b print

:2_down
    s/2(.{79})\./.\12MOVED/ 
    /2MOVED.*second_planting/ {
        s/\.(.{79})2MOVED/a\12/
        s/\[status_second_planting\]//
    }
    s/2MOVED/2/
    b print

:2_terrorist
    /second_bomb_/ {
        b print
    }
    s/$/\[status_second_planting\]/
    s/$/\[status_second_bomb_timer_1111111111111111111111111111111\]/
    b print

#THIRD PLAYER
:3_left
    s/\.3/3MOVED./
    /3MOVED.*third_planting/ {
        s/3MOVED\./30/
        s/\[status_third_planting\]//
    }
    s/3MOVED/3/
    b print

:3_right
    s/3\./.3MOVED/
    /3MOVED.*third_planting/ {
        s/\.3MOVED/03/
        s/\[status_third_planting\]//
    }
    s/3MOVED/3/    
    b print

:3_up
    s/\.(.{79})3/3MOVED\1./
    /3MOVED.*third_planting/ {
        s/3MOVED(.{79})\./3\10/
        s/\[status_third_planting\]//
    }
    s/3MOVED/3/
    b print

:3_down
    s/3(.{79})\./.\13MOVED/ 
    /3MOVED.*third_planting/ {
        s/\.(.{79})3MOVED/0\13/
        s/\[status_third_planting\]//
    }
    s/3MOVED/3/
    b print

:3_terrorist
    /third_bomb_/ {
        b print
    }
    s/$/\[status_third_planting\]/
    s/$/\[status_third_bomb_timer_1111111111111111111111111111111\]/
    b print

#FOURTH PLAYER
:4_left
    s/\.4/4MOVED./
    /4MOVED.*fourth_planting/ {
        s/4MOVED\./4o/
        s/\[status_fourth_planting\]//
    }
    s/4MOVED/4/
    b print

:4_right
    s/4\./.4MOVED/
    /4MOVED.*fourth_planting/ {
        s/\.4MOVED/o4/
        s/\[status_fourth_planting\]//
    }
    s/4MOVED/4/
    b print

:4_up
    s/\.(.{79})4/4MOVED\1./
    /4MOVED.*fourth_planting/ {
        s/4MOVED(.{79})\./4\1o/
        s/\[status_fourth_planting\]//
    }
    s/4MOVED/4/
    b print

:4_down
    s/4(.{79})\./.\14MOVED/ 
    /4MOVED.*fourth_planting/ {
        s/\.(.{79})4MOVED/o\14/
        s/\[status_fourth_planting\]//
    }
    s/4MOVED/4/
    b print

:4_terrorist
    /fourth_bomb_/ {
        b print
    }
    s/$/\[status_fourth_planting\]/
    s/$/\[status_fourth_bomb_timer_1111111111111111111111111111111\]/
    b print

:messages_handler 
    #TODO FIX
    s/\[message_immediately_(.*)\]/\n\1/


:terrorism_handler
    /first_bomb_tacted/  b check_next_isis_1
    /first_bomb_timer/   b first_isis_warrior_handler    
    /first_bomb_blast/   b first_bomb_tsss_boom 
  :check_next_isis_1
    /second_bomb_tacted/ b check_next_isis_2
    /second_bomb_timer/  b second_isis_warrior_handler    
    /second_bomb_blast/  b second_bomb_tsss_boom 
  :check_next_isis_2
    /third_bomb_tacted/  b check_next_isis_3
    /third_bomb_timer/   b third_isis_warrior_handler    
    /third_bomb_blast/   b third_bomb_tsss_boom 
  :check_next_isis_3
    /fourth_bomb_tacted/ b print_flashback
    /fourth_bomb_timer/  b fourth_isis_warrior_handler    
    /fourth_bomb_blast/  b fourth_bomb_tsss_boom 
    b print_flashback

:first_isis_warrior_handler
    s/$/\[first_bomb_tacted\]/
    /first_bomb_timer_\]/ {
        b first_bomb_tsss_boom
    }
    #removing one each tact 
    s/(first_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_1

:first_bomb_tsss_boom
    /first_bomb_timer_/ { 
        s/first_bomb_timer_/first_bomb_blast_111/
        b check_next_isis_1 
    }
    /first_planting/b first_commit_suicide

    /first_bomb_blast_111/ {
        s/first_bomb_blast_111/first_bomb_blast_11/
        s/[1-4=.]@(.*\[FIELD_END\])/*@\1/
        s/@[1-4=.](.*\[FIELD_END\])/@*\1/
        s/[1-4=.](.{79})@(.*\[FIELD_END\])/*\1@\2/
        s/@(.{79})[1-4=.](.*\[FIELD_END\])/@\1*\2/
        b check_next_isis_1
    }
    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]\*@(.*\[FIELD_END\])/**@\1/
        s/@\*[1-4=.](.*\[FIELD_END\])/@**\1/
        s/[1-4=.](.{79}\*.{79})@(.*\[FIELD_END\])/*\1@\2/
        s/@(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/@\1*\2/
        b check_next_isis_1
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/\*\*@(.*\[FIELD_END\])/..@\1/
        s/\*@(.*\[FIELD_END\])/.@\1/
        s/@\*\*(.*\[FIELD_END\])/@..\1/
        s/@\*(.*\[FIELD_END\])/@.\1/
        s/\*(.{79}\*.{79})@(.*\[FIELD_END\])/.\1@\2/
        s/\*(.{79})@(.*\[FIELD_END\])/.\1@\2/
        s/@(.{79}\*.{79})\*(.*\[FIELD_END\])/@\1.\2/
        s/@(.{79})\*(.*\[FIELD_END\])/@\1.\2/
        s/@(.*\[FIELD_END\])/.\1/
        b check_next_isis_1
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
    }
    b check_next_isis_1

:first_commit_suicide
    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]1(.*\[FIELD_END\])/*1\1/
        s/1[1-4=.](.*\[FIELD_END\])/1*\1/
        s/[1-4=.](.{79})1(.*\[FIELD_END\])/*\11\2/
        s/1(.{79})[1-4=.](.*\[FIELD_END\])/1\1*\2/
        b check_next_isis_1
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/[1-4=.]\*1(.*\[FIELD_END\])/**1\1/
        s/1\*[1-4=.](.*\[FIELD_END\])/1**\1/
        s/[1-4=.](.{79}\*.{79})1(.*\[FIELD_END\])/*\11\2/
        s/1(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/1\1*\2/
        b check_next_isis_1
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*\*1(.*\[FIELD_END\])/..1\1/
        s/\*1(.*\[FIELD_END\])/.1\1/
        s/1\*\*(.*\[FIELD_END\])/1..\1/
        s/1\*(.*\[FIELD_END\])/1.\1/
        s/\*(.{79}\*.{79})1(.*\[FIELD_END\])/.\11\2/
        s/\*(.{79})1(.*\[FIELD_END\])/.\11\2/
        s/1(.{79}\*.{79})\*(.*\[FIELD_END\])/1\1.\2/
        s/1(.{79})\*(.*\[FIELD_END\])/1\1.\2/
        s/1(.*\[FIELD_END\])/.\1/
        b check_next_isis_1
    }
    b check_next_isis_1

:second_isis_warrior_handler
    s/$/\[second_bomb_tacted\]/
    /second_bomb_timer_\]/ {
        b second_bomb_tsss_boom
    }
    #removing one each tact 
    s/(second_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_2

:second_bomb_tsss_boom
    /second_bomb_timer_/ {
        s/second_bomb_timer_/second_bomb_blast_11/
        b check_next_isis_2
    }
    /second_planting/b second_commit_suicide

    /second_bomb_blast_11/ {
        s/second_bomb_blast_11/second_bomb_blast_1/
        s/[1-4=.]a(.*\[FIELD_END\])/*a\1/
        s/a[1-4=.](.*\[FIELD_END\])/a*\1/
        s/[1-4=.](.{79})a(.*\[FIELD_END\])/*\1a\2/
        s/a(.{79})[1-4=.](.*\[FIELD_END\])/a\1*\2/
        b check_next_isis_2
    }
    /second_bomb_blast_1/ {
        s/second_bomb_blast_1/second_bomb_blast_/
        s/[1-4=.]\*a(.*\[FIELD_END\])/**a\1/
        s/a\*[1-4=.](.*\[FIELD_END\])/a**\1/
        s/[1-4=.](.{79}\*.{79})a(.*\[FIELD_END\])/*\1a\2/
        s/a(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/a\1*\2/
        b check_next_isis_2
    }
    /second_bomb_blast_/ {
        s/\[status_second_bomb_blast_\]//
        s/\*\*a(.*\[FIELD_END\])/..a\1/
        s/\*a(.*\[FIELD_END\])/.a\1/
        s/a\*\*(.*\[FIELD_END\])/a..\1/
        s/a\*(.*\[FIELD_END\])/a.\1/
        s/\*(.{79}\*.{79})a(.*\[FIELD_END\])/.\1a\2/
        s/\*(.{79})a(.*\[FIELD_END\])/.\1a\2/
        s/a(.{79}\*.{79})(.*\[FIELD_END\])\*/a\1.\2/
        s/a(.{79})\*(.*\[FIELD_END\])/a\1.\2/
        s/a(.*\[FIELD_END\])/.\1/
        b check_next_isis_2
    }
    b check_next_isis_2

:second_commit_suicide
    /second_bomb_blast_11/ {
        s/second_bomb_blast_11/second_bomb_blast_1/
        s/[1-4=.]2(.*\[FIELD_END\])/*2\1/
        s/2[1-4=.](.*\[FIELD_END\])/2*\1/
        s/[1-4=.](.{79})2(.*\[FIELD_END\])/*\12\2/
        s/2(.{79})[1-4=.](.*\[FIELD_END\])/2\1*\2/
        b check_next_isis_2
    }
    /second_bomb_blast_1/ {
        s/second_bomb_blast_1/second_bomb_blast_/
        s/[1-4=.]\*2(.*\[FIELD_END\])/**2\1/
        s/2\*[1-4=.](.*\[FIELD_END\])/2**\1/
        s/[1-4=.](.{79}\*.{79})1(.*\[FIELD_END\])/*\12\2/
        s/2(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/2\1*\2/
        b check_next_isis_2
    }
    /second_bomb_blast_/ {
        s/\[status_second_bomb_blast_\]//
        s/\*\*2(.*\[FIELD_END\])/..2\1/
        s/\*2(.*\[FIELD_END\])/.2\1/
        s/2\*\*(.*\[FIELD_END\])/2..\1/
        s/2\*(.*\[FIELD_END\])/2.\1/
        s/\*(.{79}\*.{79})2(.*\[FIELD_END\])/.\12\2/
        s/\*(.{79})2(.*\[FIELD_END\])/.\12\2/
        s/2(.{79}\*.{79})\*(.*\[FIELD_END\])/2\1.\2/
        s/2(.{79})\*(.*\[FIELD_END\])/2\1.\2/
        s/2(.*\[FIELD_END\])/.\1/
        b check_next_isis_2
    }
    b check_next_isis_2

:third_isis_warrior_handler
    s/$/\[third_bomb_tacted\]/
    /third_bomb_timer_\]/ {
        b third_bomb_tsss_boom
    }
    #removing one each tact 
    s/(third_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_3

:third_bomb_tsss_boom
    /third_bomb_timer_/ { 
        s/third_bomb_timer_/third_bomb_blast_11/
        b check_next_isis_3
    }
    /third_planting/b third_commit_suicide

    /third_bomb_blast_11/ {
        s/third_bomb_blast_11/third_bomb_blast_1/
        s/[1-4=.]0(.*\[FIELD_END\])/*0\1/
        s/0[1-4=.](.*\[FIELD_END\])/0*\1/
        s/[1-4=.](.{79})0(.*\[FIELD_END\])/*\10\2/
        s/0(.{79})[1-4=.](.*\[FIELD_END\])/0\1*\2/
        b check_next_isis_3
    }
    /third_bomb_blast_1/ {
        s/third_bomb_blast_1/third_bomb_blast_/
        s/[1-4=.]\*0(.*\[FIELD_END\])/**0\1/
        s/0\*[1-4=.](.*\[FIELD_END\])/0**\1/
        s/[1-4=.](.{79}\*.{79})0(.*\[FIELD_END\])/*\10\2/
        s/0(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/0\1*\2/
        b check_next_isis_3
    }
    /third_bomb_blast_/ {
        s/\[status_third_bomb_blast_\]//
        s/\*\*0(.*\[FIELD_END\])/..0\1/
        s/\*0(.*\[FIELD_END\])/.0\1/
        s/0\*\*(.*\[FIELD_END\])/0..\1/
        s/0\*(.*\[FIELD_END\])/0.\1/
        s/\*(.{79}\*.{79})0(.*\[FIELD_END\])/.\10\2/
        s/\*(.{79})0(.*\[FIELD_END\])/.\10\2/
        s/0(.{79}\*.{79})\*(.*\[FIELD_END\])/0\1.\2/
        s/0(.{79})\*(.*\[FIELD_END\])/0\1.\2/
        s/0(.*\[FIELD_END\])/.\1/
        b check_next_isis_3
    }
    b check_next_isis_3

:third_commit_suicide
    /third_bomb_blast_11/ {
        s/third_bomb_blast_11/third_bomb_blast_1/
        s/[1-4=.]3(.*\[FIELD_END\])/*3\1/
        s/3[1-4=.](.*\[FIELD_END\])/3*\1/
        s/[1-4=.](.{79})3(.*\[FIELD_END\])/*\13\2/
        s/3(.{79})[1-4=.](.*\[FIELD_END\])/3\1*\2/
        b check_next_isis_3
    }
    /third_bomb_blast_1/ {
        s/third_bomb_blast_1/third_bomb_blast_/
        s/[1-4=.]\*3(.*\[FIELD_END\])/**3\1/
        s/3\*[1-4=.](.*\[FIELD_END\])/3**\1/
        s/[1-4=.](.{79}\*.{79})3(.*\[FIELD_END\])/*\13\2/
        s/3(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/3\1*\2/
        b check_next_isis_3
    }
    /third_bomb_blast_/ {
        s/\[status_third_bomb_blast_\]//
        s/\*\*3(.*\[FIELD_END\])/..3\1/
        s/\*3(.*\[FIELD_END\])/.3\1/
        s/3\*\*(.*\[FIELD_END\])/3..\1/
        s/3\*(.*\[FIELD_END\])/3.\1/
        s/\*(.{79}\*.{79})3(.*\[FIELD_END\])/.\13\2/
        s/\*(.{79})3(.*\[FIELD_END\])/.\13\2/
        s/3(.{79}\*.{79})\*(.*\[FIELD_END\])/3\1.\2/
        s/3(.{79})\*(.*\[FIELD_END\])/3\1.\2/
        s/3(.*\[FIELD_END\])/.\1/
        b check_next_isis_3
    }
    b check_next_isis_3

:fourth_isis_warrior_handler
    s/$/\[fourth_bomb_tacted\]/
    /fourth_bomb_timer_\]/ {
        b fourth_bomb_tsss_boom
    }
    #removing one each tact 
    s/(fourth_bomb_timer_1*)1\]/\1\]/ 
    b print_flashback

:fourth_bomb_tsss_boom
    /fourth_bomb_timer_/ {
        s/fourth_bomb_timer_/fourth_bomb_blast_11/
        b print_flashback
    }
    /fourth_planting/b fourth_commit_suicide

    /fourth_bomb_blast_11/ {
        s/fourth_bomb_blast_11/fourth_bomb_blast_1/
        s/[1-4=.]o(.*\[FIELD_END\])/*o\1/
        s/o[1-4=.](.*\[FIELD_END\])/o*\1/
        s/[1-4=.](.{79})o(.*\[FIELD_END\])/*\1o\2/
        s/o(.{79})[1-4=.](.*\[FIELD_END\])/o\1*\2/
        b print_flashback
    }
    /fourth_bomb_blast_1/ {
        s/fourth_bomb_blast_1/fourth_bomb_blast_/
        s/[1-4=.]\*o(.*\[FIELD_END\])/**o\1/
        s/o\*[1-4=.](.*\[FIELD_END\])/o**\1/
        s/[1-4=.](.{79}\*.{79})o(.*\[FIELD_END\])/*\1o\2/
        s/o(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/o\1*\2/
        b print_flashback
    }
    /fourth_bomb_blast_/ {
        s/\[status_fourth_bomb_blast_\]//
        s/\*\*o(.*\[FIELD_END\])/..o\1/
        s/\*o(.*\[FIELD_END\])/.o\1/
        s/o\*\*(.*\[FIELD_END\])/o..\1/
        s/o\*(.*\[FIELD_END\])/o.\1/
        s/\*(.{79}\*.{79})o(.*\[FIELD_END\])/.\1o\2/
        s/\*(.{79})o(.*\[FIELD_END\])/.\1o\2/
        s/o(.{79}\*.{79})\*(.*\[FIELD_END\])/o\1.\2/
        s/o(.{79})\*(.*\[FIELD_END\])/o\1.\2/
        s/o(.*\[FIELD_END\])/.\1/
        b print_flashback
    }
    b print_flashback

:fourth_commit_suicide
    /fourth_bomb_blast_11/ {
        s/fourth_bomb_blast_11/fourth_bomb_blast_1/
        s/[1-4=.]4(.*\[FIELD_END\])/*4\1/
        s/4[1-4=.](.*\[FIELD_END\])/4*\1/
        s/[1-4=.](.{79})4(.*\[FIELD_END\])/*\14\2/
        s/4(.{79})[1-4=.](.*\[FIELD_END\])/4\1*\2/
        b print_flashback
    }
    /fourth_bomb_blast_1/ {
        s/fourth_bomb_blast_1/fourth_bomb_blast_/
        s/[1-4=.]\*4(.*\[FIELD_END\])/**4\1/
        s/4\*[1-4=.](.*\[FIELD_END\])/4**\1/
        s/[1-4=.](.{79}\*.{79})4(.*\[FIELD_END\])/*\14\2/
        s/4(.{79}\*.{79})[1-4=.](.*\[FIELD_END\])/4\1*\2/
        b print_flashback
    }
    /fourth_bomb_blast_/ {
        s/\[status_fourth_bomb_blast_\]//
        s/\*\*4(.*\[FIELD_END\])/..4\1/
        s/\*4(.*\[FIELD_END\])/.4\1/
        s/4\*\*(.*\[FIELD_END\])/4..\1/
        s/4\*(.*\[FIELD_END\])/4.\1/
        s/\*(.{79}\*.{79})4(.*\[FIELD_END\])/.\14\2/
        s/\*(.{79})4(.*\[FIELD_END\])/.\14\2/
        s/4(.{79}\*.{79})\*(.*\[FIELD_END\])/4\1.\2/
        s/4(.{79})\*(.*\[FIELD_END\])/4\1.\2/
        s/4(.*\[FIELD_END\])/.\1/
        b print_flashback
    }
    b print_flashback


# TO AI&BACK
# AI SCHEME:
#   perform command from query if has_cmd_query
#   else:
#   1) set goal
#   2) handle goal and set cmd_query
# GOALS:
#   AI_SECOND_SEEK_FIRST
#       AI_SECOND_LINE_DOWN
#
#
#
#
#
#
:ai_handler
:second_terrorist_ai
/\[ai_2_cmd_complete\]/b ai_2_cmd_was_completed
#set goals for AI_FSM
  /\[ai_2_cmd_query/! {
    #taking cover
    /[@a0o*](.{79}(\..{79}(\..{79})?)?)2.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /\..{79}\.2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /\.2.{78}\./ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2\..{79}\./ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /\..{78}2\./ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /\.\.2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2\.\./      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /2.{79}\./   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /\[ai_2_taking_cover/! {
        s/(([@a0o])(.{79}(\..{79}(\..{79})?)?)2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2(.{79}(\..{79}(\..{79})?)?)[@a0o*].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /\..{79}\.2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /\.2.{78}\./ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2\..{79}\./ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /\..{78}2\./ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /\.\.2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2\.\./      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\..{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /\[ai_2_taking_cover/! {
        s/(2(.{79}(\..{79}(\..{79})?)?)([@a0o]).*)$/\1\[ai_2_taking_cover_\5\]/
      }
      b ai_2_goal_handler
    }
    
    /[@a0o*]\.?\.?\.?2.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /\..{79}\.2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /\.2.{78}\./ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2\..{79}\./ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /\..{78}2\./ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /2\.\./      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\..{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /2.{79}\./   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /\[ai_2_taking_cover/! { 
        s/(([@a0o])\.?\.?\.?2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2\.?\.?\.?[@a0o*].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_line_(up|down)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /\..{79}\.2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /\.2.{78}\./ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2\..{79}\./ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /\..{78}2\./ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}\.\./ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /\.\.2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /\..{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /2.{79}\./   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /\[ai_2_taking_cover/! {
        s/(2\.?\.?\.?([@a0o]).*)$/\1[ai_2_taking_cover_\2]/
      }
      b ai_2_goal_handler
    }
    #choose target
    s/\[ai_2_target_[1-4]\]//
    /^.*1.*\[FIELD_END\]/! {
        /^.*3.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_4\]/; b ai_2_seeking
        }
        /^.*4.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_3\]/; b ai_2_seeking
        }
        /\[dis_sec_th:(8*):dissth\].*\[dis_sec_fu:\18*:dissfu\]/ {
            s/$/\[ai_2_target_3\]/; b ai_2_seeking
        }
        s/$/\[ai_2_target_4\]/; b ai_2_seeking
    }
    /^.*3.*\[FIELD_END\]/! {
        /^.*1.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_4\]/; b ai_2_seeking
        }
        /^.*4.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_1\]/; b ai_2_seeking
        }
        /\[dis_sec_fir:(8*):dissfi\].*\[dis_sec_fu:\18*:dissfu\]/ {
            s/$/\[ai_2_target_1\]/; b ai_2_seeking
        }
        s/$/\[ai_2_target_4\]/; b ai_2_seeking
    }
    /^.*4.*\[FIELD_END\]/! {
        /^.*1.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_3\]/; b ai_2_seeking
        }
        /^.*3.*\[FIELD_END\]/! {
            s/$/\[ai_2_target_1\]/; b ai_2_seeking
        }
        /\[dis_sec_fir:(8*):dissfi\].*\[dis_sec_th:\18*:dissth\]/ {
            s/$/\[ai_2_target_1\]/; b ai_2_seeking
        }
        s/$/\[ai_2_target_3\]/; b ai_2_seeking
    }
    /\[dis_sec_fir:(8*):dissfi\].*\[dis_sec_th:\18*:dissth\]/ {
      /\[dis_sec_fir:(8*):dissfi\].*\[dis_sec_fu:\18*:dissfu\]/ {
          s/$/\[ai_2_target_1\]/; b ai_2_seeking
      }
      s/$/\[ai_2_target_4\]/; b ai_2_seeking
    }
    /\[dis_sec_th:(8*):dissth\].*\[dis_sec_fu:\18*:dissfu\]/ {
      s/$/\[ai_2_target_3\]/; b ai_2_seeking
    }
    s/$/\[ai_2_target_4\]/ 
    #seeking target
:ai_2_seeking
    /\[ai_2_taking_cover_[@a0o]\]/ b ai_2_goal_handler
    #SEEK TARGET FIRST
    /\[ai_2_target_1\]/ {
    /\[ai_2_goal_line_up\]/! {
        /1([^\n]+\n[^\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /1(.*\n){3,}[^\n]*2.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_up]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#.{78}#2/ {                
                s/$/[ai_2_goal_line_up]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /1[^\n]*#2#/ { s/$/[ai_2_goal_slide_up_left]/; b 21_goal_up_fin; }
            /#2#[^\n]*1/ { s/$/[ai_2_goal_slide_up_right]/;b 21_goal_up_fin; }
            /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :21_goal_up_fin
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            /1(.*\n){2}[^\n]*2.*\[FIELD_END\]/ {
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
              /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
            }
        }        
    }
    /\[ai_2_goal_line_down\]/! {
        /2([^\n]+\n[^[\n]+)+1.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /2(.*\n){3,}[^\n]*1.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_down\]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#2.{78}#/ {
                s/$/[ai_2_goal_line_down]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /1[^\n]*#2#/ {s/$/[ai_2_goal_slide_down_left]/; b 21_goal_down_fin;}
          /#2#[^\n]*1/ {s/$/[ai_2_goal_slide_down_right]/;b 21_goal_down_fin;}
            /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :21_goal_down_fin
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            /2(.*\n){2}[^\n]*1.*\[FIELD_END\]/ {
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
              /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
            }
        }
    }
    
    /\[ai_2_goal_shift_left\]/! {
        /1[^\n#]+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(right|left)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            s/$/[ai_2_goal_shift_left]/
        }
    }

    /\[ai_2_goal_shift_rigth\]/! {
        /2[^\n#]+1.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//
            s/$/[ai_2_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_2_goal_plant_bomb\]/! {
      /[12](\.?|.{79}|.{79}\..{79})[21].*\[FIELD_END\]/ {
          s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET THIRD
    /\[ai_2_target_3\]/ {
    /\[ai_2_goal_line_up\]/! {
        /3([^\n]+\n[^\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /3(.*\n){3,}[^\n]*2.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_up]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#.{78}#2/ {                
                s/$/[ai_2_goal_line_up]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/3(.{79})(.)(.*\[FIELD_END\])/\2\13\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /3[^\n]*#2#/ { s/$/[ai_2_goal_slide_up_left]/; b 23_goal_up_fin; }
            /#2#[^\n]*3/ { s/$/[ai_2_goal_slide_up_right]/;b 23_goal_up_fin; }
            /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :23_goal_up_fin
            s/(.)(.{79})3(.*\[FIELD_END\])/3\2\1\3/
            /3(.*\n){2}[^\n]*2.*\[FIELD_END\]/ {
              s/3(.{159})(.)(.*\[FIELD_END\])/\2\13\3/ 
              /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/(.)(.{159})3(.*\[FIELD_END\])/3\2\1\3/
            }
        }        
    }
    /\[ai_2_goal_line_down\]/! {
        /2([^\n]+\n[^[\n]+)+3.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /2(.*\n){3,}[^\n]*3.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_down\]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#2.{78}#/ {
                s/$/[ai_2_goal_line_down]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})3(.*\[FIELD_END\])/3\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /3[^\n]*#2#/ {s/$/[ai_2_goal_slide_down_left]/; b 23_goal_down_fin;}
          /#2#[^\n]*3/ {s/$/[ai_2_goal_slide_down_right]/;b 23_goal_down_fin;}
            /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :23_goal_down_fin
            s/3(.{79})(.)(.*\[FIELD_END\])/\2\13\3/ 
            /2(.*\n){2}[^\n]*3.*\[FIELD_END\]/ {
              s/(.)(.{159})3(.*\[FIELD_END\])/3\2\1\3/
              /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/3(.{159})(.)(.*\[FIELD_END\])/\2\13\3/ 
            }
        }
    }
    
    /\[ai_2_goal_shift_left\]/! {
        /3[^\n#]+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(right|left)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            s/$/[ai_2_goal_shift_left]/
        }
    }

    /\[ai_2_goal_shift_rigth\]/! {
        /2[^\n#]+3.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//
            s/$/[ai_2_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_2_goal_plant_bomb\]/! {
      /[32](\.?|.{79}|.{79}\..{79})[23].*\[FIELD_END\]/ {
          s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET FOURTH
    /\[ai_2_target_4\]/ {
    /\[ai_2_goal_line_up\]/! {
        /4([^\n]+\n[^\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /4(.*\n){3,}[^\n]*2.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_up]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#.{78}#2/ {                
                s/$/[ai_2_goal_line_up]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/4(.{79})(.)(.*\[FIELD_END\])/\2\14\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /4[^\n]*#2#/ { s/$/[ai_2_goal_slide_up_left]/; b 24_goal_up_fin; }
            /#2#[^\n]*4/ { s/$/[ai_2_goal_slide_up_right]/;b 24_goal_up_fin; }
            /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :24_goal_up_fin
            s/(.)(.{79})4(.*\[FIELD_END\])/4\2\1\3/
            /4(.*\n){2}[^\n]*2.*\[FIELD_END\]/ {
              s/4(.{159})(.)(.*\[FIELD_END\])/\2\14\3/ 
              /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/(.)(.{159})4(.*\[FIELD_END\])/4\2\1\3/
            }
        }        
    }
    /\[ai_2_goal_line_down\]/! {
        /2([^\n]+\n[^[\n]+)+4.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /2(.*\n){3,}[^\n]*4.*\[FIELD_END\]/ {
                s/$/[ai_2_goal_line_down\]/
                b ai_2_goal_handler
            }
            #prevent cycling
            /#2.{78}#/ {
                s/$/[ai_2_goal_line_down]/;
                b ai_2_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})4(.*\[FIELD_END\])/4\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /4[^\n]*#2#/ {s/$/[ai_2_goal_slide_down_left]/; b 24_goal_down_fin;}
          /#2#[^\n]*4/ {s/$/[ai_2_goal_slide_down_right]/;b 24_goal_down_fin;}
            /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :24_goal_down_fin
            s/4(.{79})(.)(.*\[FIELD_END\])/\2\14\3/ 
            /2(.*\n){2}[^\n]*4.*\[FIELD_END\]/ {
              s/(.)(.{159})4(.*\[FIELD_END\])/4\2\1\3/
              /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
              /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
              s/4(.{159})(.)(.*\[FIELD_END\])/\2\14\3/ 
            }
        }
    }
    
    /\[ai_2_goal_shift_left\]/! {
        /4[^\n#]+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(right|left)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            s/$/[ai_2_goal_shift_left]/
        }
    }

    /\[ai_2_goal_shift_rigth\]/! {
        /2[^\n#]+4.*\[FIELD_END\]/ {
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//
            s/$/[ai_2_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_2_goal_plant_bomb\]/! {
      /[24](\.?|.{79}|.{79}\..{79})[24].*\[FIELD_END\]/ {
          s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
    }
  }
:ai_2_goal_handler
    /\[ai_2_goal_plant_bomb\]/! {
      /=.{79}2.*\[FIELD_END\].*\[ai_2_goal_line_up\]/ {
          s/\[ai_2_goal_line_up\]//
          s/$/[ai_2_goal_plant_bomb]/
      } 
      /=2.*\[FIELD_END\].*\[ai_2_goal_shift_left\]/ {
          s/\[ai_2_goal_shift_left\]//
          s/$/[ai_2_goal_plant_bomb]/
      } 
      /2.{79}=.*\[FIELD_END\].*\[ai_2_goal_line_down\]/ {
          s/\[ai_2_goal_line_down\]//
          s/$/[ai_2_goal_plant_bomb]/
      }
      /2=.*\[FIELD_END\].*\[ai_2_goal_shift_right\]/ {
          s/\[ai_2_goal_shift_right\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
#GOAL_HANDLER    
    /\[ai_2_cmd_query/! {
        /\[ai_2_goal_plant_bomb\]/ {
            s/\[ai_2_goal_plant_bomb\]//
            s/$/\[ai_2_cmd_query_!plant\]/
            #go_away_way
            /\..{79}\.2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /\.2.{78}\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /2\..{79}\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /\..{78}2\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /2.{78}\.\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /2.{79}\.\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /\.\..{79}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /\.\..{78}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /\.\.\.2/    { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /2\.\.\./    { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /2.{79}\..{79}\./ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down\]/    }
            /\..{79}\..{79}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up\]/      }
        }
        /\[ai_2_goal_line_up\]/ {
            /\..{79}2/    { s/$/[ai_2_cmd_query_!up]/;            b a2q; }
            /#\..{78}2\./ { s/$/[ai_2_cmd_query_!right_!up]/;     b a2q; }
            /\.#.{78}\.2/ { s/$/[ai_2_cmd_query_!left_!up]/;      b a2q; }
            /\.2/         { s/$/[ai_2_cmd_query_!left\]/;         b a2q; }
            /2\./         { s/$/[ai_2_cmd_query_!right\]/;        b a2q; }
        }
        /\[ai_2_goal_line_down\]/ {
            /2.{79}\./    { s/$/[ai_2_cmd_query_!down]/;          b a2q; }
            /2\..{78}#\./ { s/$/[ai_2_cmd_query_!right_!down]/;   b a2q; }
            /\.2.{78}\.#/ { s/$/[ai_2_cmd_query_!left_!down]/;    b a2q; }
            /\.2/         { s/$/[ai_2_cmd_query_!left\]/;         b a2q; }
            /2\./         { s/$/[ai_2_cmd_query_!right\]/;        b a2q; }
        }
        /\[ai_2_goal_shift_right\]/ {
            /2\./         { s/$/[ai_2_cmd_query_!right]/;         b a2q; }
            /\.\..{78}2#/ { s/$/[ai_2_cmd_query_!up_!right]/;     b a2q; }
            /2#.{78}\.\./ { s/$/[ai_2_cmd_query_!down_!right]/;   b a2q; }
        }
        /\[ai_2_goal_shift_left\]/ {
            /\.2/           { s/$/[ai_2_cmd_query_!left]/;        b a2q; }
            /\.\.(.{78})#2/ { s/$/[ai_2_cmd_query_!up_!left]/;    b a2q; }
            /#2(.{78})\.\./ { s/$/[ai_2_cmd_query_!down_!left]/;  b a2q; }
        }
        s/(\[ai_2_goal_slide_(up|down)_(left|right)\].*)$/\1[ai_2_cmd_query_!\2_!\3]/
        s/(\[ai_2_goal_slide_(left|right)_(up|down)\].*)$/\1[ai_2_cmd_query_!\2_!\3]/
    }
:a2q
#CMD_QUERY_HANDLER
    /\[ai_2_cmd_query.*/ {
        /\[ai_2_cmd_complete\]/b ai_2_cmd_was_completed
        s/$/\[ai_2_cmd_complete\]/
        /\[ai_2_cmd_query_!plant/ {
            s/(\[ai_2_cmd_query)_!plant/\1/
            b 2_terrorist
        }
        /\[ai_2_cmd_query_!right/ {
          s/(ai_2_cmd_query)_!right/\1/
          b 2_right
        }
        /\[ai_2_cmd_query_!left/ {
          s/(ai_2_cmd_query)_!left/\1/
          b 2_left
        }
        /\[ai_2_cmd_query_!up/ {
          s/(ai_2_cmd_query)_!up/\1/
          b 2_up
        }
        /\[ai_2_cmd_query_!down/ {
          s/(ai_2_cmd_query)_!down/\1/
          b 2_down
        }
        s/\[ai_2_cmd_query\]//
    }
:ai_2_cmd_was_completed
b ai_2_finish

:third_terrorist_ai
/\[ai_3_cmd_complete\]/b ai_3_cmd_was_completed
#set goals for AI_FSM
  /\[ai_3_cmd_query/! {
    #taking cover
    /[@a0o*](.{79}(\..{79}(\..{79})?)?)3.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /\..{79}\.3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /\.3.{78}\./ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3\..{79}\./ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /\..{78}3\./ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /\.\.3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3\.\./      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /3.{79}\./   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /\.3/        { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3\./        { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\[ai_3_taking_cover/! {
        s/(([@a0o])(.{79}(\..{79}(\..{79})?)?)3.*)$/\1\[ai_3_taking_cover_\2\]/
      }
      b ai_3_goal_handler
    }

    /3(.{79}(\..{79}(\..{79})?)?)[@a0o*].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /\..{79}\.3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /\.3.{78}\./ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3\..{79}\./ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /\..{78}3\./ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /\.\.3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3\.\./      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\..{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /\[ai_3_taking_cover/! {
        s/(3(.{79}(\..{79}(\..{79})?)?)([@a0o]).*)$/\1\[ai_3_taking_cover_\5\]/
      }
      b ai_3_goal_handler
    }
    
    /[@a0o*]\.?\.?\.?3.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /\..{79}\.3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /\.3.{78}\./ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3\..{79}\./ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /\..{78}3\./ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /3\.\./      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\..{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /3.{79}\./   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /\[ai_3_taking_cover/! { 
        s/(([@a0o])\.?\.?\.?3.*)$/\1\[ai_3_taking_cover_\2\]/
      }
      b ai_3_goal_handler
    }

    /3\.?\.?\.?[@a0o*].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_line_(up|down)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /\..{79}\.3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /\.3.{78}\./ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3\..{79}\./ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /\..{78}3\./ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}\.\./ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /\.\.3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /\..{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /3.{79}\./   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /\[ai_3_taking_cover/! {
        s/(3\.?\.?\.?([@a0o]).*)$/\1[ai_3_taking_cover_\2]/
      }
      b ai_3_goal_handler
    }
    #choose target
    s/\[ai_3_target_[1-4]\]//
    /^.*1.*\[FIELD_END\]/! {
        /^.*2.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_4\]/; b ai_3_seeking
        }
        /^.*4.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_2\]/; b ai_3_seeking
        }
        /\[dis_sec_th:(8*):dissth\].*\[dis_th_fi:\18*:distfi\]/ {
            s/$/\[ai_3_target_2\]/; b ai_3_seeking
        }
        s/$/\[ai_3_target_4\]/; b ai_3_seeking
    }
    /^.*2.*\[FIELD_END\]/! {
        /^.*4.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_1\]/; b ai_3_seeking
        }
        /^.*1.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_4\]/; b ai_3_seeking
        }
        /\[dis_th_fu:(8*):dissfu\].*\[dis_th_fi:\18*:distfi\]/ {
            s/$/\[ai_3_target_1\]/; b ai_3_seeking
        }
        s/$/\[ai_3_target_4\]/; b ai_3_seeking
    }
    /^.*4.*\[FIELD_END\]/! {
        /^.*2.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_1\]/; b ai_3_seeking
        }
        /^.*1.*\[FIELD_END\]/! {
            s/$/\[ai_3_target_4\]/; b ai_3_seeking
        }
        /\[dis_sec_th:(8*):dissth\].*\[dis_th_fi:\18*:distfi\]/ {
            s/$/\[ai_3_target_2\]/; b ai_3_seeking
        }
        s/$/\[ai_3_target_1\]/; b ai_3_seeking
    }
    /\[dis_sec_th:(8*):dissth\].*\[dis_th_fu:\18*:distfu\]/ {
      /\[dis_sec_th:(8*):dissth\].*\[dis_th_fi:\18*:distfi\]/ {
          s/$/\[ai_3_target_2\]/; b ai_3_seeking
      }
      s/$/\[ai_3_target_1\]/; b ai_3_seeking
    }
    /\[dis_th_fu:(8*):distfu\].*\[dis_th_fi:\18*:distfi\]/ {
      s/$/\[ai_3_target_4\]/; b ai_3_seeking
    }
    s/$/\[ai_3_target_1\]/; b ai_3_seeking
    #seeking target
:ai_3_seeking
    /\[ai_3_taking_cover_[@a0o]\]/ b ai_3_goal_handler
    #SEEK TARGET FIRST
    /\[ai_3_target_1\]/ {
    /\[ai_3_goal_line_up\]/! {
        /1([^\n]+\n[^\n]+)+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /1(.*\n){3,}[^\n]*3.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_up]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#.{78}#3/ {                
                s/$/[ai_3_goal_line_up]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /1[^\n]*#3#/ { s/$/[ai_3_goal_slide_up_left]/; b 31_goal_up_fin; }
            /#3#[^\n]*1/ { s/$/[ai_3_goal_slide_up_right]/;b 31_goal_up_fin; }
            /1[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :31_goal_up_fin
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            /1(.*\n){2}[^\n]*3.*\[FIELD_END\]/ {
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
              /1[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
            }
        }        
    }
    /\[ai_3_goal_line_down\]/! {
        /3([^\n]+\n[^[\n]+)+1.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /3(.*\n){3,}[^\n]*1.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_down\]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#3.{78}#/ {
                s/$/[ai_3_goal_line_down]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /1[^\n]*#3#/ {s/$/[ai_3_goal_slide_down_left]/; b 31_goal_down_fin;}
          /#3#[^\n]*1/ {s/$/[ai_3_goal_slide_down_right]/;b 31_goal_down_fin;}
            /1[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :31_goal_down_fin
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            /3(.*\n){2}[^\n]*1.*\[FIELD_END\]/ {
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
              /1[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
            }
        }
    }
    
    /\[ai_3_goal_shift_left\]/! {
        /1[^\n#]+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(right|left)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            s/$/[ai_3_goal_shift_left]/
        }
    }

    /\[ai_3_goal_shift_rigth\]/! {
        /3[^\n#]+1.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//
            s/$/[ai_3_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_3_goal_plant_bomb\]/! {
      /[13](\.?|.{79}|.{79}\..{79})[31].*\[FIELD_END\]/ {
          s/\[ai_3_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_3_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET SECOND
    /\[ai_3_target_2\]/ {
    /\[ai_3_goal_line_up\]/! {
        /2([^\n]+\n[^\n]+)+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /2(.*\n){3,}[^\n]*3.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_up]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#.{78}#3/ {                
                s/$/[ai_3_goal_line_up]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/2(.{79})(.)(.*\[FIELD_END\])/\2\12\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /2[^\n]*#3#/ { s/$/[ai_3_goal_slide_up_left]/; b 32_goal_up_fin; }
            /#3#[^\n]*2/ { s/$/[ai_3_goal_slide_up_right]/;b 32_goal_up_fin; }
            /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :32_goal_up_fin
            s/(.)(.{79})2(.*\[FIELD_END\])/2\2\1\3/
            /2(.*\n){2}[^\n]*3.*\[FIELD_END\]/ {
              s/2(.{159})(.)(.*\[FIELD_END\])/\2\12\3/ 
              /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/(.)(.{159})2(.*\[FIELD_END\])/2\2\1\3/
            }
        }        
    }
    /\[ai_3_goal_line_down\]/! {
        /3([^\n]+\n[^[\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /3(.*\n){3,}[^\n]*2.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_down\]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#3.{78}#/ {
                s/$/[ai_3_goal_line_down]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})2(.*\[FIELD_END\])/2\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /2[^\n]*#3#/ {s/$/[ai_3_goal_slide_down_left]/; b 32_goal_down_fin;}
          /#3#[^\n]*2/ {s/$/[ai_3_goal_slide_down_right]/;b 32_goal_down_fin;}
            /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :32_goal_down_fin
            s/2(.{79})(.)(.*\[FIELD_END\])/\2\12\3/ 
            /3(.*\n){2}[^\n]*2.*\[FIELD_END\]/ {
              s/(.)(.{159})2(.*\[FIELD_END\])/2\2\1\3/
              /2[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/2(.{159})(.)(.*\[FIELD_END\])/\2\12\3/ 
            }
        }
    }
    
    /\[ai_3_goal_shift_left\]/! {
        /2[^\n#]+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(right|left)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            s/$/[ai_3_goal_shift_left]/
        }
    }

    /\[ai_3_goal_shift_rigth\]/! {
        /3[^\n#]+2.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//
            s/$/[ai_3_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_3_goal_plant_bomb\]/! {
      /[32](\.?|.{79}|.{79}\..{79})[32].*\[FIELD_END\]/ {
          s/\[ai_3_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_3_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET FOURTH
    /\[ai_3_target_4\]/ {
    /\[ai_3_goal_line_up\]/! {
        /4([^\n]+\n[^\n]+)+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /4(.*\n){3,}[^\n]*3.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_up]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#.{78}#3/ {                
                s/$/[ai_3_goal_line_up]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/4(.{79})(.)(.*\[FIELD_END\])/\2\14\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /4[^\n]*#3#/ { s/$/[ai_3_goal_slide_up_left]/; b 34_goal_up_fin; }
            /#3#[^\n]*4/ { s/$/[ai_3_goal_slide_up_right]/;b 34_goal_up_fin; }
            /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :34_goal_up_fin
            s/(.)(.{79})4(.*\[FIELD_END\])/4\2\1\3/
            /4(.*\n){2}[^\n]*3.*\[FIELD_END\]/ {
              s/4(.{159})(.)(.*\[FIELD_END\])/\2\14\3/ 
              /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/(.)(.{159})4(.*\[FIELD_END\])/4\2\1\3/
            }
        }        
    }
    /\[ai_3_goal_line_down\]/! {
        /3([^\n]+\n[^[\n]+)+4.*\[FIELD_END\]/ {
            s/\[ai_3_goal_line_(down|up)\]//g
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /3(.*\n){3,}[^\n]*4.*\[FIELD_END\]/ {
                s/$/[ai_3_goal_line_down\]/
                b ai_3_goal_handler
            }
            #prevent cycling
            /#3.{78}#/ {
                s/$/[ai_3_goal_line_down]/;
                b ai_3_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})4(.*\[FIELD_END\])/4\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /4[^\n]*#3#/ {s/$/[ai_3_goal_slide_down_left]/; b 34_goal_down_fin;}
          /#3#[^\n]*4/ {s/$/[ai_3_goal_slide_down_right]/;b 34_goal_down_fin;}
            /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
            /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
            :34_goal_down_fin
            s/4(.{79})(.)(.*\[FIELD_END\])/\2\14\3/ 
            /3(.*\n){2}[^\n]*4.*\[FIELD_END\]/ {
              s/(.)(.{159})4(.*\[FIELD_END\])/4\2\1\3/
              /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_left]/  }
              /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_3_goal_shift_right]/ }
              s/4(.{159})(.)(.*\[FIELD_END\])/\2\14\3/ 
            }
        }
    }
    
    /\[ai_3_goal_shift_left\]/! {
        /4[^\n#]+3.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(right|left)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//g
            s/$/[ai_3_goal_shift_left]/
        }
    }

    /\[ai_3_goal_shift_rigth\]/! {
        /3[^\n#]+4.*\[FIELD_END\]/ {
            s/\[ai_3_goal_shift_(left|right)\]//g
            s/\[ai_3_goal_line_(up|down)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_3_goal_plant_bomb\]//
            s/$/[ai_3_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_3_goal_plant_bomb\]/! {
      /[43](\.?|.{79}|.{79}\..{79})[34].*\[FIELD_END\]/ {
          s/\[ai_3_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_3_goal_plant_bomb]/
      }
    }
    }
  }
:ai_3_goal_handler
   /\[ai_3_goal_plant_bomb\]/! {
     /=.{79}3.*\[FIELD_END\].*\[ai_3_goal_line_up\]/ {
         s/\[ai_3_goal_line_up\]//
         s/$/[ai_3_goal_plant_bomb]/
     } 
     /=3.*\[FIELD_END\].*\[ai_3_goal_shift_left\]/ {
         s/\[ai_3_goal_shift_left\]//
         s/$/[ai_3_goal_plant_bomb]/
     } 
     /3.{79}=.*\[FIELD_END\].*\[ai_3_goal_line_down\]/ {
         s/\[ai_3_goal_line_down\]//
         s/$/[ai_3_goal_plant_bomb]/
     }
     /3=.*\[FIELD_END\].*\[ai_3_goal_shift_right\]/ {
         s/\[ai_3_goal_shift_right\]//g
         s/$/[ai_3_goal_plant_bomb]/
     }
   }
#GOAL_HANDLER    
    /\[ai_3_cmd_query/! {
        /\[ai_3_goal_plant_bomb\]/ {
            s/\[ai_3_goal_plant_bomb\]//
            s/$/\[ai_3_cmd_query_!plant\]/
            #go_away_way
            /\..{79}\.3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /\.3.{78}\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /3\..{79}\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /\..{78}3\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /3.{78}\.\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /3.{79}\.\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /\.\..{79}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /\.\..{78}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /\.\.\.3/    { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /3\.\.\./    { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /3.{79}\..{79}\./ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down\]/    }
            /\..{79}\..{79}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up\]/      }
        }
        /\[ai_3_goal_line_up\]/ {            
            /\..{79}3/    { s/$/[ai_3_cmd_query_!up]/;            b a3q; }
            /#\..{78}3\./ { s/$/[ai_3_cmd_query_!right_!up]/;     b a3q; }
            /\.#.{78}\.3/ { s/$/[ai_3_cmd_query_!left_!up]/;      b a3q; }
            /\.3/         { s/$/[ai_3_cmd_query_!left\]/;         b a3q; }
            /3\./         { s/$/[ai_3_cmd_query_!right\]/;        b a3q; }
        }
        /\[ai_3_goal_line_down\]/ {
            /3.{79}\./    { s/$/[ai_3_cmd_query_!down]/;          b a3q; }
            /3\..{78}#\./ { s/$/[ai_3_cmd_query_!right_!down]/;   b a3q; }
            /\.3.{78}\.#/ { s/$/[ai_3_cmd_query_!left_!down]/;    b a3q; }
            /\.3/         { s/$/[ai_3_cmd_query_!left\]/;         b a3q; }
            /3\./         { s/$/[ai_3_cmd_query_!right\]/;        b a3q; }
        }
        /\[ai_3_goal_shift_right\]/ {
            /3\./         { s/$/[ai_3_cmd_query_!right]/;         b a3q; }
            /\.\..{78}3#/ { s/$/[ai_3_cmd_query_!up_!right]/;     b a3q; }
            /3#.{78}\.\./ { s/$/[ai_3_cmd_query_!down_!right]/;   b a3q; }
        }
        /\[ai_3_goal_shift_left\]/ {
            /\.3/           { s/$/[ai_3_cmd_query_!left]/;        b a3q; }
            /\.\..{78}#3/ { s/$/[ai_3_cmd_query_!up_!left]/;      b a3q; }
            /#3.{78}\.\./ { s/$/[ai_3_cmd_query_!down_!left]/;    b a3q; }
        }
        s/(\[ai_3_goal_slide_(up|down)_(left|right)\].*)$/\1[ai_3_cmd_query_!\2_!\3]/
        s/(\[ai_3_goal_slide_(left|right)_(up|down)\].*)$/\1[ai_3_cmd_query_!\2_!\3]/
    }
:a3q
#CMD_QUERY_HANDLER
    /\[ai_3_cmd_query.*/ {
        /\[ai_3_cmd_complete\]/b ai_3_cmd_was_completed
        s/$/\[ai_3_cmd_complete\]/
        /\[ai_3_cmd_query_!plant/ {
            s/(\[ai_3_cmd_query)_!plant/\1/
            b 3_terrorist
        }
        /\[ai_3_cmd_query_!right/ {
          s/(ai_3_cmd_query)_!right/\1/
          b 3_right
        }
        /\[ai_3_cmd_query_!left/ {
          s/(ai_3_cmd_query)_!left/\1/
          b 3_left
        }
        /\[ai_3_cmd_query_!up/ {
          s/(ai_3_cmd_query)_!up/\1/
          b 3_up
        }
        /\[ai_3_cmd_query_!down/ {
          s/(ai_3_cmd_query)_!down/\1/
          b 3_down
        }
        s/\[ai_3_cmd_query\]//
    }
:ai_3_cmd_was_completed
b ai_3_finish

:fourth_terrorist_ai
/\[ai_4_cmd_complete\]/b ai_4_cmd_was_completed
#set goals for AI_FSM
  /\[ai_4_cmd_query/! {
    #taking cover
    /[@a0o*](.{79}(\..{79}(\..{79})?)?)4.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /\..{79}\.4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /\.4.{78}\./ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4\..{79}\./ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /\..{78}4\./ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /\.\.4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4\.\./      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /4.{79}\./   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /\.4/        { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4\./        { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\[ai_4_taking_cover/! {
        s/(([@a0o])(.{79}(\..{79}(\..{79})?)?)4.*)$/\1\[ai_4_taking_cover_\2\]/
      }
      b ai_4_goal_handler
    }

    /4(.{79}(\..{79}(\..{79})?)?)[@a0o*].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /\..{79}\.4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /\.4.{78}\./ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4\..{79}\./ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /\..{78}4\./ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /\.\.4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4\.\./      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\..{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /\[ai_4_taking_cover/! {
        s/(4(.{79}(\..{79}(\..{79})?)?)([@a0o]).*)$/\1\[ai_4_taking_cover_\5\]/
      }
      b ai_4_goal_handler
    }
    
    /[@a0o*]\.?\.?\.?4.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /\..{79}\.4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /\.4.{78}\./ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4\..{79}\./ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /\..{78}4\./ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /4\.\./      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\..{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /4.{79}\./   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /\[ai_4_taking_cover/! { 
        s/(([@a0o])\.?\.?\.?4.*)$/\1\[ai_4_taking_cover_\2\]/
      }
      b ai_4_goal_handler
    }

    /4\.?\.?\.?[@a0o*].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_line_(up|down)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /\..{79}\.4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /\.4.{78}\./ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4\..{79}\./ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /\..{78}4\./ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /\.\..{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /\.\..{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}\.\./ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /\.\.4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /\..{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /4.{79}\./   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /\[ai_4_taking_cover/! {
        s/(4\.?\.?\.?([@a0o]).*)$/\1[ai_4_taking_cover_\2]/
      }
      b ai_4_goal_handler
    }
    #choose target
    s/\[ai_4_target_[1-4]\]//
    /^.*1.*\[FIELD_END\]/! {
        /^.*2.*\[FIELD_END\]/! {
            s/$/\[ai_4_target_3\]/; b ai_4_seeking
        }
        /^.*3.*\[FIELD_END\]/! {
            s/$/\[ai_4_target_2\]/; b ai_4_seeking
        }
        /\[dis_sec_fu:(8*):dissfu\].*\[dis_th_fu:\18*:distfu\]/ {
            s/$/\[ai_4_target_2\]/; b ai_4_seeking
        }
        s/$/\[ai_4_target_3\]/; b ai_4_seeking
    }
    /^.*3.*\[FIELD_END\]/! {
        /^.*2.*\[FIELD_END\]/! {
            s/$/\[ai_4_target_1\]/; b ai_4_seeking
        }
        /\[dis_sec_fu:(8*):dissfu\].*\[dis_fu_fi:\18*:disffi\]/ {
            s/$/\[ai_4_target_2\]/; b ai_4_seeking
        }
        s/$/\[ai_4_target_1\]/; b ai_4_seeking
    }
    /^.*2.*\[FIELD_END\]/! {
        /^.*3.*\[FIELD_END\]/! {
            s/$/\[ai_4_target_1\]/; b ai_4_seeking
        }
        /\[dis_th_fu:(8*):distfu\].*\[dis_fu_fi:\18*:disffi\]/ {
            s/$/\[ai_4_target_3\]/; b ai_4_seeking
        }
        s/$/\[ai_4_target_1\]/; b ai_4_seeking
    }
    /\[dis_sec_fu:(8*):dissfu\].*\[dis_th_fu:\18*:distfu\]/ {
      /\[dis_sec_fu:(8*):dissfu\].*\[dis_fu_fi:\18*:disffi\]/ {
          s/$/\[ai_4_target_2\]/; b ai_4_seeking
      }
      s/$/\[ai_4_target_1\]/; b ai_4_seeking
    }
    /\[dis_th_fu:(8*):distfu\].*\[dis_fu_fi:\18*:disffi\]/ {
      s/$/\[ai_4_target_3\]/; b ai_4_seeking
    }
    s/$/\[ai_4_target_1\]/
    #seeking target
:ai_4_seeking
    /\[ai_4_taking_cover_[@a0o]\]/ b ai_4_goal_handler
    #SEEK TARGET FIRST
    /\[ai_4_target_1\]/ {
    /\[ai_4_goal_line_up\]/! {
        /1([^\n]+\n[^\n]+)+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /1(.*\n){3,}[^\n]*4.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_up]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#.{78}#4/ {
                s/$/[ai_4_goal_line_up]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /1[^\n]*#4#/ { s/$/[ai_4_goal_slide_up_left]/; b 41_goal_up_fin; }
            /#4#[^\n]*1/ { s/$/[ai_4_goal_slide_up_right]/;b 41_goal_up_fin; }
            /1[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /4[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :41_goal_up_fin
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            /1(.*\n){2}[^\n]*4.*\[FIELD_END\]/ {
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
              /1[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
            }
        }        
    }
    /\[ai_4_goal_line_down\]/! {
        /4([^\n]+\n[^[\n]+)+1.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /4(.*\n){3,}[^\n]*1.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_down\]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#4.{78}#/ {
                s/$/[ai_4_goal_line_down]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})1(.*\[FIELD_END\])/1\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /1[^\n]*#4#/ {s/$/[ai_4_goal_slide_down_left]/; b 41_goal_down_fin;}
          /#4#[^\n]*1/ {s/$/[ai_4_goal_slide_down_right]/;b 41_goal_down_fin;}
            /1[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /4[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :41_goal_down_fin
            s/1(.{79})(.)(.*\[FIELD_END\])/\2\11\3/ 
            /4(.*\n){2}[^\n]*1.*\[FIELD_END\]/ {
              s/(.)(.{159})1(.*\[FIELD_END\])/1\2\1\3/
              /1[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/1(.{159})(.)(.*\[FIELD_END\])/\2\11\3/ 
            }
        }
    }
    
    /\[ai_4_goal_shift_left\]/! {
        /1[^\n#]+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(right|left)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            s/$/[ai_4_goal_shift_left]/
        }
    }

    /\[ai_4_goal_shift_rigth\]/! {
        /4[^\n#]+1.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//
            s/$/[ai_4_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_4_goal_plant_bomb\]/! {
      /[14](\.?|.{79}|.{79}\..{79})[41].*\[FIELD_END\]/ {
          s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET THIRD
    /\[ai_4_target_3\]/ {
    /\[ai_4_goal_line_up\]/! {
        /3([^\n]+\n[^\n]+)+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /3(.*\n){3,}[^\n]*4.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_up]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#.{78}#4/ {                
                s/$/[ai_4_goal_line_up]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/3(.{79})(.)(.*\[FIELD_END\])/\2\13\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /3[^\n]*#4#/ { s/$/[ai_4_goal_slide_up_left]/; b 43_goal_up_fin; }
            /#4#[^\n]*3/ { s/$/[ai_4_goal_slide_up_right]/;b 43_goal_up_fin; }
            /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :43_goal_up_fin
            s/(.)(.{79})3(.*\[FIELD_END\])/3\2\1\3/
            /3(.*\n){2}[^\n]*4.*\[FIELD_END\]/ {
              s/3(.{159})(.)(.*\[FIELD_END\])/\2\13\3/ 
              /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/(.)(.{159})3(.*\[FIELD_END\])/3\2\1\3/
            }
        }        
    }
    /\[ai_4_goal_line_down\]/! {
        /4([^\n]+\n[^[\n]+)+3.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /4(.*\n){3,}[^\n]*3.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_down\]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#4.{78}#/ {
                s/$/[ai_4_goal_line_down]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})3(.*\[FIELD_END\])/3\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
            /3[^\n]*#4#/ { 
                s/$/[ai_4_goal_slide_down_left]/
                b 43_goal_down_fin
            }
            /#4#[^\n]*3/ {
                s/$/[ai_4_goal_slide_down_right]/
                b 43_goal_down_fin
            }
            /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :43_goal_down_fin
            s/3(.{79})(.)(.*\[FIELD_END\])/\2\13\3/ 
            /4(.*\n){2}[^\n]*3.*\[FIELD_END\]/ {
              s/(.)(.{159})3(.*\[FIELD_END\])/3\2\1\3/
              /3[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*3.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/3(.{159})(.)(.*\[FIELD_END\])/\2\13\3/ 
            }
        }
    }
    
    /\[ai_4_goal_shift_left\]/! {
        /3[^\n#]+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(right|left)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            s/$/[ai_4_goal_shift_left]/
        }
    }

    /\[ai_4_goal_shift_rigth\]/! {
        /4[^\n#]+3.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//
            s/$/[ai_4_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_4_goal_plant_bomb\]/! {
      /[32](\.?|.{79}|.{79}\..{79})[23].*\[FIELD_END\]/ {
          s/\[ai_4_goal_(line|shift)_(up|down|right|left)\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
    }
    #SEEK TARGET SECOND
    /\[ai_4_target_2\]/ {
    /\[ai_4_goal_line_up\]/! {
        /2([^\n]+\n[^\n]+)+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line upward from second bomber
            /2(.*\n){3,}[^\n]*4.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_up]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#.{78}#4/ {
                s/$/[ai_4_goal_line_up]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/2(.{79})(.)(.*\[FIELD_END\])/\2\12\3/ 
            #is target's "shadow" to the left or to the right from second bomber
            /2[^\n]*#4#/ { s/$/[ai_4_goal_slide_up_left]/; b 42_goal_up_fin; }
            /#4#[^\n]*2/ { s/$/[ai_4_goal_slide_up_right]/;b 42_goal_up_fin; }
            /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :42_goal_up_fin
            s/(.)(.{79})2(.*\[FIELD_END\])/2\2\1\3/
            /2(.*\n){2}[^\n]*4.*\[FIELD_END\]/ {
              s/2(.{159})(.)(.*\[FIELD_END\])/\2\12\3/ 
              /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/(.)(.{159})2(.*\[FIELD_END\])/2\2\1\3/
            }
        }        
    }
    /\[ai_4_goal_line_down\]/! {
        /4([^\n]+\n[^[\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_4_goal_line_(down|up)\]//g
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            #target is more than one line downward from second bomber
            /4(.*\n){3,}[^\n]*2.*\[FIELD_END\]/ {
                s/$/[ai_4_goal_line_down\]/
                b ai_4_goal_handler
            }
            #prevent cycling
            /#4.{78}#/ {
                s/$/[ai_4_goal_line_down]/;
                b ai_4_goal_handler;
            }
            #place target's "shadow" in one row with second bomber
            s/(.)(.{79})2(.*\[FIELD_END\])/2\2\1\3/
            #is target's "shadow" to the left or to the right from second bomber
            
          /2[^\n]*#4#/ {s/$/[ai_4_goal_slide_down_left]/; b 42_goal_down_fin;}
          /#4#[^\n]*2/ {s/$/[ai_4_goal_slide_down_right]/;b 42_goal_down_fin;}
            /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
            /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
            :42_goal_down_fin
            s/2(.{79})(.)(.*\[FIELD_END\])/\2\12\3/ 
            /4(.*\n){2}[^\n]*2.*\[FIELD_END\]/ {
              s/(.)(.{159})2(.*\[FIELD_END\])/2\2\1\3/
              /2[^\n]*4.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_left]/  }
              /4[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_4_goal_shift_right]/ }
              s/2(.{159})(.)(.*\[FIELD_END\])/\2\12\3/ 
            }
        }
    }
    
    /\[ai_4_goal_shift_left\]/! {
        /2[^\n#]+4.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(right|left)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//g
            s/$/[ai_4_goal_shift_left]/
        }
    }

    /\[ai_4_goal_shift_rigth\]/! {
        /4[^\n#]+2.*\[FIELD_END\]/ {
            s/\[ai_4_goal_shift_(left|right)\]//g
            s/\[ai_4_goal_line_(up|down)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/\[ai_4_goal_plant_bomb\]//
            s/$/[ai_4_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_4_goal_plant_bomb\]/! {
      /[24](\.?|.{79}|.{79}\..{79})[24].*\[FIELD_END\]/ {
          s/\[ai_4_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
    }
  }
:ai_4_goal_handler
    /\[ai_4_goal_plant_bomb\]/! {
      /=.{79}4.*\[FIELD_END\].*\[ai_4_goal_line_up\]/ {
          s/\[ai_4_goal_line_up\]//
          s/$/[ai_4_goal_plant_bomb]/
      } 
      /=4.*\[FIELD_END\].*\[ai_4_goal_shift_left\]/ {
          s/\[ai_4_goal_shift_left\]//
          s/$/[ai_4_goal_plant_bomb]/
      } 
      /4.{79}=.*\[FIELD_END\].*\[ai_4_goal_line_down\]/ {
          s/\[ai_4_goal_line_down\]//
          s/$/[ai_4_goal_plant_bomb]/
      }
      /4=.*\[FIELD_END\].*\[ai_4_goal_shift_right\]/ {
          s/\[ai_4_goal_shift_right\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
#GOAL_HANDLER    
    /\[ai_4_cmd_query/! {
        /\[ai_4_goal_plant_bomb\]/ {
            s/\[ai_4_goal_plant_bomb\]//
            s/$/\[ai_4_cmd_query_!plant\]/
            #go_away_way
            /\..{79}\.4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /\.4.{78}\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /4\..{79}\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /\..{78}4\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /4.{78}\.\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /4.{79}\.\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /\.\..{79}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /\.\..{78}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /\.\.\.4/    { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /4\.\.\./    { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /4.{79}\..{79}\./ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down\]/    }
            /\..{79}\..{79}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up\]/      }
        }
        /\[ai_4_goal_line_up\]/ {            
            /\..{79}4/    { s/$/[ai_4_cmd_query_!up]/;            b a4q; }
            /#\..{78}4\./ { s/$/[ai_4_cmd_query_!right_!up]/;     b a4q; }
            /\.#.{78}\.4/ { s/$/[ai_4_cmd_query_!left_!up]/;      b a4q; }
            /\.4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /4\./         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
        }
        /\[ai_4_goal_line_down\]/ {
            /4.{79}\./    { s/$/[ai_4_cmd_query_!down]/;          b a4q; }
            /4\..{78}#\./ { s/$/[ai_4_cmd_query_!right_!down]/;   b a4q; }
            /\.4.{78}\.#/ { s/$/[ai_4_cmd_query_!left_!down]/;    b a4q; }
            /\.4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /4\./         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
        }
        /\[ai_4_goal_shift_right\]/ {
            /4\./         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
            /\.\..{78}4#/ { s/$/[ai_4_cmd_query_!up_!right]/;     b a4q; }
            /4#.{78}\.\./ { s/$/[ai_4_cmd_query_!down_!right]/;   b a4q; }
        }
        /\[ai_4_goal_shift_left\]/ {
            /\.4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /\.\..{78}#4/ { s/$/[ai_4_cmd_query_!up_!left]/;      b a4q; }
            /#4.{78}\.\./ { s/$/[ai_4_cmd_query_!down_!left]/;    b a4q; }
        }
        s/(\[ai_4_goal_slide_(up|down)_(left|right)\].*)$/\1[ai_4_cmd_query_!\2_!\3]/
        s/(\[ai_4_goal_slide_(left|right)_(up|down)\].*)$/\1[ai_4_cmd_query_!\2_!\3]/
    }
:a4q
#CMD_QUERY_HANDLER
    /\[ai_4_cmd_query.*/ {
        /\[ai_4_cmd_complete\]/b ai_4_cmd_was_completed
        s/$/\[ai_4_cmd_complete\]/
        /\[ai_4_cmd_query_!plant/ {
            s/(\[ai_4_cmd_query)_!plant/\1/
            b 4_terrorist
        }
        /\[ai_4_cmd_query_!right/ {
          s/(ai_4_cmd_query)_!right/\1/
          b 4_right
        }
        /\[ai_4_cmd_query_!left/ {
          s/(ai_4_cmd_query)_!left/\1/
          b 4_left
        }
        /\[ai_4_cmd_query_!up/ {
          s/(ai_4_cmd_query)_!up/\1/
          b 4_up
        }
        /\[ai_4_cmd_query_!down/ {
          s/(ai_4_cmd_query)_!down/\1/
          b 4_down
        }
        s/\[ai_4_cmd_query\]//
    }
:ai_4_cmd_was_completed
b ai_4_finish

:ai_cmds_completed
s/\[ai_[234]_goal\]//g
s/\[ai_[234]_cmd_complete\]//g
s/\[ai_[234]_cmd_query\]//g
s/\[ai_[234]_target_[1-4]\]//g

/bomb/! {
    s/\*/./g
}
s/\[(first|second|third|fourth)_bomb_tacted\]//g

/\[ai_2_taking_cover/ {
    s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0o]).*\[FIELD_END\].*\[ai_2_taking_cover_\1/b print_after_ai
}
/\[ai_3_taking_cover/ {
    s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0o]).*\[FIELD_END\].*\[ai_3_taking_cover_\1/b print_after_ai
}
/\[ai_4_taking_cover/ {
    s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0o]).*\[FIELD_END\].*\[ai_4_taking_cover_\1/b print_after_ai
}
s/\[ai_2_taking_cover_[@a0o]\]//g
s/\[ai_3_taking_cover_[@a0o]\]//g
s/\[ai_4_taking_cover_[@a0o]\]//g
b print_after_ai

# DISTANCES
# CHECKING
# 2-1 2-3 2-4 3-4 3-1 4-1
:distance_check
:distance_check_2_1
  s/\[dis_sec_fir:8*:dissfi\]//
  s/\[DTF:.*:FTD\]//
  #check vertical distance
  h
  s/$/[dis_sec_fir::dissfi]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#34=.]*([12])?[@a0o*#34=.]*([12])?[@a0o*#34=.]*#\n/\1\2\n/g
  s/(\[dis_sec_fir:)(:dissfi\])\[DTF:.*[12](\n*)[21].*:FTD\]/\1\3\2/
  s/^.*(\[dis_sec_fir:\n*:dissfi\]).*$/\1/  
  y/\n/8/
  H; x;
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[12][^\n]*[12].*\[FIELD_END\]/b distance_check_2_1_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[12][^\n]{,79}#\n#[^\n]{,79}[12][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_2_1_put_on_line
s/#{79}.*\n(#[^\n]{,79}[12][^\n]{,79}#\n).*\n(#[^\n]{,79}[12][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_2_1_put_on_line
  s/^.*#{79}[^12]*\n(#[^\n]{,79}[12][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([12])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_2_1_hcompare
  s/[12]([^\n]*)[12].*\[FIELD_END\].*(\[dis_sec_fir:8*)(:dissfi\])/\2\1\3/
  s/^.*(\[dis_sec_fir:.*:dissfi\]).*$/\1/  
  y/@ao0=*#.34/8888888888/
  s/(\[dis_sec_fir)/\1SPIKE/
  H; x; 
  s/\n?\[dis_sec_fir:8*:dissfi\]//
  s/\n?(\[dis_sec_fir)SPIKE/\1/

:distance_check_2_3
  s/\[dis_sec_th:8*:dissth\]//
  s/\[DTF:.*:FTD\]//
  #check vertical distance
  h
  s/$/[dis_sec_th::dissth]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#14=.]*([23])?[@a0o*#14=.]*([23])?[@a0o*#14=.]*#\n/\1\2\n/g
  s/(\[dis_sec_th:)(:dissth\])\[DTF:.*[23](\n*)[23].*:FTD\]/\1\3\2/
  s/^.*(\[dis_sec_th:\n*:dissth\]).*$/\1/  
  y/\n/8/
  H; x;
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[23][^\n]*[23].*\[FIELD_END\]/b distance_check_2_3_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[23][^\n]{,79}#\n#[^\n]{,79}[23][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_2_3_put_on_line
s/#{79}.*\n(#[^\n]{,79}[23][^\n]{,79}#\n).*\n(#[^\n]{,79}[23][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_2_3_put_on_line
  s/^.*#{79}[^23]*\n(#[^\n]{,79}[23][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([23])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_2_3_hcompare
  s/[23]([^\n]*)[23].*\[FIELD_END\].*(\[dis_sec_th:8*)(:dissth\])/\2\1\3/
  s/^.*(\[dis_sec_th:.*:dissth\]).*$/\1/  
  y/@ao0=*#.14/8888888888/
  s/(\[dis_sec_th)/\1SPIKE/
  H; x; 
  s/\n?\[dis_sec_th:8*:dissth\]//
  s/\n?(\[dis_sec_th)SPIKE/\1/

:distance_check_2_4
  s/\[dis_sec_fu:8*:dissfu\]//
  s/\[DTF:.*:FTD\]//
  h
  s/$/[dis_sec_fu::dissfu]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#13=.]*([24])?[@a0o*#13=.]*([24])?[@a0o*#13=.]*#\n/\1\2\n/g
  s/(\[dis_sec_fu:)(:dissfu\])\[DTF:.*[24](\n*)[24].*:FTD\]/\1\3\2/
  s/^.*(\[dis_sec_fu:\n*:dissfu\]).*$/\1/  
  y/\n/8/
  H; x; 
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[24][^\n]*[24].*\[FIELD_END\]/b distance_check_2_4_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[24][^\n]{,79}#\n#[^\n]{,79}[24][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_2_4_put_on_line
s/#{79}.*\n(#[^\n]{,79}[24][^\n]{,79}#\n).*\n(#[^\n]{,79}[24][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_2_4_put_on_line
  s/^.*#{79}[^24]*\n(#[^\n]{,79}[24][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([24])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_2_4_hcompare
  s/[24]([^\n]*)[24].*\[FIELD_END\].*(\[dis_sec_fu:8*)(:dissfu\])/\2\1\3/
  s/^.*(\[dis_sec_fu:.*:dissfu\]).*$/\1/  
  y/@ao0=*#.13/8888888888/
  s/(\[dis_sec_fu)/\1SPIKE/
  H; x; 
  s/\n?\[dis_sec_fu:8*:dissfu\]//
  s/\n?(\[dis_sec_fu)SPIKE/\1/
:distance_check_3_4
  s/\[dis_th_fu:8*:distfu\]//
  s/\[DTF:.*:FTD\]//
  h
  s/$/[dis_th_fu::distfu]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#12=.]*([34])?[@a0o*#12=.]*([34])?[@a0o*#12=.]*#\n/\1\2\n/g
  s/(\[dis_th_fu:)(:distfu\])\[DTF:.*[34](\n*)[34].*:FTD\]/\1\3\2/
  s/^.*(\[dis_th_fu:\n*:distfu\]).*$/\1/  
  y/\n/8/
  H; x; 
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[34][^\n]*[34].*\[FIELD_END\]/b distance_check_3_4_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[34][^\n]{,79}#\n#[^\n]{,79}[34][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_3_4_put_on_line
s/#{79}.*\n(#[^\n]{,79}[34][^\n]{,79}#\n).*\n(#[^\n]{,79}[34][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_3_4_put_on_line
  s/^.*#{79}[^34]*\n(#[^\n]{,79}[34][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([34])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_3_4_hcompare
  s/[34]([^\n]*)[34].*\[FIELD_END\].*(\[dis_th_fu:8*)(:distfu\])/\2\1\3/
  s/^.*(\[dis_th_fu:.*:distfu\]).*$/\1/
  y/@ao0=*#.12/8888888888/
  s/(\[dis_th_fu)/\1SPIKE/
  H; x; 
  s/\n?\[dis_th_fu:8*:distfu\]//
  s/\n?(\[dis_th_fu)SPIKE/\1/

:distance_check_3_1
  s/\[dis_th_fi:8*:distfi\]//
  s/\[DTF:.*:FTD\]//
  h
  s/$/[dis_th_fi::distfi]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#42=.]*([31])?[@a0o*#42=.]*([31])?[@a0o*#42=.]*#\n/\1\2\n/g
  s/(\[dis_th_fi:)(:distfi\])\[DTF:.*[31](\n*)[31].*:FTD\]/\1\3\2/
  s/^.*(\[dis_th_fi:\n*:distfi\]).*$/\1/  
  y/\n/8/
  H; x; 
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[31][^\n]*[31].*\[FIELD_END\]/b distance_check_3_1_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[31][^\n]{,79}#\n#[^\n]{,79}[31][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_3_1_put_on_line
s/#{79}.*\n(#[^\n]{,79}[31][^\n]{,79}#\n).*\n(#[^\n]{,79}[31][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_3_1_put_on_line
  s/^.*#{79}[^31]*\n(#[^\n]{,79}[31][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([31])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_3_1_hcompare
  s/[31]([^\n]*)[31].*\[FIELD_END\].*(\[dis_th_fi:8*)(:distfi\])/\2\1\3/
  s/^.*(\[dis_th_fi:.*:distfi\]).*$/\1/
  y/@ao0=*#.42/8888888888/
  s/(\[dis_th_fi)/\1SPIKE/
  H; x; 
  s/\n?\[dis_th_fi:8*:distfi\]//
  s/\n?(\[dis_th_fi)SPIKE/\1/

:distance_check_4_1
  s/\[dis_fu_fi:8*:disffi\]//
  s/\[DTF:.*:FTD\]//
  h
  s/$/[dis_fu_fi::disffi]/  
  s/(#.*)(\[FIELD_END\].*)$/\1\2[DTF:\1:FTD]/
  s/.*\[FIELD_END\]//
  s/#[@a0o*#32=.]*([41])?[@a0o*#32=.]*([41])?[@a0o*#32=.]*#\n/\1\2\n/g
  s/(\[dis_fu_fi:)(:disffi\])\[DTF:.*[41](\n*)[41].*:FTD\]/\1\3\2/
  s/^.*(\[dis_fu_fi:\n*:disffi\]).*$/\1/  
  y/\n/8/
  H; x; 
  #check horizontal distance
  h
  #skip preparation if already on the same line
  /[41][^\n]*[41].*\[FIELD_END\]/b distance_check_4_1_hcompare
  #put on neighbor lines
  /#{79}.*\n#[^\n]{,79}[41][^\n]{,79}#\n#[^\n]{,79}[41][^\n]{,79}#\n.*\[FIELD_END]/b distance_check_4_1_put_on_line
s/#{79}.*\n(#[^\n]{,79}[41][^\n]{,79}#\n).*\n(#[^\n]{,79}[41][^\n]{,79}#\n).*\[FIELD_END]/\1\2\[FIELD_END\]/
  :distance_check_4_1_put_on_line
  s/^.*#{79}[^32]*\n(#[^\n]{,79}[41][^\n]{,79}#\n.*\[FIELD_END\])/\1/
  s/(.)(.{79})([41])(.*\[FIELD_END\])/\3\2\1\4/
  :distance_check_4_1_hcompare
  s/[41]([^\n]*)[41].*\[FIELD_END\].*(\[dis_fu_fi:8*)(:disffi\])/\2\1\3/
  s/^.*(\[dis_fu_fi:.*:disffi\]).*$/\1/
  y/@ao0=*#.32/8888888888/
  s/(\[dis_fu_fi)/\1SPIKE/
  H; x; 
  s/\n?\[dis_fu_fi:8*:disffi\]//
  s/\n?(\[dis_fu_fi)SPIKE/\1/
  
  b print_to_ai_handler

:end
s/\[ai_2_cmd_complete\]//g
