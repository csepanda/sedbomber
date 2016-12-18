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
    b distance_check_2_1
:prerw
    b ai_handler
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
        s/\]/\]\n/g
        s/^/[2J/
    }
    /\[DEBUG_MODE\]/! { 
       # s/\[.*\]//g
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
        s/\.(.{79})2MOVED/@\10/
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
    /first_bomb_timer/b  first_isis_warrior_handler    
    /first_bomb_blast/b  first_bomb_tsss_boom 
    :check_next_isis_1
    /second_bomb_timer/b second_isis_warrior_handler    
    /second_bomb_blast/b second_bomb_tsss_boom 
    :check_next_isis_2
    /third_bomb_timer/b  third_isis_warrior_handler    
    /third_bomb_blast/b  third_bomb_tsss_boom 
    :check_next_isis_3
    /fourth_bomb_timer/b fourth_isis_warrior_handler    
    /fourth_bomb_blast/b fourth_bomb_tsss_boom 
    b print_flashback

:first_isis_warrior_handler
    /first_bomb_timer_\]/ {
        b first_bomb_tsss_boom
    }
    #removing one each tact 
    s/(first_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_1

:first_bomb_tsss_boom
    /first_bomb_timer_/ { 
        s/first_bomb_timer_/first_bomb_blast_11/ 
        b check_next_isis_1 
    }
    /first_planting/b first_commit_suicide

    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]@/*@/
        s/@[1-4=.]/@*/
        s/[1-4=.](.{79})@/*\1@/
        s/@(.{79})[1-4=.]/@\1*/
        b check_next_isis_1
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/[1-4=.]\*@/**@/
        s/@\*[1-4=.]/@**/
        s/[1-4=.](.{79}\*.{79})@/*\1@/
        s/@(.{79}\*.{79})[1-4=.]/@\1*/
        b check_next_isis_1
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*\*@/..@/
        s/\*@/.@/
        s/@\*\*/@../
        s/@\*/@./
        s/\*(.{79}\*.{79})@/.\1@/
        s/\*(.{79})@/.\1@/
        s/@(.{79}\*.{79})\*/@\1./
        s/@(.{79})\*/@\1./
        s/@/./
        b check_next_isis_1
    }
    b check_next_isis_1

:first_commit_suicide
    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]1/*1/
        s/1[1-4=.]/1*/
        s/[1-4=.](.{79})1/*\11/
        s/1(.{79})[1-4=.]/1\1*/
        b check_next_isis_1
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/[1-4=.]\*1/**1/
        s/1\*[1-4=.]/1**/
        s/[1-4=.](.{79}\*.{79})1/*\11/
        s/1(.{79}\*.{79})[1-4=.]/1\1*/
        b check_next_isis_1
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*\*1/..1/
        s/\*1/.1/
        s/1\*\*/1../
        s/1\*/1./
        s/\*(.{79}\*.{79})1/.\11/
        s/\*(.{79})1/.\11/
        s/1(.{79}\*.{79})\*/1\1./
        s/1(.{79})\*/1\1./
        s/1/./
        b check_next_isis_1
    }
    b check_next_isis_1

:second_isis_warrior_handler
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
        s/a[1-4=.]/a*/
        s/[1-4=.](.{79})a/*\1a/
        s/a(.{79})[1-4=.]/a\1*/
        b check_next_isis_2
    }
    /second_bomb_blast_1/ {
        s/second_bomb_blast_1/second_bomb_blast_/
        s/[1-4=.]\*a/**a/
        s/a\*[1-4=.]/a**/
        s/[1-4=.](.{79}\*.{79})a/*\1a/
        s/a(.{79}\*.{79})[1-4=.]/a\1*/
        b check_next_isis_2
    }
    /second_bomb_blast_/ {
        s/\[status_second_bomb_blast_\]//
        s/\*\*a/..a/
        s/\*a/.a/
        s/a\*\*/a../
        s/a\*/a./
        s/\*(.{79}\*.{79})a/.\1a/
        s/\*(.{79})a/.\1a/
        s/a(.{79}\*.{79})\*/a\1./
        s/a(.{79})\*/a\1./
        s/a/./
        b check_next_isis_2
    }
    b check_next_isis_2

