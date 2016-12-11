# Originally developed by Andrey Bova
# 10/12/2016

/^\[cmd/ {
    /\[cmd_1_up\]/    { g; b first_up;        }
    /\[cmd_1_down\]/  { g; b first_down;      }
    /\[cmd_1_left\]/  { g; b first_left;      }
    /\[cmd_1_right\]/ { g; b first_right;     }
    /\[cmd_1_plant\]/ { g; b first_terrorist; }
    /\[cmd_nothing\]/ { g; b print;           }
    b end;
}

H; b end;

#first player controll
x

:print
    /bomb/b terrorism_handler
:print_flashback
    #remove last command and save current game state to hold buffer
    s/\[cmd_.*\]\n//; h

    #bomb's blinking
    /first_bomb_timer_1\+\]/ {
        /first_bomb_timer_1\{,10\}\]/ {
            /first_bomb_timer_\(11\)\+\]/ s/@/./
        }
        /first_bomb_timer_1\{10,20\}\]/ {
            /first_bomb_timer_\(111\)\+\]/ s/@/./
        }
        /first_bomb_timer_1\{20\}\]/ {
            /first_bomb_timer_\(111111\)\+\]/ s/@/./
        }
    }
    #planting player's blinking
    /first_planting/ { 
        /first_bomb_timer_\(111\)\+\]/ {
            s/1/@/
        }
    }
    /first_bomb_blast/ {        
        s/@/*/
        /first_planting/ s/1/*/
    }
    s/\./ /g
    #s/\#/\[48;5;231m \[0m/g
    s/\[status_.*//g
    s/^/[2J/
    p; b end

:first_left
    s/\.1/1MOVED./g
    /1MOVED.*first_planting/ {
        s/1MOVED\./1@/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:first_right
    s/1\./.1MOVED/g
    /1MOVED.*first_planting/ {
        s/\.1MOVED/@1/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:first_up
    s/\.\(.\{79\}\)1/1MOVED\1./
    /1MOVED.*first_planting/ {
        s/1MOVED\(.\{79\}\)\./1\1@/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:first_down
    s/1\(.\{79\}\)\./.\11MOVED/ 
    /1MOVED.*first_planting/ {
        s/\.\(.\{79\}\)1MOVED/@\11/g
        s/\[status_first_planting\]//g
    }
    s/1MOVED/1/g    
    b print

:messages_handler 
    #TODO FIX
    s/\[message_immediately_\(.*\)\]/\n\1/

:first_terrorist
    /first_bomb_/ {
        b print
    }
    s/$/\[status_first_planting\]/
    s/$/\[status_first_bomb_timer_1111111111111111111111111111111\]/
    b print

:terrorism_handler
    /first_bomb_timer/b first_isis_warrior_handler    
    /first_bomb_blast/b first_bomb_tsss_boom 
    :check_next_isis
    b print_flashback

:first_isis_warrior_handler
    /first_bomb_timer_\]/ {
        b first_bomb_tsss_boom
    }
    #removing one each tact 
    s/\(first_bomb_timer_1*\)1\]/\1\]/ 
    b check_next_isis

:first_bomb_tsss_boom
    s/first_bomb_timer_/first_bomb_blast_11/
    t check_next_isis
    /first_planting/b first_commit_suicide

    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]@/*@/
        s/@[1-4=.]/@*/
        s/[1-4=.]\(.\{79\}\)@/*\1@/
        s/@\(.\{79\}\)[1-4=.]/@\1*/
        b check_next_isis
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/[1-4=.]\*@/**@/
        s/@\*[1-4=.]/@**/
        s/[1-4=.]\(.\{79\}\*.\{79\}\)@/*\1@/
        s/@\(.\{79\}\*.\{79\}\)[1-4=.]/@\1*/
        b check_next_isis
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*\*@/..@/
        s/\*@/.@/
        s/@\*\*/@../
        s/@\*/@./
        s/\*\(.\{79\}\*.\{79\}\)@/.\1@/
        s/\*\(.\{79\}\)@/.\1@/
        s/@\(.\{79\}\*.\{79\}\)\*/@\1./
        s/@\(.\{79\}\)\*/@\1./
        s/@/./
        b check_next_isis
    }
    b check_next_isis

:first_commit_suicide
    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.]1/*1/
        s/1[1-4=.]/1*/
        s/[1-4=.]\(.\{79\}\)1/*\11/
        s/1\(.\{79\}\)[1-4=.]/1\1*/
        b check_next_isis
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        s/[1-4=.]\*1/**1/
        s/1\*[1-4=.]/1**/
        s/[1-4=.]\(.\{79\}\*.\{79\}\)1/*\11/
        s/1\(.\{79\}\*.\{79\}\)[1-4=.]/1\1*/
        b check_next_isis
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*\*1/..1/
        s/\*1/.1/
        s/1\*\*/1../
        s/1\*/1./
        s/\*\(.\{79\}\*.\{79\}\)1/.\11/
        s/\*\(.\{79\}\)1/.\11/
        s/1\(.\{79\}\*.\{79\}\)\*/1\1./
        s/1\(.\{79\}\)\*/1\1./
        s/1/./
        b check_next_isis
    }
    b check_next_isis
:end

