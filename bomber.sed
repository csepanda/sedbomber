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

$ s/$/\n\n\n\n/
H; b end;

#first player controll
x

:print
    /bomb/b terrorism_handler
:print_flashback
    #remove last command and save current game state to hold buffer
    s/\[cmd_.*\]\n//; h

    #bomb's blinking
    /first_bomb_timer_1+\]/ {
        /first_bomb_timer_1{,10}\]/ {
            /first_bomb_timer_(11)+\]/      s/@/./
        }
        /first_bomb_timer_1{10,20}\]/ {
            /first_bomb_timer_(111)+\]/     s/@/./
        }
        /first_bomb_timer_1{20}\]/ {
            /first_bomb_timer_(111111)+\]/  s/@/./
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
    s/\[status_.*//g
    #s/^/[2J/
    s/^/[H/
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
    s/first_bomb_timer_/first_bomb_blast_11/
    t check_next_isis_1
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
    s/second_bomb_timer_/second_bomb_blast_11/
    t check_next_isis_2
    /second_planting/b second_commit_suicide

    /second_bomb_blast_11/ {
        s/second_bomb_blast_11/second_bomb_blast_1/
        s/[1-4=.]a/*a/
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
    s/third_bomb_timer_/third_bomb_blast_11/
    t check_next_isis_3
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
    s/fourth_bomb_timer_/fourth_bomb_blast_11/
    t print_flashback
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

:end