:second_commit_suicide
    /second_bomb_blast_11/ {
        s/second_bomb_blast_11/second_bomb_blast_1/
        s/[1-4=.]2/*2/
        s/2[1-4=.]/2*/
        s/[1-4=.](.{79})2/*\12/
        s/2(.{79})[1-4=.]/2\1*/
        b check_next_isis_2
    }
    /second_bomb_blast_1/ {
        s/second_bomb_blast_1/second_bomb_blast_/
        s/[1-4=.]\*2/**2/
        s/2\*[1-4=.]/2**/
        s/[1-4=.](.{79}\*.{79})1/*\12/
        s/2(.{79}\*.{79})[1-4=.]/2\1*/
        b check_next_isis_2
    }
    /second_bomb_blast_/ {
        s/\[status_second_bomb_blast_\]//
        s/\*\*2/..2/
        s/\*2/.2/
        s/2\*\*/2../
        s/2\*/2./
        s/\*(.{79}\*.{79})2/.\12/
        s/\*(.{79})2/.\12/
        s/2(.{79}\*.{79})\*/2\1./
        s/2(.{79})\*/2\1./
        s/2/./
        b check_next_isis_2
    }
    b check_next_isis_2

:third_isis_warrior_handler
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
        s/[1-4=.]0/*0/
        s/0[1-4=.]/0*/
        s/[1-4=.](.{79})0/*\10/
        s/0(.{79})[1-4=.]/0\1*/
        b check_next_isis_3
    }
    /third_bomb_blast_1/ {
        s/third_bomb_blast_1/third_bomb_blast_/
        s/[1-4=.]\*0/**0/
        s/0\*[1-4=.]/0**/
        s/[1-4=.](.{79}\*.{79})0/*\10/
        s/0(.{79}\*.{79})[1-4=.]/0\1*/
        b check_next_isis_3
    }
    /third_bomb_blast_/ {
        s/\[status_third_bomb_blast_\]//
        s/\*\*0/..0/
        s/\*0/.0/
        s/0\*\*/0../
        s/0\*/0./
        s/\*(.{79}\*.{79})0/.\10/
        s/\*(.{79})0/.\10/
        s/0(.{79}\*.{79})\*/0\1./
        s/0(.{79})\*/0\1./
        s/0/./
        b check_next_isis_3
    }
    b check_next_isis_3

:third_commit_suicide
    /third_bomb_blast_11/ {
        s/third_bomb_blast_11/third_bomb_blast_1/
        s/[1-4=.]3/*3/
        s/3[1-4=.]/3*/
        s/[1-4=.](.{79})3/*\13/
        s/3(.{79})[1-4=.]/3\1*/
        b check_next_isis_3
    }
    /third_bomb_blast_1/ {
        s/third_bomb_blast_1/third_bomb_blast_/
        s/[1-4=.]\*3/**3/
        s/3\*[1-4=.]/3**/
        s/[1-4=.](.{79}\*.{79})3/*\13/
        s/3(.{79}\*.{79})[1-4=.]/3\1*/
        b check_next_isis_3
    }
    /third_bomb_blast_/ {
        s/\[status_third_bomb_blast_\]//
        s/\*\*3/..3/
        s/\*3/.3/
        s/3\*\*/3../
        s/3\*/3./
        s/\*(.{79}\*.{79})3/.\13/
        s/\*(.{79})3/.\13/
        s/3(.{79}\*.{79})\*/3\1./
        s/3(.{79})\*/3\1./
        s/3/./
        b check_next_isis_3
    }
    b check_next_isis_3

:fourth_isis_warrior_handler
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
        s/[1-4=.]o/*o/
        s/o[1-4=.]/o*/
        s/[1-4=.](.{79})o/*\1o/
        s/o(.{79})[1-4=.]/o\1*/
        b print_flashback
    }
    /fourth_bomb_blast_1/ {
        s/fourth_bomb_blast_1/fourth_bomb_blast_/
        s/[1-4=.]\*o/**o/
        s/o\*[1-4=.]/o**/
        s/[1-4=.](.{79}\*.{79})o/*\1o/
        s/o(.{79}\*.{79})[1-4=.]/o\1*/
        b print_flashback
    }
    /fourth_bomb_blast_/ {
        s/\[status_fourth_bomb_blast_\]//
        s/\*\*o/..o/
        s/\*o/.o/
        s/o\*\*/o../
        s/o\*/o./
        s/\*(.{79}\*.{79})o/.\1o/
        s/\*(.{79})o/.\1o/
        s/o(.{79}\*.{79})\*/o\1./
        s/o(.{79})\*/o\1./
        s/o/./
        b print_flashback
    }
    b print_flashback

:fourth_commit_suicide
    /fourth_bomb_blast_11/ {
        s/fourth_bomb_blast_11/fourth_bomb_blast_1/
        s/[1-4=.]4/*4/
        s/4[1-4=.]/4*/
        s/[1-4=.](.{79})4/*\14/
        s/4(.{79})[1-4=.]/4\1*/
        b print_flashback
    }
    /fourth_bomb_blast_1/ {
        s/fourth_bomb_blast_1/fourth_bomb_blast_/
        s/[1-4=.]\*4/**4/
        s/4\*[1-4=.]/4**/
        s/[1-4=.](.{79}\*.{79})4/*\14/
        s/4(.{79}\*.{79})[1-4=.]/4\1*/
        b print_flashback
    }
    /fourth_bomb_blast_/ {
        s/\[status_fourth_bomb_blast_\]//
        s/\*\*4/..4/
        s/\*4/.4/
        s/4\*\*/4../
        s/4\*/4./
        s/\*(.{79}\*.{79})4/.\14/
        s/\*(.{79})4/.\14/
        s/4(.{79}\*.{79})\*/4\1./
        s/4(.{79})\*/4\1./
        s/4/./
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
b print_after_ai
#set goals for AI_FSM
  /\[ai_2_cmd_query/! {
    #taking cover
    /[@a0o*](.{79}(\..{79}(\..{79})?)?)2.*\[FIELD_END\]/ { 
      s/\[ai_2_goal_line_up\]//g
      s/\[ai_2_goal_shift_(left|right)\]//g
      s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
      s/$/\[ai_2_goal_line_down\]/
      /\[ai_2_taking_cover/! {
        s/(([@a0o])(.{79}(\..{79}(\..{79})?)?)2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2(.{79}(\..{79}(\..{79})?)?)[@a0o*].*\[FIELD_END\]/ {
      s/\[ai_2_goal_line_down\]//g
      s/\[ai_2_goal_shift_(left|right)\]//g
      s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
      s/$/\[ai_2_goal_line_up\]/
      /\[ai_2_taking_cover/! {
        s/(2(.{79}(\..{79}(\..{79})?)?)([@a0o]).*)$/\1\[ai_2_taking_cover_\5\]/
      }
      b ai_2_goal_handler
    }
    
    /[@a0o*]\.?\.?\.?2.*\[FIELD_END\]/ {
      s/\[ai_2_goal_shift_left\]//g
      s/\[ai_2_goal_line_(up|down)\]//g
      s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
      s/$/\[ai_2_goal_shift_right\]/
      /\[ai_2_taking_cover/! { 
        s/(([@a0o])\.?\.?\.?2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2\.?\.?\.?[@a0o*].*\[FIELD_END\]/ {
      s/\[ai_2_goal_shift_right\]//g
      s/\[ai_2_goal_line_(up|down)\]//g
      s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
      s/$/[ai_2_goal_shift_left]/
      /\[ai_2_taking_cover/! {
        s/(2\.?\.?\.?([@a0o]).*)$/\1[ai_2_taking_cover_\2]/
      }
      b ai_2_goal_handler
    }
    #choose target
    
    
    #seeking target
    /\[ai_2_goal_line_up\]/! {
        /1([^\n]+\n[^\n]+)+2.*\[FIELD_END\]/ {
            s/\[ai_2_goal_line_(down|up)\]//g
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
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
            /1[^\n]*#2#/ { s/$/[ai_2_goal_slide_up_left]/; b 2_goal_up_fin; }
            /#2#[^\n]*1/ { s/$/[ai_2_goal_slide_up_right]/;b 2_goal_up_fin; }
            /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :2_goal_up_fin
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
            s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
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
            
            /1[^\n]*#2#/ {s/$/[ai_2_goal_slide_down_left]/; b 2_goal_down_fin;}
            /#2#[^\n]*1/ {s/$/[ai_2_goal_slide_down_right]/;b 2_goal_down_fin;}
            /1[^\n]*2.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_left]/  }
            /2[^\n]*1.*\[FIELD_END\]/ { s/$/[ai_2_goal_shift_right]/ }
            :2_goal_down_fin
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
        /1[^\n#]+2/ {
            s/\[ai_2_goal_shift_(right|left)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//g
            s/$/[ai_2_goal_shift_left]/
        }
    }

    /\[ai_2_goal_shift_rigth\]/! {
        /2[^\n#]+1/ {
            s/\[ai_2_goal_shift_(left|right)\]//g
            s/\[ai_2_goal_line_(up|down)\]//g
            s/\[ai_2_goal_slide_(up|down)_(left|right)\]//g
            s/\[ai_2_goal_plant_bomb\]//
            s/$/[ai_2_goal_shift_right]/
        }
    }
#SEEK_GOAL_COMPLETE; Time to blow it
    /\[ai_2_goal_plant_bomb\]/! {
      /[12](\.?|.{79}|.{79}\..{79})[21].*\[FIELD_END\]/ {
          s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
  }
:ai_2_goal_handler
#GOAL_HANDLER    
    /\[ai_2_cmd_query/! {
        /\[ai_2_goal_plant_bomb\]/ {
            s/\[ai_2_goal_plant_bomb\]//
            s/$/\[ai_2_cmd_query_!plant\]/
            #go_away_way
            /1\.?2/                  s/$/[ai_2_goal_shift_right]/
            /2\.?1/                  s/$/[ai_2_goal_shift_left]/
            /1(.{79}|.{79}\..{79})2/ s/$/[ai_2_goal_line_down]/
            /2(.{79}|.{79}\..{79})1/ s/$/[ai_2_goal_line_up]/
        }
        /\[ai_2_goal_line_up\]/ {            
            /\.(.{79})2/  { s/$/[ai_2_cmd_query_!up]/;            b asd; }
            /#\.(.{78})2/ { s/$/[ai_2_cmd_query_!right_!up]/;     b asd; }
            /\.#(.{79})2/ { s/$/[ai_2_cmd_query_!left_!up]/;       b asd; }
        }
        /\[ai_2_goal_line_down\]/ {
            /2(.{79})\./  { s/$/[ai_2_cmd_query_!down]/;          b asd; }
            /2(.{79})#\./ { s/$/[ai_2_cmd_query_!right_!down]/;   b asd; }
            /2(.{78})\.#/ { s/$/[ai_2_cmd_query_!left_!down]/;     b asd; }
        }
        /\[ai_2_goal_shift_right\]/ {
            /2\./           { s/$/[ai_2_cmd_query_!right]/;       b asd; }
            /\.\.(.{79})2#/ { s/$/[ai_2_cmd_query_!up_!right]/;   b asd; }
            /2#(.{79})\.\./ { s/$/[ai_2_cmd_query_!down_!right]/; b asd; }
        }
        /\[ai_2_goal_shift_left\]/ {
            /\.2/           { s/$/[ai_2_cmd_query_!left]/;        b asd; }
            /\.\.(.{79})#2/ { s/$/[ai_2_cmd_query_!up_!left]/;    b asd; }
            /#2(.{79})\.\./ { s/$/[ai_2_cmd_query_!down_!left]/;  b asd; }
        }
        s/(\[ai_2_goal_slide_(up|down)_(left|right)\].*)$/\1[ai_2_cmd_query_!\2_!\3]/
    }
:asd
#CMD_QUERY_HANDLER
    /\[ai_2_cmd_query.*/ {
        /\[ai_2_cmd_complete\]/b sad
        s/$/\[ai_2_cmd_complete\]/
        /\[ai_2_cmd_query_!plant\]/ {
            s/\[ai_2_cmd_query_!plant\]//
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
:sad

:ai_next
s/\[ai_(2|3|4)_cmd_complete\]//g
s/\[ai_(2|3|4)_cmd_query\]//
/\[ai_2_taking_cover/ {
    s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0o]).*\[ai_2_taking_cover_\1/b print_after_ai
}
s/\[ai_2_taking_cover_[@a0o]\]//g
b print_after_ai


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
  b prerw
:end
s/\[ai_2_cmd_complete\]//g




