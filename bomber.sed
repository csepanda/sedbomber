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
    b end
}

/^\[RANDOM_NUMBER/ {
    b bonus_generator
}

#FIELD EATING
H; x
s/^\n(#{79})/\1/
x
b end

:print
    /bomb/b terrorism_handler
:print_flashback
/\[ai_[2-4]_cmd_complete\]/b print_to_ai_handler
    b distance_check
:print_to_ai_handler    
    /\[AI_ON_2\]/ { /^.*2.*\[FIELD_END\]/ b second_terrorist_ai; }
:ai_2_finish
    /\[AI_ON_3\]/  { /^.*3.*\[FIELD_END\]/ b third_terrorist_ai;  }
:ai_3_finish
    /\[AI_ON_4\]/ { /^.*4.*\[FIELD_END\]/ b fourth_terrorist_ai; }
:ai_4_finish
    b  ai_cmds_completed
:print_after_ai
    #remove last command and save current game state to hold buffer
    s/\n{2,}//
    s/\[cmd_.*\]\n//; h
    #bomb's blinking
    /first_bomb_timer_1+\]/ {
      /first_bomb_timer_1{,10}\]/ {
        /first_bomb_timer_(11)+\]/      s/@(.*\[FIELD_END)/.\1/
      }
      /first_bomb_timer_1{10,20}\]/ {
        /first_bomb_timer_(111)+\]/     s/@(.*\[FIELD_END)/.\1/
      }
      /first_bomb_timer_1{20}\]/ {
        /first_bomb_timer_(1111111)+\]/ s/@(.*\[FIELD_END)/.\1/
      }
    }

    /first_abomb_timer_1+\]/ {
      /first_abomb_timer_1{,10}\]/ {
        /first_abomb_timer_(11)+\]/      s/x(.*\[FIELD_END)/.\1/
      }
      /first_abomb_timer_1{10,20}\]/ {
        /first_abomb_timer_(111)+\]/     s/x(.*\[FIELD_END)/.\1/
      }
      /first_abomb_timer_1{20}\]/ {
        /first_abomb_timer_(1111111)+\]/ s/x(.*\[FIELD_END)/.\1/
      }
    }

    /second_bomb_timer_1+\]/ {
        /second_bomb_timer_1{,10}\]/ {
            /second_bomb_timer_(11)+\]/      s/a(.*\[FIELD_END)/.\1/
        }
        /second_bomb_timer_1{10,20}\]/ {
            /second_bomb_timer_(111)+\]/     s/a(.*\[FIELD_END)/.\1/
        }
        /second_bomb_timer_1{20}\]/ {
            /second_bomb_timer_(111111)+\]/  s/a(.*\[FIELD_END)/.\1/
        }
    }

    /second_abomb_timer_1+\]/ {
        /second_abomb_timer_1{,10}\]/ {
            /second_abomb_timer_(11)+\]/      s/A(.*\[FIELD_END)/.\1/
        }
        /second_abomb_timer_1{10,20}\]/ {
            /second_abomb_timer_(111)+\]/     s/A(.*\[FIELD_END)/.\1/
        }
        /second_abomb_timer_1{20}\]/ {
            /second_abomb_timer_(111111)+\]/  s/A(.*\[FIELD_END)/.\1/
        }
    }

    /third_bomb_timer_1+\]/ {
        /third_bomb_timer_1{,10}\]/ {
            /third_bomb_timer_(11)+\]/      s/0(.*\[FIELD_END)/.\1/
        }
        /third_bomb_timer_1{10,20}\]/ {
            /third_bomb_timer_(111)+\]/     s/0(.*\[FIELD_END)/.\1/
        }
        /third_bomb_timer_1{20}\]/ {
            /third_bomb_timer_(111111)+\]/  s/0(.*\[FIELD_END)/.\1/
        }
    }

    /third_abomb_timer_1+\]/ {
        /third_abomb_timer_1{,10}\]/ {
            /third_abomb_timer_(11)+\]/      s/y(.*\[FIELD_END)/.\1/
        }
        /third_abomb_timer_1{10,20}\]/ {
            /third_abomb_timer_(111)+\]/     s/y(.*\[FIELD_END)/.\1/
        }
        /third_abomb_timer_1{20}\]/ {
            /third_abomb_timer_(111111)+\]/  s/y(.*\[FIELD_END)/.\1/
        }
    }

    /fourth_bomb_timer_1+\]/ {
        /fourth_bomb_timer_1{,10}\]/ {
            /fourth_bomb_timer_(11)+\]/      s/o(.*\[FIELD_END)/.\1/
        }
        /fourth_bomb_timer_1{10,20}\]/ {
            /fourth_bomb_timer_(111)+\]/     s/o(.*\[FIELD_END)/.\1/
        }
        /fourth_bomb_timer_1{20}\]/ {
            /fourth_bomb_timer_(111111)+\]/  s/o(.*\[FIELD_END)/.\1/
        }
    }

    /fourth_abomb_timer_1+\]/ {
        /fourth_abomb_timer_1{,10}\]/ {
            /fourth_abomb_timer_(11)+\]/      s/O(.*\[FIELD_END)/.\1/
        }
        /fourth_abomb_timer_1{10,20}\]/ {
            /fourth_abomb_timer_(111)+\]/     s/O(.*\[FIELD_END)/.\1/
        }
        /fourth_abomb_timer_1{20}\]/ {
            /fourth_abomb_timer_(111111)+\]/  s/O(.*\[FIELD_END)/.\1/
        }
    }

    #planting player's blinking
    /first_planting/    { /first_bomb_timer_(111)+\]/  s/1/@/ }
    /first_bomb_blast/  { s/@/*/;    
                          /first_planting/  s/1/1*/ }
    /first_aplanting/   { /first_abomb_timer_(111)+\]/ s/1/@/ }
    /first_abomb_blast/ { s/x/*/;    
                          /first_aplanting/ s/1/*/ }

    /second_planting/   { /second_bomb_timer_(111)+\]/ s/2/a/ }
    /second_bomb_blast/ { s/a/*/;    
                          /second_planting/ s/2/*/ }
    /second_aplanting/   { /second_bomb_timer_(111)+\]/ s/2/a/ }
    /second_abomb_blast/ { s/A/*/;    
                          /second_aplanting/ s/2/*/ }

    /third_planting/    { /third_bomb_timer_(111)+\]/  s/3/0/ }
    /third_bomb_blast/  { s/0/*/;    
                          /third_planting/  s/3/*/ }
    /third_aplanting/    { /third_bomb_timer_(111)+\]/  s/3/0/ }
    /third_abomb_blast/  { s/y/*/;    
                           /third_aplanting/  s/3/*/ }

    /fourth_planting/   { /fourth_bomb_timer_(111)+\]/ s/4/o/ }
    /fourth_bomb_blast/ { s/o/*/;
                          /fourth_planting/ s/4/*/ }
    /fourth_aplanting/   { /fourth_bomb_timer_(111)+\]/ s/4/o/ }
    /fourth_abomb_blast/ { s/O/*/;
                           /fourth_aplanting/ s/4/*/ }
    /\[DEBUG_MODE\]/ {
        /\[DEBUG_MODE_NODIST\]/ s/\[dis.*:dis.{3}\]//g
        /\[DEBUG_MODE_NOBONU\]/ s/\[BONUS.*SUNOB\]//g
        s/\]/\]\n/g
        s/^/[2J/
    }
    /\[DEBUG_MODE\]/! { 
        s/\[.*\]//g
        s/[kfb]/=/g
        s/[qvp]/*/g
        s/^/[H/
    }
    s/\./ /g
    s/x/@/
    s/A/a/
    s/y/0/
    s/O/o/
    p; b end

:1_left
    /\[FIRST_BONUS:KICKER:BF\]/ {
        s/\.\.([@a0oxAyO])1(.*\[FIELD_END)/\1..1\2[!KICK!]/
        s/\.([@a0oxAyO])1(.*\[FIELD_END)/\1.1\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB]1.*\[FIELD_END\]/ {
        s/\[FIRST_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:KICKER:BF]/     }
        /F1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:PYROMANIAC:BF]/ }
        /B1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:BKEEPER:BF]/    }
        s/[KFB]1(.*\[FIELD_END\])/1M.\1/
        b 1_left_skip        
    }
    s/\.1/1M./
    :1_left_skip
    /1M.*first_planting/ {
        s/1M\./1@/
        s/\[status_first_planting\]//
    }
    /1M.*first_aplanting/ {
        s/1M\./1x/
        s/\[status_first_aplanting\]//
    }
    s/1M/1/g    
    b print

:1_right
    /\[FIRST_BONUS:KICKER:BF\]/ {
        s/1([@a0oxAyO])\.\.(.*\[FIELD_END)/1..\1\2[!KICK!]/
        s/1([@a0oxAyO])\.(.*\[FIELD_END)/1.\1\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /1[KFB].*\[FIELD_END\]/ {
        s/\[FIRST_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /1K.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:KICKER:BF]/     }
        /1F.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:PYROMANIAC:BF]/ }
        /1B.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:BKEEPER:BF]/    }
        s/1[KFB](.*\[FIELD_END\])/.1M\1/
        b 1_right_skip
    }
    s/1\./.1M/
    :1_right_skip
    /1M.*first_planting/ {
        s/\.1M/@1/
        s/\[status_first_planting\]//
    }
    /1M.*first_aplanting/ {
        s/\.1M/x1/
        s/\[status_first_aplanting\]//
    }
    s/1M/1/    
    b print

:1_up
    /\[FIRST_BONUS:KICKER:BF\]/ {
        s/\.(.{79}\..{79})([@a0oxAyO])(.{79})1(.*\[FIELD_END)/\2\1.\31\4[!KICK!]/
        s/\.(.{79})([@a0oxAyO])(.{79})1(.*\[FIELD_END)/\2\1.\31\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB].{79}1.*\[FIELD_END\]/ {
        s/\[FIRST_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K.{79}1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:KICKER:BF]/     }
        /F.{79}1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:PYROMANIAC:BF]/ }
        /B.{79}1.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:BKEEPER:BF]/    }
        s/[KFB](.{79})1(.*\[FIELD_END\])/1M\1.\2/
        b 1_up_skip
    }
    s/\.(.{79})1/1M\1./
    :1_up_skip
    /1M.*first_planting/ {
        s/1M(.{79})\./1\1@/
        s/\[status_first_planting\]//
    }
    /1M.*first_aplanting/ {
        s/1M(.{79})\./1\1x/
        s/\[status_first_aplanting\]//
    }
    s/1M/1/
    b print

:1_down
    /\[FIRST_BONUS:KICKER:BF\]/ {
        s/1(.{79})([@a0oxAyO])(.{79}\..{79})\.(.*\[FIELD_END)/1\1.\3\2\4[!KICK!]/
        s/1(.{79})([@a0oxAyO])(.{79})\.(.*\[FIELD_END)/1\1.\3\2\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /1.{79}[KFB].*\[FIELD_END\]/ {
        s/\[FIRST_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /1.{79}K.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:KICKER:BF]/     }
        /1.{79}F.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:PYROMANIAC:BF]/ }
        /1.{79}B.*\[FIELD_END\]/ { s/$/[FIRST_BONUS:BKEEPER:BF]/    }
        s/1(.{79})[KFB](.*\[FIELD_END\])/.\11M\2/
        b 1_down_skip
    }
    s/1(.{79})\./.\11M/ 
    :1_down_skip
    /1M.*first_planting/ {
        s/\.(.{79})1M/@\11/g
        s/\[status_first_planting\]//g
    }
    /1M.*first_aplanting/ {
        s/\.(.{79})1M/x\11/g
        s/\[status_first_aplanting\]//g
    }
    s/1M/1/g    
    b print

:1_terrorist    
    /first_bomb_/! {
        s/$/\[status_first_planting\]/
        s/$/\[status_first_bomb_timer_1111111111111111111111111111111\]/
        b print
    }
    /\[FIRST_BONUS:BKEEPER:BF\]/ {
        /first_abomb_/! {
            s/$/\[status_first_aplanting\]/
            s/$/\[status_first_abomb_timer_1111111111111111111111111111111\]/
        }
    }
    b print

#SECOND PLAYER
:2_left
    /\[SECOND_BONUS:KICKER:BF\]/ {
        s/\.\.([@a0oxAyO])2(.*\[FIELD_END)/\1..2\2[!KICK!]/
        s/\.([@a0oxAyO])2(.*\[FIELD_END)/\1.2\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB]2.*\[FIELD_END\]/ {
        s/\[SECOND_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:KICKER:BF]/     }
        /F2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:PYROMANIAC:BF]/ }
        /B2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:BKEEPER:BF]/    }
        s/[KFB]2(.*\[FIELD_END\])/2M.\1/
        b 2_left_skip
    }
    s/\.2/2M./
    :2_left_skip
    /2M.*second_planting/ {
        s/2M\./2a/
        s/\[status_second_planting\]//
    }
    /2M.*second_aplanting/ {
        s/2M\./2A/
        s/\[status_second_aplanting\]//
    }
    s/2M/2/    
    b print

:2_right
    /\[SECOND_BONUS:KICKER:BF\]/ {
        s/2([@a0oxAyO])\.\.(.*\[FIELD_END)/2..\1\2[!KICK!]/
        s/2([@a0oxAyO])\.(.*\[FIELD_END)/2.\1\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /2[KFB].*\[FIELD_END\]/ {
        s/\[SECOND_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /2K.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:KICKER:BF]/     }
        /2F.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:PYROMANIAC:BF]/ }
        /2B.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:BKEEPER:BF]/    }
        s/2[KFB](.*\[FIELD_END\])/.2M\1/
        b 2_right_skip
    }
    s/2\./.2M/
    :2_right_skip
    /2M.*second_planting/ {
        s/\.2M/a2/
        s/\[status_second_planting\]//
    }
    /2M.*second_aplanting/ {
        s/\.2M/A2/
        s/\[status_second_aplanting\]//
    }
    s/2M/2/    
    b print

:2_up
    /\[SECOND_BONUS:KICKER:BF\]/ {
        s/\.(.{79}\..{79})([@a0oxAyO])(.{79})2(.*\[FIELD_END)/\2\1.\32\4[!KICK!]/
        s/\.(.{79})([@a0oxAyO])(.{79})2(.*\[FIELD_END)/\2\1.\32\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB].{79}2.*\[FIELD_END\]/ {
        s/\[SECOND_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K.{79}2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:KICKER:BF]/     }
        /F.{79}2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:PYROMANIAC:BF]/ }
        /B.{79}2.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:BKEEPER:BF]/    }
        s/[KFB](.{79})2(.*\[FIELD_END\])/2M\1.\2/
        b 2_up_skip
    }
    s/\.(.{79})2/2M\1./
    :2_up_skip
    /2M.*second_planting/ {
        s/2M(.{79})\./2\1a/
        s/\[status_second_planting\]//
    }
    /2M.*second_aplanting/ {
        s/2M(.{79})\./2\1A/
        s/\[status_second_aplanting\]//
    }
    s/2M/2/
    b print

:2_down
    /\[SECOND_BONUS:KICKER:BF\]/ {
        s/2(.{79})([@a0oxAyO])(.{79}\..{79})\.(.*\[FIELD_END)/2\1.\3\2\4[!KICK!]/
        s/2(.{79})([@a0oxAyO])(.{79})\.(.*\[FIELD_END)/2\1.\3\2\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /2.{79}[KFB].*\[FIELD_END\]/ {
        s/\[SECOND_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /2.{79}K.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:KICKER:BF]/     }
        /2.{79}F.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:PYROMANIAC:BF]/ }
        /2.{79}B.*\[FIELD_END\]/ { s/$/[SECOND_BONUS:BKEEPER:BF]/    }
        s/2(.{79})[KFB](.*\[FIELD_END\])/.\12M\2/
        b 2_down_skip
    }
    s/2(.{79})\./.\12M/ 
    :2_down_skip
    /2M.*second_planting/ {
        s/\.(.{79})2M/a\12/
        s/\[status_second_planting\]//
    }
    /2M.*second_aplanting/ {
        s/\.(.{79})2M/A\12/
        s/\[status_second_aplanting\]//
    }
    s/2M/2/
    b print

:2_terrorist
    /second_bomb_/! {
        s/$/\[status_second_planting\]/
        s/$/\[status_second_bomb_timer_1111111111111111111111111111111\]/
        b print    
    }
    /\[SECOND_BONUS:BKEEPER:BF\]/ {
        /second_abomb_/! {
            s/$/\[status_second_aplanting\]/
            s/$/\[status_second_abomb_timer_1111111111111111111111111111111\]/
        }
    }
    b print

#THIRD PLAYER
:3_left
    /\[THIRD_BONUS:KICKER:BF\]/ {
        s/\.\.([@a0oxAyO])3(.*\[FIELD_END)/\1..3\2[!KICK!]/
        s/\.([@a0oxAyO])3(.*\[FIELD_END)/\1.3\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB]3.*\[FIELD_END\]/ {
        s/\[THIRD_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:KICKER:BF]/     }
        /F3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:PYROMANIAC:BF]/ }
        /B3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:BKEEPER:BF]/    }
        s/[KFB]3(.*\[FIELD_END\])/3M.\1/
        b 3_left_skip
    }
    s/\.3/3M./
    :3_left_skip
    /3M.*third_planting/ {
        s/3M\./30/
        s/\[status_third_planting\]//
    }
    /3M.*third_aplanting/ {
        s/3M\./3y/
        s/\[status_third_aplanting\]//
    }
    s/3M/3/
    b print

:3_right
    /\[THIRD_BONUS:KICKER:BF\]/ {
        s/3([@a0oxAyO])\.\.(.*\[FIELD_END)/3..\1\2[!KICK!]/
        s/3([@a0oxAyO])\.(.*\[FIELD_END)/3.\1\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /3[KFB].*\[FIELD_END\]/ {
        s/\[THIRD_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /3K.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:KICKER:BF]/     }
        /3F.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:PYROMANIAC:BF]/ }
        /3B.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:BKEEPER:BF]/    }
        s/3[KFB](.*\[FIELD_END\])/.3M\1/
        b 3_right_skip
    }
    s/3\./.3M/
    :3_right_skip
    /3M.*third_planting/ {
        s/\.3M/03/
        s/\[status_third_planting\]//
    }
    /3M.*third_aplanting/ {
        s/\.3M/y3/
        s/\[status_third_aplanting\]//
    }
    s/3M/3/    
    b print

:3_up
    /\[THIRD_BONUS:KICKER:BF\]/ {
        s/\.(.{79}\..{79})([@a0oxAyO])(.{79})3(.*\[FIELD_END)/\2\1.\33\4[!KICK!]/
        s/\.(.{79})([@a0oxAyO])(.{79})3(.*\[FIELD_END)/\2\1.\33\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB].{79}3.*\[FIELD_END\]/ {
        s/\[THIRD_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K.{79}3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:KICKER:BF]/     }
        /F.{79}3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:PYROMANIAC:BF]/ }
        /B.{79}3.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:BKEEPER:BF]/    }
        s/[KFB](.{79})3(.*\[FIELD_END\])/3M\1.\2/
        b 3_up_skip
    }
    s/\.(.{79})3/3M\1./
    :3_up_skip
    /3M.*third_planting/ {
        s/3M(.{79})\./3\10/
        s/\[status_third_planting\]//
    }
    /3M.*third_aplanting/ {
        s/3M(.{79})\./3\1y/
        s/\[status_third_aplanting\]//
    }
    s/3M/3/
    b print

:3_down
    /\[THIRD_BONUS:KICKER:BF\]/ {
        s/3(.{79})([@a0oxAyO])(.{79}\..{79})\.(.*\[FIELD_END)/3\1.\3\2\4[!KICK!]/
        s/3(.{79})([@a0oxAyO])(.{79})\.(.*\[FIELD_END)/3\1.\3\2\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /3.{79}[KFB].*\[FIELD_END\]/ {
        s/\[THIRD_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /3.{79}K.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:KICKER:BF]/     }
        /3.{79}F.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:PYROMANIAC:BF]/ }
        /3.{79}B.*\[FIELD_END\]/ { s/$/[THIRD_BONUS:BKEEPER:BF]/    }
        s/3(.{79})[KFB](.*\[FIELD_END\])/.\13M\2/
        b 3_down_skip
    }
    s/3(.{79})\./.\13M/ 
    :3_down_skip
    /3M.*third_planting/ {
        s/\.(.{79})3M/0\13/
        s/\[status_third_planting\]//
    }
    /3M.*third_aplanting/ {
        s/\.(.{79})3M/y\13/
        s/\[status_third_aplanting\]//
    }
    s/3M/3/
    b print

:3_terrorist
    /third_bomb_/! {
        s/$/\[status_third_planting\]/
        s/$/\[status_third_bomb_timer_1111111111111111111111111111111\]/
        b print
    }
    /\[THIRD_BONUS:BKEEPER:BF\]/ {
        /third_abomb_/! {
            s/$/\[status_third_aplanting\]/
            s/$/\[status_third_abomb_timer_1111111111111111111111111111111\]/
        }
    }
    b print

#FOURTH PLAYER
:4_left
    /\[FOURTH_BONUS:KICKER:BF\]/ {
        s/\.\.([@a0oxAyO])4(.*\[FIELD_END)/\1..4\2[!KICK!]/
        s/\.([@a0oxAyO])4(.*\[FIELD_END)/\1.4\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB]4.*\[FIELD_END\]/ {
        s/\[FOURTH_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:KICKER:BF]/     }
        /F4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:PYROMANIAC:BF]/ }
        /B4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:BKEEPER:BF]/    }
        s/[KFB]4(.*\[FIELD_END\])/4M.\1/
        b 4_left_skip
    }
    s/\.4/4M./
    :4_left_skip
    /4M.*fourth_planting/ {
        s/4M\./4o/
        s/\[status_fourth_planting\]//
    }
    /4M.*fourth_aplanting/ {
        s/4M\./4O/
        s/\[status_fourth_aplanting\]//
    }
    s/4M/4/
    b print

:4_right
    /\[FOURTH_BONUS:KICKER:BF\]/ {
        s/4([@a0oxAyO])\.\.(.*\[FIELD_END)/4..\1\2[!KICK!]/
        s/4([@a0oxAyO])\.(.*\[FIELD_END)/4.\1\2[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /4[KFB].*\[FIELD_END\]/ {
        s/\[FOURTH_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /4K.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:KICKER:BF]/     }
        /4F.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:PYROMANIAC:BF]/ }
        /4B.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:BKEEPER:BF]/    }
        s/4[KFB](.*\[FIELD_END\])/.4M\1/
        b 4_right_skip
    }
    s/4\./.4M/
    :4_right_skip
    /4M.*fourth_planting/ {
        s/\.4M/o4/
        s/\[status_fourth_planting\]//
    }
    /4M.*fourth_aplanting/ {
        s/\.4M/O4/
        s/\[status_fourth_aplanting\]//
    }
    s/4M/4/
    b print

:4_up
    /\[FOURTH_BONUS:KICKER:BF\]/ {
        s/\.(.{79}\..{79})([@a0oxAyO])(.{79})4(.*\[FIELD_END)/\2\1.\34\4[!KICK!]/
        s/\.(.{79})([@a0oxAyO])(.{79})4(.*\[FIELD_END)/\2\1.\34\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /[KFB].{79}4.*\[FIELD_END\]/ {
        s/\[FOURTH_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /K.{79}4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:KICKER:BF]/     }
        /F.{79}4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:PYROMANIAC:BF]/ }
        /B.{79}4.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:BKEEPER:BF]/    }
        s/[KFB](.{79})4(.*\[FIELD_END\])/4M\1.\2/
        b 4_up_skip
    }
    s/\.(.{79})4/4M\1./
    :4_up_skip
    /4M.*fourth_planting/ {
        s/4M(.{79})\./4\1o/
        s/\[status_fourth_planting\]//
    }
    /4M.*fourth_aplanting/ {
        s/4M(.{79})\./4\1O/
        s/\[status_fourth_aplanting\]//
    }
    s/4M/4/
    b print

:4_down
    /\[FOURTH_BONUS:KICKER:BF\]/ {
        s/4(.{79})([@a0oxAyO])(.{79}\..{79})\.(.*\[FIELD_END)/4\1.\3\2\4[!KICK!]/
        s/4(.{79})([@a0oxAyO])(.{79})\.(.*\[FIELD_END)/4\1.\3\2\4[!KICK!]/
        /\[!KICK!\]/ { s/\[!KICK!\]//; b print; }
    }
    /4.{79}[KFB].*\[FIELD_END\]/ {
        s/\[FOURTH_BONUS:(KICKER|PYROMANIAC|BKEEPER):BF\]//
        /4.{79}K.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:KICKER:BF]/     }
        /4.{79}F.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:PYROMANIAC:BF]/ }
        /4.{79}B.*\[FIELD_END\]/ { s/$/[FOURTH_BONUS:BKEEPER:BF]/    }
        s/4(.{79})[KFB](.*\[FIELD_END\])/.\14M\2/
        b 4_down_skip
    }
    s/4(.{79})\./.\14M/ 
    :4_down_skip
    /4M.*fourth_planting/ {
        s/\.(.{79})4M/o\14/
        s/\[status_fourth_planting\]//
    }
    /4M.*fourth_aplanting/ {
        s/\.(.{79})4M/O\14/
        s/\[status_fourth_aplanting\]//
    }
    s/4M/4/
    b print

:4_terrorist
    /fourth_bomb_/! {
        s/$/\[status_fourth_planting\]/
        s/$/\[status_fourth_bomb_timer_1111111111111111111111111111111\]/
        b print
    }
    /\[FOURTH_BONUS:BKEEPER:BF\]/ {
        /fourth_abomb_/! {
            s/$/\[status_fourth_aplanting\]/
            s/$/\[status_fourth_abomb_timer_1111111111111111111111111111111\]/
        }
    }
    b print

:messages_handler 
    #TODO FIX
    s/\[message_immediately_(.*)\]/\n\1/


:terrorism_handler
    /first_bomb_tacted/  b check_next_isis_1
    /first_bomb_timer/   b first_isis_warrior_handler    
    /first_bomb_blast/   b first_bomb_tsss_boom 
  :check_next_isis_1
    /first_abomb_tacted/  b check_next_isis_11
    /first_abomb_timer/   b first_isis_awarrior_handler    
    /first_abomb_blast/   b first_abomb_tsss_boom 
  :check_next_isis_11
    /second_bomb_tacted/ b check_next_isis_2
    /second_bomb_timer/  b second_isis_warrior_handler    
    /second_bomb_blast/  b second_bomb_tsss_boom 
  :check_next_isis_2
    /second_abomb_tacted/ b check_next_isis_22
    /second_abomb_timer/  b second_isis_awarrior_handler    
    /second_abomb_blast/  b second_abomb_tsss_boom 
  :check_next_isis_22
    /third_bomb_tacted/  b check_next_isis_3
    /third_bomb_timer/   b third_isis_warrior_handler    
    /third_bomb_blast/   b third_bomb_tsss_boom 
  :check_next_isis_3
    /third_abomb_tacted/  b check_next_isis_33
    /third_abomb_timer/   b third_isis_awarrior_handler    
    /third_abomb_blast/   b third_abomb_tsss_boom 
  :check_next_isis_33
    /fourth_bomb_tacted/ b check_next_isis_4
    /fourth_bomb_timer/  b fourth_isis_warrior_handler    
    /fourth_bomb_blast/  b fourth_bomb_tsss_boom 
  :check_next_isis_4
    /fourth_abomb_tacted/ b check_next_isis_44
    /fourth_abomb_timer/  b fourth_isis_awarrior_handler    
    /fourth_abomb_blast/  b fourth_abomb_tsss_boom 
  :check_next_isis_44
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
    s/$/\[first_bomb_tacted\]/
    /first_bomb_timer_/ { 
        s/first_bomb_timer_/first_bomb_blast_111/
        b check_next_isis_1 
    }
    /first_planting/ { s/1(.*\[FIELD_END\])/@\1/ }

    /first_bomb_blast_111/ {
        s/first_bomb_blast_111/first_bomb_blast_11/
        s/[1-4=.KFB]@(.*\[FIELD_END\])/*@\1/
        s/@[1-4=.KFB](.*\[FIELD_END\])/@*\1/
        s/[1-4=.KFB](.{79})@(.*\[FIELD_END\])/*\1@\2/
        s/@(.{79})[1-4=.KFB](.*\[FIELD_END\])/@\1*\2/

        s/k@(.*\[FIELD_END\])/q@\1/
        s/@k(.*\[FIELD_END\])/@q\1/
        s/k(.{79})@(.*\[FIELD_END\])/q\1@\2/
        s/@(.{79})k(.*\[FIELD_END\])/@\1q\2/

        s/f@(.*\[FIELD_END\])/v@\1/
        s/@f(.*\[FIELD_END\])/@v\1/
        s/f(.{79})@(.*\[FIELD_END\])/v\1@\2/
        s/@(.{79})f(.*\[FIELD_END\])/@\1v\2/

        s/b@(.*\[FIELD_END\])/p@\1/
        s/@b(.*\[FIELD_END\])/@p\1/
        s/b(.{79})@(.*\[FIELD_END\])/p\1@\2/
        s/@(.{79})b(.*\[FIELD_END\])/@\1p\2/
        b check_next_isis_1
    }
    /first_bomb_blast_11/ {
        s/first_bomb_blast_11/first_bomb_blast_1/
        s/[1-4=.KFB]([^#])@(.*\[FIELD_END\])/*\1@\2/
        s/@([^#])[1-4=.KFB](.*\[FIELD_END\])/@\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})@(.*\[FIELD_END\])/*\1@\2/
        s/@(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/@\1*\2/

        s/k([^#])@(.*\[FIELD_END\])/q\1@\2/
        s/@([^#])k(.*\[FIELD_END\])/@\1q\2/
        s/k(.{79}[^#].{79})@(.*\[FIELD_END\])/q\1@\2/
        s/@(.{79}[^#].{79})k(.*\[FIELD_END\])/@\1q\2/

        s/f([^#])@(.*\[FIELD_END\])/v\1@\2/
        s/@([^#])f(.*\[FIELD_END\])/@\1v\2/
        s/f(.{79}[^#].{79})@(.*\[FIELD_END\])/v\1@\2/
        s/@(.{79}[^#].{79})f(.*\[FIELD_END\])/@\1v\2/

        s/b([^#])@(.*\[FIELD_END\])/p\1@\2/
        s/@([^#])b(.*\[FIELD_END\])/@\1p\2/
        s/b(.{79}[^#].{79})@(.*\[FIELD_END\])/p\1@\2/
        s/@(.{79}[^#].{79})b(.*\[FIELD_END\])/@\1p\2/
        b check_next_isis_1
    }
    /first_bomb_blast_1/ {
        s/first_bomb_blast_1/first_bomb_blast_/
        /\[FIRST_BONUS:PYROMANIAC:BF\]/!b check_next_isis_1
        s/[1-4=.KFB]([^#]{2})@(.*\[FIELD_END\])/*\1@\2/
        s/@([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/@\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/*\1@\2/
        s/@(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/@\1*\2/

        s/k([^#]{2})@(.*\[FIELD_END\])/q\1@\2/
        s/@([^#]{2})k(.*\[FIELD_END\])/@\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/q\1@\2/
        s/@(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/@\1q\2/

        s/f([^#]{2})@(.*\[FIELD_END\])/v\1@\2/
        s/@([^#]{2})f(.*\[FIELD_END\])/@\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/v\1@\2/
        s/@(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/@\1v\2/

        s/b([^#]{2})@(.*\[FIELD_END\])/p\1@\2/
        s/@([^#]{2})b(.*\[FIELD_END\])/@\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/p\1@\2/
        s/@(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/@\1p\2/
        b check_next_isis_1
    }
    /first_bomb_blast_/ {
        s/\[status_first_bomb_blast_\]//
        s/\*([^#]{2})@(.*\[FIELD_END\])/.\1@\2/
        s/q([^#]{2})@(.*\[FIELD_END\])/K\1@\2/
        s/v([^#]{2})@(.*\[FIELD_END\])/F\1@\2/
        s/p([^#]{2})@(.*\[FIELD_END\])/B\1@\2/
            s/\*([^#])@(.*\[FIELD_END\])/.\1@\2/
            s/q([^#])@(.*\[FIELD_END\])/K\1@\2/
            s/v([^#])@(.*\[FIELD_END\])/F\1@\2/
            s/p([^#])@(.*\[FIELD_END\])/B\1@\2/
                s/\*@(.*\[FIELD_END\])/.@\1/
                s/q@(.*\[FIELD_END\])/K@\1/
                s/v@(.*\[FIELD_END\])/F@\1/
                s/p@(.*\[FIELD_END\])/B@\1/
        s/@([^#]{2})\*(.*\[FIELD_END\])/@\1.\2/
        s/@([^#]{2})q(.*\[FIELD_END\])/@\1K\2/
        s/@([^#]{2})v(.*\[FIELD_END\])/@\1F\2/
        s/@([^#]{2})p(.*\[FIELD_END\])/@\1B\2/
            s/@([^#])\*(.*\[FIELD_END\])/@\1.\2/
            s/@([^#])q(.*\[FIELD_END\])/@\1K\2/
            s/@([^#])v(.*\[FIELD_END\])/@\1F\2/
            s/@([^#])p(.*\[FIELD_END\])/@\1B\2/
                s/@\*(.*\[FIELD_END\])/@.\1/
                s/@q(.*\[FIELD_END\])/@K\1/
                s/@v(.*\[FIELD_END\])/@F\1/
                s/@p(.*\[FIELD_END\])/@B\1/
        s/\*(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/.\1@\2/
        s/q(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/K\1@\2/
        s/v(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/F\1@\2/
        s/p(.{79}[^#].{79}[^#].{79})@(.*\[FIELD_END\])/B\1@\2/
            s/\*(.{79}[^#].{79})@(.*\[FIELD_END\])/.\1@\2/
            s/q(.{79}[^#].{79})@(.*\[FIELD_END\])/K\1@\2/
            s/v(.{79}[^#].{79})@(.*\[FIELD_END\])/F\1@\2/
            s/p(.{79}[^#].{79})@(.*\[FIELD_END\])/B\1@\2/
                s/\*(.{79})@(.*\[FIELD_END\])/.\1@\2/
                s/q(.{79})@(.*\[FIELD_END\])/K\1@\2/
                s/v(.{79})@(.*\[FIELD_END\])/F\1@\2/
                s/p(.{79})@(.*\[FIELD_END\])/B\1@\2/
        s/@(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/@\1.\2/
        s/@(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/@\1K\2/
        s/@(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/@\1F\2/
        s/@(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/@\1B\2/
            s/@(.{79}[^#].{79})\*(.*\[FIELD_END\])/@\1.\2/
            s/@(.{79}[^#].{79})q(.*\[FIELD_END\])/@\1K\2/
            s/@(.{79}[^#].{79})v(.*\[FIELD_END\])/@\1F\2/
            s/@(.{79}[^#].{79})p(.*\[FIELD_END\])/@\1B\2/
                s/@(.{79})\*(.*\[FIELD_END\])/@\1.\2/
                s/@(.{79})q(.*\[FIELD_END\])/@\1K\2/
                s/@(.{79})v(.*\[FIELD_END\])/@\1F\2/
                s/@(.{79})p(.*\[FIELD_END\])/@\1B\2/
        s/@(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_1

:first_isis_awarrior_handler
    s/$/\[first_abomb_tacted\]/
    /first_abomb_timer_\]/ {
        b first_abomb_tsss_boom
    }
    #removing one each tact 
    s/(first_abomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_11

:first_abomb_tsss_boom
    s/$/\[first_abomb_tacted\]/
    /first_abomb_timer_/ { 
        s/first_abomb_timer_/first_abomb_blast_111/
        b check_next_isis_11
    }
    /first_aplanting/ { s/1(.*\[FIELD_END\])/x\1/ }

    /first_abomb_blast_111/ {
        s/first_abomb_blast_111/first_abomb_blast_11/
        s/[1-4=.KFB]x(.*\[FIELD_END\])/*x\1/
        s/x[1-4=.KFB](.*\[FIELD_END\])/x*\1/
        s/[1-4=.KFB](.{79})x(.*\[FIELD_END\])/*\1x\2/
        s/x(.{79})[1-4=.KFB](.*\[FIELD_END\])/x\1*\2/

        s/kx(.*\[FIELD_END\])/qx\1/
        s/xk(.*\[FIELD_END\])/xq\1/
        s/k(.{79})x(.*\[FIELD_END\])/q\1x\2/
        s/x(.{79})k(.*\[FIELD_END\])/x\1q\2/

        s/fx(.*\[FIELD_END\])/vx\1/
        s/xf(.*\[FIELD_END\])/xv\1/
        s/f(.{79})x(.*\[FIELD_END\])/v\1x\2/
        s/x(.{79})f(.*\[FIELD_END\])/x\1v\2/

        s/bx(.*\[FIELD_END\])/px\1/
        s/xb(.*\[FIELD_END\])/xp\1/
        s/b(.{79})x(.*\[FIELD_END\])/p\1x\2/
        s/x(.{79})b(.*\[FIELD_END\])/x\1p\2/
        b check_next_isis_11
    }
    /first_abomb_blast_11/ {
        s/first_abomb_blast_11/first_abomb_blast_1/
        s/[1-4=.KFB]([^#])x(.*\[FIELD_END\])/*\1x\2/
        s/x([^#])[1-4=.KFB](.*\[FIELD_END\])/x\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})x(.*\[FIELD_END\])/*\1x\2/
        s/x(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/x\1*\2/

        s/k([^#])x(.*\[FIELD_END\])/q\1x\2/
        s/x([^#])k(.*\[FIELD_END\])/x\1q\2/
        s/k(.{79}[^#].{79})x(.*\[FIELD_END\])/q\1x\2/
        s/x(.{79}[^#].{79})k(.*\[FIELD_END\])/x\1q\2/

        s/f([^#])x(.*\[FIELD_END\])/v\1x\2/
        s/x([^#])f(.*\[FIELD_END\])/x\1v\2/
        s/f(.{79}[^#].{79})x(.*\[FIELD_END\])/v\1x\2/
        s/x(.{79}[^#].{79})f(.*\[FIELD_END\])/x\1v\2/

        s/b([^#])x(.*\[FIELD_END\])/p\1x\2/
        s/x([^#])b(.*\[FIELD_END\])/x\1p\2/
        s/b(.{79}[^#].{79})x(.*\[FIELD_END\])/p\1x\2/
        s/x(.{79}[^#].{79})b(.*\[FIELD_END\])/x\1p\2/
        b check_next_isis_11
    }
    /first_abomb_blast_1/ {
        s/first_abomb_blast_1/first_abomb_blast_/
        /\[FIRST_BONUS:PYROMANIAC:BF\]/!b check_next_isis_11
        s/[1-4=.KFB]([^#]{2})x(.*\[FIELD_END\])/*\1x\2/
        s/x([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/x\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/*\1x\2/
        s/x(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/x\1*\2/

        s/k([^#]{2})x(.*\[FIELD_END\])/q\1x\2/
        s/x([^#]{2})k(.*\[FIELD_END\])/x\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/q\1x\2/
        s/x(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/x\1q\2/

        s/f([^#]{2})x(.*\[FIELD_END\])/v\1x\2/
        s/x([^#]{2})f(.*\[FIELD_END\])/x\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/v\1x\2/
        s/x(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/x\1v\2/

        s/b([^#]{2})x(.*\[FIELD_END\])/p\1x\2/
        s/x([^#]{2})b(.*\[FIELD_END\])/x\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/p\1x\2/
        s/x(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/x\1p\2/
        b check_next_isis_11
    }
    /first_abomb_blast_/ {
        s/\[status_first_abomb_blast_\]//
        s/\*([^#]{2})x(.*\[FIELD_END\])/.\1x\2/
        s/q([^#]{2})x(.*\[FIELD_END\])/K\1x\2/
        s/v([^#]{2})x(.*\[FIELD_END\])/F\1x\2/
        s/p([^#]{2})x(.*\[FIELD_END\])/B\1x\2/
            s/\*([^#])x(.*\[FIELD_END\])/.\1x\2/
            s/q([^#])x(.*\[FIELD_END\])/K\1x\2/
            s/v([^#])x(.*\[FIELD_END\])/F\1x\2/
            s/p([^#])x(.*\[FIELD_END\])/B\1x\2/
                s/\*x(.*\[FIELD_END\])/.x\1/
                s/qx(.*\[FIELD_END\])/Kx\1/
                s/vx(.*\[FIELD_END\])/Fx\1/
                s/px(.*\[FIELD_END\])/Bx\1/
        s/x([^#]{2})\*(.*\[FIELD_END\])/x\1.\2/
        s/x([^#]{2})q(.*\[FIELD_END\])/x\1K\2/
        s/x([^#]{2})v(.*\[FIELD_END\])/x\1F\2/
        s/x([^#]{2})p(.*\[FIELD_END\])/x\1B\2/
            s/x([^#])\*(.*\[FIELD_END\])/x\1.\2/
            s/x([^#])q(.*\[FIELD_END\])/x\1K\2/
            s/x([^#])v(.*\[FIELD_END\])/x\1F\2/
            s/x([^#])p(.*\[FIELD_END\])/x\1B\2/
                s/x\*(.*\[FIELD_END\])/x.\1/
                s/xq(.*\[FIELD_END\])/xK\1/
                s/xv(.*\[FIELD_END\])/xF\1/
                s/xp(.*\[FIELD_END\])/xB\1/
        s/\*(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/.\1x\2/
        s/q(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/K\1x\2/
        s/v(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/F\1x\2/
        s/p(.{79}[^#].{79}[^#].{79})x(.*\[FIELD_END\])/B\1x\2/
            s/\*(.{79}[^#].{79})x(.*\[FIELD_END\])/.\1x\2/
            s/q(.{79}[^#].{79})x(.*\[FIELD_END\])/K\1x\2/
            s/v(.{79}[^#].{79})x(.*\[FIELD_END\])/F\1x\2/
            s/p(.{79}[^#].{79})x(.*\[FIELD_END\])/B\1x\2/
                s/\*(.{79})x(.*\[FIELD_END\])/.\1x\2/
                s/q(.{79})x(.*\[FIELD_END\])/K\1x\2/
                s/v(.{79})x(.*\[FIELD_END\])/F\1x\2/
                s/p(.{79})x(.*\[FIELD_END\])/B\1x\2/
        s/x(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/x\1.\2/
        s/x(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/x\1K\2/
        s/x(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/x\1F\2/
        s/x(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/x\1B\2/
            s/x(.{79}[^#].{79})\*(.*\[FIELD_END\])/x\1.\2/
            s/x(.{79}[^#].{79})q(.*\[FIELD_END\])/x\1K\2/
            s/x(.{79}[^#].{79})v(.*\[FIELD_END\])/x\1F\2/
            s/x(.{79}[^#].{79})p(.*\[FIELD_END\])/x\1B\2/
                s/x(.{79})\*(.*\[FIELD_END\])/x\1.\2/
                s/x(.{79})q(.*\[FIELD_END\])/x\1K\2/
                s/x(.{79})v(.*\[FIELD_END\])/x\1F\2/
                s/x(.{79})p(.*\[FIELD_END\])/x\1B\2/
        s/x(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_11

:second_isis_warrior_handler
    s/$/\[second_bomb_tacted\]/
    /second_bomb_timer_\]/ {
        b second_bomb_tsss_boom
    }
    #removing one each tact 
    s/(second_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_2

:second_bomb_tsss_boom
    s/$/\[second_bomb_tacted\]/
    /second_bomb_timer_/ {
        s/second_bomb_timer_/second_bomb_blast_111/
        b check_next_isis_2
    }
    /second_planting/ { s/2(.*\[FIELD_END\])/a\1/ }

    /second_bomb_blast_111/ {
        s/second_bomb_blast_111/second_bomb_blast_11/
        s/[1-4=.KFB]a(.*\[FIELD_END\])/*a\1/
        s/a[1-4=.KFB](.*\[FIELD_END\])/a*\1/
        s/[1-4=.KFB](.{79})a(.*\[FIELD_END\])/*\1a\2/
        s/a(.{79})[1-4=.KFB](.*\[FIELD_END\])/a\1*\2/

        s/ka(.*\[FIELD_END\])/qa\1/
        s/ak(.*\[FIELD_END\])/aq\1/
        s/k(.{79})a(.*\[FIELD_END\])/q\1a\2/
        s/a(.{79})k(.*\[FIELD_END\])/a\1q\2/

        s/fa(.*\[FIELD_END\])/va\1/
        s/af(.*\[FIELD_END\])/av\1/
        s/f(.{79})a(.*\[FIELD_END\])/v\1a\2/
        s/a(.{79})f(.*\[FIELD_END\])/a\1v\2/

        s/ba(.*\[FIELD_END\])/pa\1/
        s/ab(.*\[FIELD_END\])/ap\1/
        s/b(.{79})a(.*\[FIELD_END\])/p\1a\2/
        s/a(.{79})b(.*\[FIELD_END\])/a\1p\2/
        b check_next_isis_2
    }
    /second_bomb_blast_11/ {
        s/second_bomb_blast_11/second_bomb_blast_1/
        s/[1-4=.KFB]([^#])a(.*\[FIELD_END\])/*\1a\2/
        s/a([^#])[1-4=.KFB](.*\[FIELD_END\])/a\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})a(.*\[FIELD_END\])/*\1a\2/
        s/a(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/a\1*\2/

        s/k([^#])a(.*\[FIELD_END\])/q\1a\2/
        s/a([^#])k(.*\[FIELD_END\])/a\1q\2/
        s/k(.{79}[^#].{79})a(.*\[FIELD_END\])/q\1a\2/
        s/a(.{79}[^#].{79})k(.*\[FIELD_END\])/a\1q\2/

        s/f([^#])a(.*\[FIELD_END\])/v\1a\2/
        s/a([^#])f(.*\[FIELD_END\])/a\1v\2/
        s/f(.{79}[^#].{79})a(.*\[FIELD_END\])/v\1a\2/
        s/a(.{79}[^#].{79})f(.*\[FIELD_END\])/a\1v\2/

        s/b([^#])a(.*\[FIELD_END\])/p\1a\2/
        s/a([^#])b(.*\[FIELD_END\])/a\1p\2/
        s/b(.{79}[^#].{79})a(.*\[FIELD_END\])/p\1a\2/
        s/a(.{79}[^#].{79})b(.*\[FIELD_END\])/a\1p\2/
        b check_next_isis_2
    }
    /second_bomb_blast_1/ {
        s/second_bomb_blast_1/second_bomb_blast_/
        /\[SECOND_BONUS:PYROMANIAC:BF\]/!b check_next_isis_2
        s/[1-4=.KFB]([^#]{2})a(.*\[FIELD_END\])/*\1a\2/
        s/a([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/a\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/*\1a\2/
        s/a(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/a\1*\2/

        s/k([^#]{2})a(.*\[FIELD_END\])/q\1a\2/
        s/a([^#]{2})k(.*\[FIELD_END\])/a\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/q\1a\2/
        s/a(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/a\1q\2/

        s/f([^#]{2})a(.*\[FIELD_END\])/v\1a\2/
        s/a([^#]{2})f(.*\[FIELD_END\])/a\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/v\1a\2/
        s/a(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/a\1v\2/

        s/b([^#]{2})a(.*\[FIELD_END\])/p\1a\2/
        s/a([^#]{2})b(.*\[FIELD_END\])/a\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/p\1a\2/
        s/a(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/a\1p\2/
        b check_next_isis_2
    }
    /second_bomb_blast_/ {
        s/\[status_second_bomb_blast_\]//
        s/\*([^#]{2})a(.*\[FIELD_END\])/.\1a\2/
        s/q([^#]{2})a(.*\[FIELD_END\])/K\1a\2/
        s/v([^#]{2})a(.*\[FIELD_END\])/F\1a\2/
        s/p([^#]{2})a(.*\[FIELD_END\])/B\1a\2/
            s/\*([^#])a(.*\[FIELD_END\])/.\1a\2/
            s/q([^#])a(.*\[FIELD_END\])/K\1a\2/
            s/v([^#])a(.*\[FIELD_END\])/F\1a\2/
            s/p([^#])a(.*\[FIELD_END\])/B\1a\2/
                s/\*a(.*\[FIELD_END\])/.a\1/
                s/qa(.*\[FIELD_END\])/Ka\1/
                s/va(.*\[FIELD_END\])/Fa\1/
                s/pa(.*\[FIELD_END\])/Ba\1/
        s/a([^#]{2})\*(.*\[FIELD_END\])/a\1.\2/
        s/a([^#]{2})q(.*\[FIELD_END\])/a\1K\2/
        s/a([^#]{2})v(.*\[FIELD_END\])/a\1F\2/
        s/a([^#]{2})p(.*\[FIELD_END\])/a\1B\2/
            s/a([^#])\*(.*\[FIELD_END\])/a\1.\2/
            s/a([^#])q(.*\[FIELD_END\])/a\1K\2/
            s/a([^#])v(.*\[FIELD_END\])/a\1F\2/
            s/a([^#])p(.*\[FIELD_END\])/a\1B\2/
                s/a\*(.*\[FIELD_END\])/a.\1/
                s/aq(.*\[FIELD_END\])/aK\1/
                s/av(.*\[FIELD_END\])/aF\1/
                s/ap(.*\[FIELD_END\])/aB\1/
        s/\*(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/.\1a\2/
        s/q(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/K\1a\2/
        s/v(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/F\1a\2/
        s/p(.{79}[^#].{79}[^#].{79})a(.*\[FIELD_END\])/B\1a\2/
            s/\*(.{79}[^#].{79})a(.*\[FIELD_END\])/.\1a\2/
            s/q(.{79}[^#].{79})a(.*\[FIELD_END\])/K\1a\2/
            s/v(.{79}[^#].{79})a(.*\[FIELD_END\])/F\1a\2/
            s/p(.{79}[^#].{79})a(.*\[FIELD_END\])/B\1a\2/
                s/\*(.{79})a(.*\[FIELD_END\])/.\1a\2/
                s/q(.{79})a(.*\[FIELD_END\])/K\1a\2/
                s/v(.{79})a(.*\[FIELD_END\])/F\1a\2/
                s/p(.{79})a(.*\[FIELD_END\])/B\1a\2/
        s/a(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/a\1.\2/
        s/a(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/a\1K\2/
        s/a(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/a\1F\2/
        s/a(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/a\1B\2/
            s/a(.{79}[^#].{79})\*(.*\[FIELD_END\])/a\1.\2/
            s/a(.{79}[^#].{79})q(.*\[FIELD_END\])/a\1K\2/
            s/a(.{79}[^#].{79})v(.*\[FIELD_END\])/a\1F\2/
            s/a(.{79}[^#].{79})p(.*\[FIELD_END\])/a\1B\2/
                s/a(.{79})\*(.*\[FIELD_END\])/a\1.\2/
                s/a(.{79})q(.*\[FIELD_END\])/a\1K\2/
                s/a(.{79})v(.*\[FIELD_END\])/a\1F\2/
                s/a(.{79})p(.*\[FIELD_END\])/a\1B\2/
        s/a(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_2

:second_isis_awarrior_handler
    s/$/\[second_abomb_tacted\]/
    /second_abomb_timer_\]/ {
        b second_abomb_tsss_boom
    }
    #removing one each tact 
    s/(second_abomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_22

:second_abomb_tsss_boom
    s/$/\[second_abomb_tacted\]/
    /second_abomb_timer_/ {
        s/second_abomb_timer_/second_abomb_blast_111/
        b check_next_isis_22
    }
    /second_aplanting/ { s/2(.*\[FIELD_END\])/A\1/ }

    /second_abomb_blast_111/ {
        s/second_abomb_blast_111/second_abomb_blast_11/
        s/[1-4=.KFB]A(.*\[FIELD_END\])/*A\1/
        s/A[1-4=.KFB](.*\[FIELD_END\])/A*\1/
        s/[1-4=.KFB](.{79})A(.*\[FIELD_END\])/*\1A\2/
        s/A(.{79})[1-4=.KFB](.*\[FIELD_END\])/A\1*\2/

        s/kA(.*\[FIELD_END\])/qA\1/
        s/Ak(.*\[FIELD_END\])/Aq\1/
        s/k(.{79})A(.*\[FIELD_END\])/q\1A\2/
        s/A(.{79})k(.*\[FIELD_END\])/A\1q\2/

        s/fA(.*\[FIELD_END\])/vA\1/
        s/Af(.*\[FIELD_END\])/Av\1/
        s/f(.{79})A(.*\[FIELD_END\])/v\1A\2/
        s/A(.{79})f(.*\[FIELD_END\])/A\1v\2/

        s/bA(.*\[FIELD_END\])/pA\1/
        s/Ab(.*\[FIELD_END\])/Ap\1/
        s/b(.{79})A(.*\[FIELD_END\])/p\1A\2/
        s/A(.{79})b(.*\[FIELD_END\])/A\1p\2/
        b check_next_isis_22
    }
    /second_abomb_blast_11/ {
        s/second_abomb_blast_11/second_abomb_blast_1/
        s/[1-4=.KFB]([^#])A(.*\[FIELD_END\])/*\1A\2/
        s/A([^#])[1-4=.KFB](.*\[FIELD_END\])/A\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})A(.*\[FIELD_END\])/*\1A\2/
        s/A(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/A\1*\2/

        s/k([^#])A(.*\[FIELD_END\])/q\1A\2/
        s/A([^#])k(.*\[FIELD_END\])/A\1q\2/
        s/k(.{79}[^#].{79})A(.*\[FIELD_END\])/q\1A\2/
        s/A(.{79}[^#].{79})k(.*\[FIELD_END\])/A\1q\2/

        s/f([^#])A(.*\[FIELD_END\])/v\1A\2/
        s/A([^#])f(.*\[FIELD_END\])/A\1v\2/
        s/f(.{79}[^#].{79})A(.*\[FIELD_END\])/v\1A\2/
        s/A(.{79}[^#].{79})f(.*\[FIELD_END\])/A\1v\2/

        s/b([^#])A(.*\[FIELD_END\])/p\1A\2/
        s/A([^#])b(.*\[FIELD_END\])/A\1p\2/
        s/b(.{79}[^#].{79})A(.*\[FIELD_END\])/p\1A\2/
        s/A(.{79}[^#].{79})b(.*\[FIELD_END\])/A\1p\2/
        b check_next_isis_22
    }
    /second_abomb_blast_1/ {
        s/second_abomb_blast_1/second_abomb_blast_/
        /\[SECOND_BONUS:PYROMANIAC:BF\]/!b check_next_isis_22
        s/[1-4=.KFB]([^#]{2})A(.*\[FIELD_END\])/*\1A\2/
        s/A([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/A\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/*\1A\2/
        s/A(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/A\1*\2/

        s/k([^#]{2})A(.*\[FIELD_END\])/q\1A\2/
        s/A([^#]{2})k(.*\[FIELD_END\])/A\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/q\1A\2/
        s/A(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/A\1q\2/

        s/f([^#]{2})A(.*\[FIELD_END\])/v\1A\2/
        s/A([^#]{2})f(.*\[FIELD_END\])/A\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/v\1A\2/
        s/A(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/A\1v\2/

        s/b([^#]{2})A(.*\[FIELD_END\])/p\1A\2/
        s/A([^#]{2})b(.*\[FIELD_END\])/A\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/p\1A\2/
        s/A(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/A\1p\2/
        b check_next_isis_22
    }
    /second_abomb_blast_/ {
        s/\[status_second_abomb_blast_\]//
        s/\*([^#]{2})A(.*\[FIELD_END\])/.\1A\2/
        s/q([^#]{2})A(.*\[FIELD_END\])/K\1A\2/
        s/v([^#]{2})A(.*\[FIELD_END\])/F\1A\2/
        s/p([^#]{2})A(.*\[FIELD_END\])/B\1A\2/
            s/\*([^#])A(.*\[FIELD_END\])/.\1A\2/
            s/q([^#])A(.*\[FIELD_END\])/K\1A\2/
            s/v([^#])A(.*\[FIELD_END\])/F\1A\2/
            s/p([^#])A(.*\[FIELD_END\])/B\1A\2/
                s/\*A(.*\[FIELD_END\])/.A\1/
                s/qA(.*\[FIELD_END\])/KA\1/
                s/vA(.*\[FIELD_END\])/FA\1/
                s/pA(.*\[FIELD_END\])/BA\1/
        s/A([^#]{2})\*(.*\[FIELD_END\])/A\1.\2/
        s/A([^#]{2})q(.*\[FIELD_END\])/A\1K\2/
        s/A([^#]{2})v(.*\[FIELD_END\])/A\1F\2/
        s/A([^#]{2})p(.*\[FIELD_END\])/A\1B\2/
            s/A([^#])\*(.*\[FIELD_END\])/A\1.\2/
            s/A([^#])q(.*\[FIELD_END\])/A\1K\2/
            s/A([^#])v(.*\[FIELD_END\])/A\1F\2/
            s/A([^#])p(.*\[FIELD_END\])/A\1B\2/
                s/A\*(.*\[FIELD_END\])/A.\1/
                s/Aq(.*\[FIELD_END\])/AK\1/
                s/Av(.*\[FIELD_END\])/AF\1/
                s/Ap(.*\[FIELD_END\])/AB\1/
        s/\*(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/.\1A\2/
        s/q(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/K\1A\2/
        s/v(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/F\1A\2/
        s/p(.{79}[^#].{79}[^#].{79})A(.*\[FIELD_END\])/B\1A\2/
            s/\*(.{79}[^#].{79})A(.*\[FIELD_END\])/.\1A\2/
            s/q(.{79}[^#].{79})A(.*\[FIELD_END\])/K\1A\2/
            s/v(.{79}[^#].{79})A(.*\[FIELD_END\])/F\1A\2/
            s/p(.{79}[^#].{79})A(.*\[FIELD_END\])/B\1A\2/
                s/\*(.{79})A(.*\[FIELD_END\])/.\1A\2/
                s/q(.{79})A(.*\[FIELD_END\])/K\1A\2/
                s/v(.{79})A(.*\[FIELD_END\])/F\1A\2/
                s/p(.{79})A(.*\[FIELD_END\])/B\1A\2/
        s/A(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/A\1.\2/
        s/A(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/A\1K\2/
        s/A(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/A\1F\2/
        s/A(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/A\1B\2/
            s/A(.{79}[^#].{79})\*(.*\[FIELD_END\])/A\1.\2/
            s/A(.{79}[^#].{79})q(.*\[FIELD_END\])/A\1K\2/
            s/A(.{79}[^#].{79})v(.*\[FIELD_END\])/A\1F\2/
            s/A(.{79}[^#].{79})p(.*\[FIELD_END\])/A\1B\2/
                s/A(.{79})\*(.*\[FIELD_END\])/A\1.\2/
                s/A(.{79})q(.*\[FIELD_END\])/A\1K\2/
                s/A(.{79})v(.*\[FIELD_END\])/A\1F\2/
                s/A(.{79})p(.*\[FIELD_END\])/A\1B\2/
        s/A(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_22

:third_isis_warrior_handler
    s/$/\[third_bomb_tacted\]/
    /third_bomb_timer_\]/ {
        b third_bomb_tsss_boom
    }
    #removing one each tact 
    s/(third_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_3

:third_bomb_tsss_boom
    s/$/\[third_bomb_tacted\]/
    /third_bomb_timer_/ { 
        s/third_bomb_timer_/third_bomb_blast_111/
        b check_next_isis_3
    }
    /third_planting/ { s/3(.*\[FIELD_END\])/0\1/ }

    /third_bomb_blast_111/ {
        s/third_bomb_blast_111/third_bomb_blast_11/
        s/[1-4=.KFB]0(.*\[FIELD_END\])/*0\1/
        s/0[1-4=.KFB](.*\[FIELD_END\])/0*\1/
        s/[1-4=.KFB](.{79})0(.*\[FIELD_END\])/*\10\2/
        s/0(.{79})[1-4=.KFB](.*\[FIELD_END\])/0\1*\2/

        s/k0(.*\[FIELD_END\])/q0\1/
        s/0k(.*\[FIELD_END\])/0q\1/
        s/k(.{79})0(.*\[FIELD_END\])/q\10\2/
        s/0(.{79})k(.*\[FIELD_END\])/0\1q\2/

        s/f0(.*\[FIELD_END\])/v0\1/
        s/0f(.*\[FIELD_END\])/0v\1/
        s/f(.{79})0(.*\[FIELD_END\])/v\10\2/
        s/0(.{79})f(.*\[FIELD_END\])/0\1v\2/

        s/b0(.*\[FIELD_END\])/p0\1/
        s/0b(.*\[FIELD_END\])/0p\1/
        s/b(.{79})0(.*\[FIELD_END\])/p\10\2/
        s/0(.{79})b(.*\[FIELD_END\])/0\1p\2/
        b check_next_isis_3
    }
    /third_bomb_blast_11/ {
        s/third_bomb_blast_11/third_bomb_blast_1/
        s/[1-4=.KFB]([^#])0(.*\[FIELD_END\])/*\10\2/
        s/0([^#])[1-4=.KFB](.*\[FIELD_END\])/0\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})0(.*\[FIELD_END\])/*\10\2/
        s/0(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/0\1*\2/

        s/k([^#])0(.*\[FIELD_END\])/q\10\2/
        s/0([^#])k(.*\[FIELD_END\])/0\1q\2/
        s/k(.{79}[^#].{79})0(.*\[FIELD_END\])/q\10\2/
        s/0(.{79}[^#].{79})k(.*\[FIELD_END\])/0\1q\2/

        s/f([^#])0(.*\[FIELD_END\])/v\10\2/
        s/0([^#])f(.*\[FIELD_END\])/0\1v\2/
        s/f(.{79}[^#].{79})0(.*\[FIELD_END\])/v\10\2/
        s/0(.{79}[^#].{79})f(.*\[FIELD_END\])/0\1v\2/

        s/b([^#])0(.*\[FIELD_END\])/p\10\2/
        s/0([^#])b(.*\[FIELD_END\])/0\1p\2/
        s/b(.{79}[^#].{79})0(.*\[FIELD_END\])/p\10\2/
        s/0(.{79}[^#].{79})b(.*\[FIELD_END\])/0\1p\2/
        b check_next_isis_3
    }
    /third_bomb_blast_1/ {
        s/third_bomb_blast_1/third_bomb_blast_/
        /\[THIRD_BONUS:PYROMANIAC:BF\]/!b check_next_isis_3
        s/[1-4=.KFB]([^#]{2})0(.*\[FIELD_END\])/*\10\2/
        s/0([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/0\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/*\10\2/
        s/0(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/0\1*\2/

        s/k([^#]{2})0(.*\[FIELD_END\])/q\10\2/
        s/0([^#]{2})k(.*\[FIELD_END\])/0\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/q\10\2/
        s/0(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/0\1q\2/

        s/f([^#]{2})0(.*\[FIELD_END\])/v\10\2/
        s/0([^#]{2})f(.*\[FIELD_END\])/0\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/v\10\2/
        s/0(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/0\1v\2/

        s/b([^#]{2})0(.*\[FIELD_END\])/p\10\2/
        s/0([^#]{2})b(.*\[FIELD_END\])/0\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/p\10\2/
        s/0(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/0\1p\2/
        b check_next_isis_3
    }
    /third_bomb_blast_/ {
        s/\[status_third_bomb_blast_\]//
        s/\*([^#]{2})0(.*\[FIELD_END\])/.\10\2/
        s/q([^#]{2})0(.*\[FIELD_END\])/K\10\2/
        s/v([^#]{2})0(.*\[FIELD_END\])/F\10\2/
        s/p([^#]{2})0(.*\[FIELD_END\])/B\10\2/
            s/\*([^#])0(.*\[FIELD_END\])/.\10\2/
            s/q([^#])0(.*\[FIELD_END\])/K\10\2/
            s/v([^#])0(.*\[FIELD_END\])/F\10\2/
            s/p([^#])0(.*\[FIELD_END\])/B\10\2/
                s/\*0(.*\[FIELD_END\])/.0\1/
                s/q0(.*\[FIELD_END\])/K0\1/
                s/v0(.*\[FIELD_END\])/F0\1/
                s/p0(.*\[FIELD_END\])/B0\1/
        s/0([^#]{2})\*(.*\[FIELD_END\])/0\1.\2/
        s/0([^#]{2})q(.*\[FIELD_END\])/0\1K\2/
        s/0([^#]{2})v(.*\[FIELD_END\])/0\1F\2/
        s/0([^#]{2})p(.*\[FIELD_END\])/0\1B\2/
            s/0([^#])\*(.*\[FIELD_END\])/0\1.\2/
            s/0([^#])q(.*\[FIELD_END\])/0\1K\2/
            s/0([^#])v(.*\[FIELD_END\])/0\1F\2/
            s/0([^#])p(.*\[FIELD_END\])/0\1B\2/
                s/0\*(.*\[FIELD_END\])/0.\1/
                s/0q(.*\[FIELD_END\])/0K\1/
                s/0v(.*\[FIELD_END\])/0F\1/
                s/0p(.*\[FIELD_END\])/0B\1/
        s/\*(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/.\10\2/
        s/q(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/K\10\2/
        s/v(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/F\10\2/
        s/p(.{79}[^#].{79}[^#].{79})0(.*\[FIELD_END\])/B\10\2/
            s/\*(.{79}[^#].{79})0(.*\[FIELD_END\])/.\10\2/
            s/q(.{79}[^#].{79})0(.*\[FIELD_END\])/K\10\2/
            s/v(.{79}[^#].{79})0(.*\[FIELD_END\])/F\10\2/
            s/p(.{79}[^#].{79})0(.*\[FIELD_END\])/B\10\2/
                s/\*(.{79})0(.*\[FIELD_END\])/.\10\2/
                s/q(.{79})0(.*\[FIELD_END\])/K\10\2/
                s/v(.{79})0(.*\[FIELD_END\])/F\10\2/
                s/p(.{79})0(.*\[FIELD_END\])/B\10\2/
        s/0(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/0\1.\2/
        s/0(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/0\1K\2/
        s/0(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/0\1F\2/
        s/0(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/0\1B\2/
            s/0(.{79}[^#].{79})\*(.*\[FIELD_END\])/0\1.\2/
            s/0(.{79}[^#].{79})q(.*\[FIELD_END\])/0\1K\2/
            s/0(.{79}[^#].{79})v(.*\[FIELD_END\])/0\1F\2/
            s/0(.{79}[^#].{79})p(.*\[FIELD_END\])/0\1B\2/
                s/0(.{79})\*(.*\[FIELD_END\])/0\1.\2/
                s/0(.{79})q(.*\[FIELD_END\])/0\1K\2/
                s/0(.{79})v(.*\[FIELD_END\])/0\1F\2/
                s/0(.{79})p(.*\[FIELD_END\])/0\1B\2/
        s/0(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_3

:third_isis_awarrior_handler
    s/$/\[third_abomb_tacted\]/
    /third_abomb_timer_\]/ {
        b third_abomb_tsss_boom
    }
    #removing one each tact 
    s/(third_abomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_33

:third_abomb_tsss_boom
    s/$/\[third_abomb_tacted\]/
    /third_abomb_timer_/ { 
        s/third_abomb_timer_/third_abomb_blast_111/
        b check_next_isis_33
    }
    /third_aplanting/ { s/3(.*\[FIELD_END\])/y\1/ }

    /third_abomb_blast_111/ {
        s/third_abomb_blast_111/third_abomb_blast_11/
        s/[1-4=.KFB]y(.*\[FIELD_END\])/*y\1/
        s/y[1-4=.KFB](.*\[FIELD_END\])/y*\1/
        s/[1-4=.KFB](.{79})y(.*\[FIELD_END\])/*\1y\2/
        s/y(.{79})[1-4=.KFB](.*\[FIELD_END\])/y\1*\2/

        s/ky(.*\[FIELD_END\])/qy\1/
        s/yk(.*\[FIELD_END\])/yq\1/
        s/k(.{79})y(.*\[FIELD_END\])/q\1y\2/
        s/y(.{79})k(.*\[FIELD_END\])/y\1q\2/

        s/fy(.*\[FIELD_END\])/vy\1/
        s/yf(.*\[FIELD_END\])/yv\1/
        s/f(.{79})y(.*\[FIELD_END\])/v\1y\2/
        s/y(.{79})f(.*\[FIELD_END\])/y\1v\2/

        s/by(.*\[FIELD_END\])/py\1/
        s/yb(.*\[FIELD_END\])/yp\1/
        s/b(.{79})y(.*\[FIELD_END\])/p\1y\2/
        s/y(.{79})b(.*\[FIELD_END\])/y\1p\2/
        b check_next_isis_33
    }
    /third_abomb_blast_11/ {
        s/third_abomb_blast_11/third_abomb_blast_1/
        s/[1-4=.KFB]([^#])y(.*\[FIELD_END\])/*\1y\2/
        s/y([^#])[1-4=.KFB](.*\[FIELD_END\])/y\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})y(.*\[FIELD_END\])/*\1y\2/
        s/y(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/y\1*\2/

        s/k([^#])y(.*\[FIELD_END\])/q\1y\2/
        s/y([^#])k(.*\[FIELD_END\])/y\1q\2/
        s/k(.{79}[^#].{79})y(.*\[FIELD_END\])/q\1y\2/
        s/y(.{79}[^#].{79})k(.*\[FIELD_END\])/y\1q\2/

        s/f([^#])y(.*\[FIELD_END\])/v\1y\2/
        s/y([^#])f(.*\[FIELD_END\])/y\1v\2/
        s/f(.{79}[^#].{79})y(.*\[FIELD_END\])/v\1y\2/
        s/y(.{79}[^#].{79})f(.*\[FIELD_END\])/y\1v\2/

        s/b([^#])y(.*\[FIELD_END\])/p\1y\2/
        s/y([^#])b(.*\[FIELD_END\])/y\1p\2/
        s/b(.{79}[^#].{79})y(.*\[FIELD_END\])/p\1y\2/
        s/y(.{79}[^#].{79})b(.*\[FIELD_END\])/y\1p\2/
        b check_next_isis_33
    }
    /third_abomb_blast_1/ {
        s/third_abomb_blast_1/third_abomb_blast_/
        /\[THIRD_BONUS:PYROMANIAC:BF\]/!b check_next_isis_33
        s/[1-4=.KFB]([^#]{2})y(.*\[FIELD_END\])/*\1y\2/
        s/y([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/y\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/*\1y\2/
        s/y(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/y\1*\2/

        s/k([^#]{2})y(.*\[FIELD_END\])/q\1y\2/
        s/y([^#]{2})k(.*\[FIELD_END\])/y\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/q\1y\2/
        s/y(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/y\1q\2/

        s/f([^#]{2})y(.*\[FIELD_END\])/v\1y\2/
        s/y([^#]{2})f(.*\[FIELD_END\])/y\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/v\1y\2/
        s/y(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/y\1v\2/

        s/b([^#]{2})y(.*\[FIELD_END\])/p\1y\2/
        s/y([^#]{2})b(.*\[FIELD_END\])/y\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/p\1y\2/
        s/y(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/y\1p\2/
        b check_next_isis_33
    }
    /third_abomb_blast_/ {
        s/\[status_third_abomb_blast_\]//
        s/\*([^#]{2})y(.*\[FIELD_END\])/.\1y\2/
        s/q([^#]{2})y(.*\[FIELD_END\])/K\1y\2/
        s/v([^#]{2})y(.*\[FIELD_END\])/F\1y\2/
        s/p([^#]{2})y(.*\[FIELD_END\])/B\1y\2/
            s/\*([^#])y(.*\[FIELD_END\])/.\1y\2/
            s/q([^#])y(.*\[FIELD_END\])/K\1y\2/
            s/v([^#])y(.*\[FIELD_END\])/F\1y\2/
            s/p([^#])y(.*\[FIELD_END\])/B\1y\2/
                s/\*y(.*\[FIELD_END\])/.y\1/
                s/qy(.*\[FIELD_END\])/Ky\1/
                s/vy(.*\[FIELD_END\])/Fy\1/
                s/py(.*\[FIELD_END\])/By\1/
        s/y([^#]{2})\*(.*\[FIELD_END\])/y\1.\2/
        s/y([^#]{2})q(.*\[FIELD_END\])/y\1K\2/
        s/y([^#]{2})v(.*\[FIELD_END\])/y\1F\2/
        s/y([^#]{2})p(.*\[FIELD_END\])/y\1B\2/
            s/y([^#])\*(.*\[FIELD_END\])/y\1.\2/
            s/y([^#])q(.*\[FIELD_END\])/y\1K\2/
            s/y([^#])v(.*\[FIELD_END\])/y\1F\2/
            s/y([^#])p(.*\[FIELD_END\])/y\1B\2/
                s/y\*(.*\[FIELD_END\])/y.\1/
                s/yq(.*\[FIELD_END\])/yK\1/
                s/yv(.*\[FIELD_END\])/yF\1/
                s/yp(.*\[FIELD_END\])/yB\1/
        s/\*(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/.\1y\2/
        s/q(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/K\1y\2/
        s/v(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/F\1y\2/
        s/p(.{79}[^#].{79}[^#].{79})y(.*\[FIELD_END\])/B\1y\2/
            s/\*(.{79}[^#].{79})y(.*\[FIELD_END\])/.\1y\2/
            s/q(.{79}[^#].{79})y(.*\[FIELD_END\])/K\1y\2/
            s/v(.{79}[^#].{79})y(.*\[FIELD_END\])/F\1y\2/
            s/p(.{79}[^#].{79})y(.*\[FIELD_END\])/B\1y\2/
                s/\*(.{79})y(.*\[FIELD_END\])/.\1y\2/
                s/q(.{79})y(.*\[FIELD_END\])/K\1y\2/
                s/v(.{79})y(.*\[FIELD_END\])/F\1y\2/
                s/p(.{79})y(.*\[FIELD_END\])/B\1y\2/
        s/y(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/y\1.\2/
        s/y(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/y\1K\2/
        s/y(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/y\1F\2/
        s/y(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/y\1B\2/
            s/y(.{79}[^#].{79})\*(.*\[FIELD_END\])/y\1.\2/
            s/y(.{79}[^#].{79})q(.*\[FIELD_END\])/y\1K\2/
            s/y(.{79}[^#].{79})v(.*\[FIELD_END\])/y\1F\2/
            s/y(.{79}[^#].{79})p(.*\[FIELD_END\])/y\1B\2/
                s/y(.{79})\*(.*\[FIELD_END\])/y\1.\2/
                s/y(.{79})q(.*\[FIELD_END\])/y\1K\2/
                s/y(.{79})v(.*\[FIELD_END\])/y\1F\2/
                s/y(.{79})p(.*\[FIELD_END\])/y\1B\2/
        s/y(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_33

:fourth_isis_warrior_handler
    s/$/\[fourth_bomb_tacted\]/
    /fourth_bomb_timer_\]/ {
        b fourth_bomb_tsss_boom
    }
    #removing one each tact 
    s/(fourth_bomb_timer_1*)1\]/\1\]/ 
    b check_next_isis_4

:fourth_bomb_tsss_boom
    s/$/\[fourth_bomb_tacted\]/
    /fourth_bomb_timer_/ {
        s/fourth_bomb_timer_/fourth_bomb_blast_111/
        b check_next_isis_4
    }
    /fourth_planting/ { s/4(.*\[FIELD_END\])/o\1/ }

    /fourth_bomb_blast_111/ {
        s/fourth_bomb_blast_111/fourth_bomb_blast_11/
        s/[1-4=.KFB]o(.*\[FIELD_END\])/*o\1/
        s/o[1-4=.KFB](.*\[FIELD_END\])/o*\1/
        s/[1-4=.KFB](.{79})o(.*\[FIELD_END\])/*\1o\2/
        s/o(.{79})[1-4=.KFB](.*\[FIELD_END\])/o\1*\2/

        s/ko(.*\[FIELD_END\])/qo\1/
        s/ok(.*\[FIELD_END\])/oq\1/
        s/k(.{79})o(.*\[FIELD_END\])/q\1o\2/
        s/o(.{79})k(.*\[FIELD_END\])/o\1q\2/

        s/fo(.*\[FIELD_END\])/vo\1/
        s/of(.*\[FIELD_END\])/ov\1/
        s/f(.{79})o(.*\[FIELD_END\])/v\1o\2/
        s/o(.{79})f(.*\[FIELD_END\])/o\1v\2/

        s/bo(.*\[FIELD_END\])/po\1/
        s/ob(.*\[FIELD_END\])/op\1/
        s/b(.{79})o(.*\[FIELD_END\])/p\1o\2/
        s/o(.{79})b(.*\[FIELD_END\])/o\1p\2/
        b check_next_isis_4
    }
    /fourth_bomb_blast_11/ {
        s/fourth_bomb_blast_11/fourth_bomb_blast_1/
        s/[1-4=.KFB]([^#])o(.*\[FIELD_END\])/*\1o\2/
        s/o([^#])[1-4=.KFB](.*\[FIELD_END\])/o\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})o(.*\[FIELD_END\])/*\1o\2/
        s/o(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/o\1*\2/

        s/k([^#])o(.*\[FIELD_END\])/q\1o\2/
        s/o([^#])k(.*\[FIELD_END\])/o\1q\2/
        s/k(.{79}[^#].{79})o(.*\[FIELD_END\])/q\1o\2/
        s/o(.{79}[^#].{79})k(.*\[FIELD_END\])/o\1q\2/

        s/f([^#])o(.*\[FIELD_END\])/v\1o\2/
        s/o([^#])f(.*\[FIELD_END\])/o\1v\2/
        s/f(.{79}[^#].{79})o(.*\[FIELD_END\])/v\1o\2/
        s/o(.{79}[^#].{79})f(.*\[FIELD_END\])/o\1v\2/

        s/b([^#])o(.*\[FIELD_END\])/p\1o\2/
        s/o([^#])b(.*\[FIELD_END\])/o\1p\2/
        s/b(.{79}[^#].{79})o(.*\[FIELD_END\])/p\1o\2/
        s/o(.{79}[^#].{79})b(.*\[FIELD_END\])/o\1p\2/
        b check_next_isis_4
    }
    /fourth_bomb_blast_1/ {
        s/fourth_bomb_blast_1/fourth_bomb_blast_/
        /\[FOURTH_BONUS:PYROMANIAC:BF\]/!b check_next_isis_4
        s/[1-4=.KFB]([^#]{2})o(.*\[FIELD_END\])/*\1o\2/
        s/o([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/o\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/*\1o\2/
        s/o(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/o\1*\2/

        s/k([^#]{2})o(.*\[FIELD_END\])/q\1o\2/
        s/o([^#]{2})k(.*\[FIELD_END\])/o\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/q\1o\2/
        s/o(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/o\1q\2/

        s/f([^#]{2})o(.*\[FIELD_END\])/v\1o\2/
        s/o([^#]{2})f(.*\[FIELD_END\])/o\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/v\1o\2/
        s/o(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/o\1v\2/

        s/b([^#]{2})o(.*\[FIELD_END\])/p\1o\2/
        s/o([^#]{2})b(.*\[FIELD_END\])/o\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/p\1o\2/
        s/o(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/o\1p\2/
        b check_next_isis_4
    }
    /fourth_bomb_blast_/ {
        s/\[status_fourth_bomb_blast_\]//
        s/\*([^#]{2})o(.*\[FIELD_END\])/.\1o\2/
        s/q([^#]{2})o(.*\[FIELD_END\])/K\1o\2/
        s/v([^#]{2})o(.*\[FIELD_END\])/F\1o\2/
        s/p([^#]{2})o(.*\[FIELD_END\])/B\1o\2/
            s/\*([^#])o(.*\[FIELD_END\])/.\1o\2/
            s/q([^#])o(.*\[FIELD_END\])/K\1o\2/
            s/v([^#])o(.*\[FIELD_END\])/F\1o\2/
            s/p([^#])o(.*\[FIELD_END\])/B\1o\2/
                s/\*o(.*\[FIELD_END\])/.o\1/
                s/qo(.*\[FIELD_END\])/Ko\1/
                s/vo(.*\[FIELD_END\])/Fo\1/
                s/po(.*\[FIELD_END\])/Bo\1/
        s/o([^#]{2})\*(.*\[FIELD_END\])/o\1.\2/
        s/o([^#]{2})q(.*\[FIELD_END\])/o\1K\2/
        s/o([^#]{2})v(.*\[FIELD_END\])/o\1F\2/
        s/o([^#]{2})p(.*\[FIELD_END\])/o\1B\2/
            s/o([^#])\*(.*\[FIELD_END\])/o\1.\2/
            s/o([^#])q(.*\[FIELD_END\])/o\1K\2/
            s/o([^#])v(.*\[FIELD_END\])/o\1F\2/
            s/o([^#])p(.*\[FIELD_END\])/o\1B\2/
                s/o\*(.*\[FIELD_END\])/o.\1/
                s/oq(.*\[FIELD_END\])/oK\1/
                s/ov(.*\[FIELD_END\])/oF\1/
                s/op(.*\[FIELD_END\])/oB\1/
        s/\*(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/.\1o\2/
        s/q(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/K\1o\2/
        s/v(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/F\1o\2/
        s/p(.{79}[^#].{79}[^#].{79})o(.*\[FIELD_END\])/B\1o\2/
            s/\*(.{79}[^#].{79})o(.*\[FIELD_END\])/.\1o\2/
            s/q(.{79}[^#].{79})o(.*\[FIELD_END\])/K\1o\2/
            s/v(.{79}[^#].{79})o(.*\[FIELD_END\])/F\1o\2/
            s/p(.{79}[^#].{79})o(.*\[FIELD_END\])/B\1o\2/
                s/\*(.{79})o(.*\[FIELD_END\])/.\1o\2/
                s/q(.{79})o(.*\[FIELD_END\])/K\1o\2/
                s/v(.{79})o(.*\[FIELD_END\])/F\1o\2/
                s/p(.{79})o(.*\[FIELD_END\])/B\1o\2/
        s/o(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/o\1.\2/
        s/o(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/o\1K\2/
        s/o(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/o\1F\2/
        s/o(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/o\1B\2/
            s/o(.{79}[^#].{79})\*(.*\[FIELD_END\])/o\1.\2/
            s/o(.{79}[^#].{79})q(.*\[FIELD_END\])/o\1K\2/
            s/o(.{79}[^#].{79})v(.*\[FIELD_END\])/o\1F\2/
            s/o(.{79}[^#].{79})p(.*\[FIELD_END\])/o\1B\2/
                s/o(.{79})\*(.*\[FIELD_END\])/o\1.\2/
                s/o(.{79})q(.*\[FIELD_END\])/o\1K\2/
                s/o(.{79})v(.*\[FIELD_END\])/o\1F\2/
                s/o(.{79})p(.*\[FIELD_END\])/o\1B\2/
        s/o(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_4

:fourth_isis_awarrior_handler
    s/$/\[fourth_abomb_tacted\]/
    /fourth_abomb_timer_\]/ {
        b fourth_abomb_tsss_boom
    }
    #removing one each tact 
    s/(fourth_abomb_timer_1*)1\]/\1\]/ 
    b print_flashback

:fourth_abomb_tsss_boom
    s/$/\[fourth_abomb_tacted\]/
    /fourth_abomb_timer_/ {
        s/fourth_abomb_timer_/fourth_abomb_blast_111/
        b check_next_isis_44
    }
    /fourth_aplanting/ { s/4(.*\[FIELD_END\])/O\1/ }

    /fourth_abomb_blast_111/ {
        s/fourth_abomb_blast_111/fourth_abomb_blast_11/
        s/[1-4=.KFB]O(.*\[FIELD_END\])/*O\1/
        s/O[1-4=.KFB](.*\[FIELD_END\])/O*\1/
        s/[1-4=.KFB](.{79})O(.*\[FIELD_END\])/*\1O\2/
        s/O(.{79})[1-4=.KFB](.*\[FIELD_END\])/O\1*\2/

        s/kO(.*\[FIELD_END\])/qO\1/
        s/Ok(.*\[FIELD_END\])/Oq\1/
        s/k(.{79})O(.*\[FIELD_END\])/q\1O\2/
        s/O(.{79})k(.*\[FIELD_END\])/O\1q\2/

        s/fO(.*\[FIELD_END\])/vO\1/
        s/Of(.*\[FIELD_END\])/Ov\1/
        s/f(.{79})O(.*\[FIELD_END\])/v\1O\2/
        s/O(.{79})f(.*\[FIELD_END\])/O\1v\2/

        s/bO(.*\[FIELD_END\])/pO\1/
        s/Ob(.*\[FIELD_END\])/Op\1/
        s/b(.{79})O(.*\[FIELD_END\])/p\1O\2/
        s/O(.{79})b(.*\[FIELD_END\])/O\1p\2/
        b check_next_isis_44
    }
    /fourth_abomb_blast_11/ {
        s/fourth_abomb_blast_11/fourth_abomb_blast_1/
        s/[1-4=.KFB]([^#])O(.*\[FIELD_END\])/*\1O\2/
        s/O([^#])[1-4=.KFB](.*\[FIELD_END\])/O\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79})O(.*\[FIELD_END\])/*\1O\2/
        s/O(.{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/O\1*\2/

        s/k([^#])O(.*\[FIELD_END\])/q\1O\2/
        s/O([^#])k(.*\[FIELD_END\])/O\1q\2/
        s/k(.{79}[^#].{79})O(.*\[FIELD_END\])/q\1O\2/
        s/O(.{79}[^#].{79})k(.*\[FIELD_END\])/O\1q\2/

        s/f([^#])O(.*\[FIELD_END\])/v\1O\2/
        s/O([^#])f(.*\[FIELD_END\])/O\1v\2/
        s/f(.{79}[^#].{79})O(.*\[FIELD_END\])/v\1O\2/
        s/O(.{79}[^#].{79})f(.*\[FIELD_END\])/O\1v\2/

        s/b([^#])O(.*\[FIELD_END\])/p\1O\2/
        s/O([^#])b(.*\[FIELD_END\])/O\1p\2/
        s/b(.{79}[^#].{79})O(.*\[FIELD_END\])/p\1O\2/
        s/O(.{79}[^#].{79})b(.*\[FIELD_END\])/O\1p\2/
        b check_next_isis_44
    }
    /fourth_abomb_blast_1/ {
        s/fourth_abomb_blast_1/fourth_abomb_blast_/
        /\[FOURTH_BONUS:PYROMANIAC:BF\]/!b check_next_isis_44
        s/[1-4=.KFB]([^#]{2})O(.*\[FIELD_END\])/*\1O\2/
        s/O([^#]{2})[1-4=.KFB](.*\[FIELD_END\])/O\1*\2/
        s/[1-4=.KFB](.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/*\1O\2/
        s/O(.{79}[^#].{79}[^#].{79})[1-4=.KFB](.*\[FIELD_END\])/O\1*\2/

        s/k([^#]{2})O(.*\[FIELD_END\])/q\1O\2/
        s/O([^#]{2})k(.*\[FIELD_END\])/O\1q\2/
        s/k(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/q\1O\2/
        s/O(.{79}[^#].{79}[^#].{79})k(.*\[FIELD_END\])/O\1q\2/

        s/f([^#]{2})O(.*\[FIELD_END\])/v\1O\2/
        s/O([^#]{2})f(.*\[FIELD_END\])/O\1v\2/
        s/f(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/v\1O\2/
        s/O(.{79}[^#].{79}[^#].{79})f(.*\[FIELD_END\])/O\1v\2/

        s/b([^#]{2})O(.*\[FIELD_END\])/p\1O\2/
        s/O([^#]{2})b(.*\[FIELD_END\])/O\1p\2/
        s/b(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/p\1O\2/
        s/O(.{79}[^#].{79}[^#].{79})b(.*\[FIELD_END\])/O\1p\2/
        b check_next_isis_44
    }
    /fourth_abomb_blast_/ {
        s/\[status_fourth_abomb_blast_\]//
        s/\*([^#]{2})O(.*\[FIELD_END\])/.\1O\2/
        s/q([^#]{2})O(.*\[FIELD_END\])/K\1O\2/
        s/v([^#]{2})O(.*\[FIELD_END\])/F\1O\2/
        s/p([^#]{2})O(.*\[FIELD_END\])/B\1O\2/
            s/\*([^#])O(.*\[FIELD_END\])/.\1O\2/
            s/q([^#])O(.*\[FIELD_END\])/K\1O\2/
            s/v([^#])O(.*\[FIELD_END\])/F\1O\2/
            s/p([^#])O(.*\[FIELD_END\])/B\1O\2/
                s/\*O(.*\[FIELD_END\])/.O\1/
                s/qO(.*\[FIELD_END\])/KO\1/
                s/vO(.*\[FIELD_END\])/FO\1/
                s/pO(.*\[FIELD_END\])/BO\1/
        s/O([^#]{2})\*(.*\[FIELD_END\])/O\1.\2/
        s/O([^#]{2})q(.*\[FIELD_END\])/O\1K\2/
        s/O([^#]{2})v(.*\[FIELD_END\])/O\1F\2/
        s/O([^#]{2})p(.*\[FIELD_END\])/O\1B\2/
            s/O([^#])\*(.*\[FIELD_END\])/O\1.\2/
            s/O([^#])q(.*\[FIELD_END\])/O\1K\2/
            s/O([^#])v(.*\[FIELD_END\])/O\1F\2/
            s/O([^#])p(.*\[FIELD_END\])/O\1B\2/
                s/O\*(.*\[FIELD_END\])/O.\1/
                s/Oq(.*\[FIELD_END\])/OK\1/
                s/Ov(.*\[FIELD_END\])/OF\1/
                s/Op(.*\[FIELD_END\])/OB\1/
        s/\*(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/.\1O\2/
        s/q(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/K\1O\2/
        s/v(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/F\1O\2/
        s/p(.{79}[^#].{79}[^#].{79})O(.*\[FIELD_END\])/B\1O\2/
            s/\*(.{79}[^#].{79})O(.*\[FIELD_END\])/.\1O\2/
            s/q(.{79}[^#].{79})O(.*\[FIELD_END\])/K\1O\2/
            s/v(.{79}[^#].{79})O(.*\[FIELD_END\])/F\1O\2/
            s/p(.{79}[^#].{79})O(.*\[FIELD_END\])/B\1O\2/
                s/\*(.{79})O(.*\[FIELD_END\])/.\1O\2/
                s/q(.{79})O(.*\[FIELD_END\])/K\1O\2/
                s/v(.{79})O(.*\[FIELD_END\])/F\1O\2/
                s/p(.{79})O(.*\[FIELD_END\])/B\1O\2/
        s/O(.{79}[^#].{79}[^#].{79})\*(.*\[FIELD_END\])/O\1.\2/
        s/O(.{79}[^#].{79}[^#].{79})q(.*\[FIELD_END\])/O\1K\2/
        s/O(.{79}[^#].{79}[^#].{79})v(.*\[FIELD_END\])/O\1F\2/
        s/O(.{79}[^#].{79}[^#].{79})p(.*\[FIELD_END\])/O\1B\2/
            s/O(.{79}[^#].{79})\*(.*\[FIELD_END\])/O\1.\2/
            s/O(.{79}[^#].{79})q(.*\[FIELD_END\])/O\1K\2/
            s/O(.{79}[^#].{79})v(.*\[FIELD_END\])/O\1F\2/
            s/O(.{79}[^#].{79})p(.*\[FIELD_END\])/O\1B\2/
                s/O(.{79})\*(.*\[FIELD_END\])/O\1.\2/
                s/O(.{79})q(.*\[FIELD_END\])/O\1K\2/
                s/O(.{79})v(.*\[FIELD_END\])/O\1F\2/
                s/O(.{79})p(.*\[FIELD_END\])/O\1B\2/
        s/O(.*\[FIELD_END\])/.\1/
    }
    b check_next_isis_44

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
    /[@a0oxAyO*qvp](.{79}([.KFB].{79}([KFB].{79})?)?)2.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /[.KFB].{79}\.2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]2.{78}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2[.KFB].{79}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}2[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB][.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /2.{79}[.KFB]/   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /[.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\[ai_2_taking_cover/! {
        s/(([@a0oxAyO])(.{79}([.KFB].{79}([.KFB].{79})?)?)2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2(.{79}([.KFB].{79}([.KFB].{79})?)?)[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /[.KFB].{79}[.KFB]2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]2.{78}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2[.KFB].{79}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}2[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB][.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /[.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\[ai_2_taking_cover/! {
        s/(2(.{79}([.KFB].{79}([.KFB].{79})?)?)([@a0oxAyO]).*)$/\1\[ai_2_taking_cover_\5\]/
      }
      b ai_2_goal_handler
    }
    
    /[@a0oxAyO*qvp][.KFB]?[.KFB]?[.KFB]?2.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /[.KFB].{79}[.KFB]2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]2.{78}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2[.KFB].{79}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}2[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /2[.KFB][.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /2.{79}[.KFB]/   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /[.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\[ai_2_taking_cover/! { 
        s/(([@a0oxAyO])[.KFB]?[.KFB]?[.KFB]?2.*)$/\1\[ai_2_taking_cover_\2\]/
      }
      b ai_2_goal_handler
    }

    /2[.KFB]?[.KFB]?[.KFB]?[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_2_goal_line_(up|down)\]//g
      s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_2_goal\]/
      /[.KFB].{79}[.KFB]2/ { s/(\[ai_2_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]2.{78}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_left_down\]/  }
      /2[.KFB].{79}[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}2[.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}2/ { s/(\[ai_2_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}2/ { s/(\[ai_2_goal)\]/\1_slide_up_right\]/   }
      /2.{78}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_left\]/  }
      /2.{79}[.KFB][.KFB]/ { s/(\[ai_2_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /[.KFB].{79}2/   { s/(\[ai_2_goal)\]/\1_line_up\]/          }
      /2.{79}[.KFB]/   { s/(\[ai_2_goal)\]/\1_line_down\]/        }
      /[.KFB]2/      { s/(\[ai_2_goal)\]/\1_shift_left\]/       }
      /2[.KFB]/      { s/(\[ai_2_goal)\]/\1_shift_right\]/      }
      /\[ai_2_taking_cover/! {
        s/(2[.KFB]?[.KFB]?[.KFB]?([@a0oxAyO]).*)$/\1[ai_2_taking_cover_\2]/
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
                s/$/[ai_2_goal_line_down]/
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
      /[12]([.KFB]?|.{79}|.{79}[.KFB].{79})[21].*\[FIELD_END\]/ {
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
      /[32]([.KFB]?|.{79}|.{79}[.KFB].{79})[23].*\[FIELD_END\]/ {
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
      /[24]([.KFB]?|.{79}|.{79}[.KFB].{79})[24].*\[FIELD_END\]/ {
          s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
    }
  }
:ai_2_goal_handler
    /\[ai_2_goal_plant_bomb\]/! {
      /[=kfb].{79}2.*\[FIELD_END\].*\[ai_2_goal_line_up\]/ {
          s/\[ai_2_goal_line_up\]//
          s/$/[ai_2_goal_plant_bomb]/
      } 
      /[=kfb]2.*\[FIELD_END\].*\[ai_2_goal_shift_left\]/ {
          s/\[ai_2_goal_shift_left\]//
          s/$/[ai_2_goal_plant_bomb]/
      } 
      /2.{79}[=kfb].*\[FIELD_END\].*\[ai_2_goal_line_down\]/ {
          s/\[ai_2_goal_line_down\]//
          s/$/[ai_2_goal_plant_bomb]/
      }
      /2[=kfb].*\[FIELD_END\].*\[ai_2_goal_shift_right\]/ {
          s/\[ai_2_goal_shift_right\]//
          s/$/[ai_2_goal_plant_bomb]/
      }
    }
#GOAL_HANDLER    
    /\[ai_2_cmd_query/! {
        /\[ai_2_goal_plant_bomb\]/ {
            s/\[ai_2_goal_plant_bomb\]//
            s/\[ai_2_goal_(line|shift)_(up|down|right|left)\]//g
            s/\[ai_2_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/$/\[ai_2_cmd_query_!plant\]/
            #go_away_way
            /[.KFB].{79}[.KFB]2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /[.KFB]2.{78}[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /2[.KFB].{79}[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /[.KFB].{78}2[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /2.{78}[.KFB][.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /2.{79}[.KFB][.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /[.KFB][.KFB].{79}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /[.KFB][.KFB].{78}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /[.KFB][.KFB][.KFB]2/    { s/(\[ai_2_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /2[.KFB][.KFB][.KFB]/    { s/(\[ai_2_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /2.{79}[.KFB].{79}[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down_!down\]/    }
            /[.KFB].{79}[.KFB].{79}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up_!up\]/      }
            /2.{79}[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!down\]/    }
            /[.KFB].{79}2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!up\]/      }
            /2[.KFB]/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!right\]/    }
            /[.KFB]2/ { s/(\[ai_2_cmd_query_!plant)\]/\1_!left\]/      }
        }
        /\[ai_2_goal_line_up\]/ {
            /[.KFB].{79}2/    { s/$/[ai_2_cmd_query_!up]/;            b a2q; }
            /#[.KFB].{78}2[.KFB]/ { s/$/[ai_2_cmd_query_!right_!up]/;     b a2q; }
            /[.KFB]#.{78}[.KFB]2/ { s/$/[ai_2_cmd_query_!left_!up]/;      b a2q; }
            /[.KFB]{2}2/         { s/$/[ai_2_cmd_query_!left_!left\]/;         b a2q; }
            /2[.KFB]{2}/         { s/$/[ai_2_cmd_query_!right_!right\]/;        b a2q; }
            /[.KFB]2/         { s/$/[ai_2_cmd_query_!left\]/;         b a2q; }
            /2[.KFB]/         { s/$/[ai_2_cmd_query_!right\]/;        b a2q; }
        }
        /\[ai_2_goal_line_down\]/ {
            /2.{79}[.KFB]/    { s/$/[ai_2_cmd_query_!down]/;          b a2q; }
            /2[.KFB].{78}#[.KFB]/ { s/$/[ai_2_cmd_query_!right_!down]/;   b a2q; }
            /[.KFB]2.{78}[.KFB]#/ { s/$/[ai_2_cmd_query_!left_!down]/;    b a2q; }
            /[.KFB]{2}2/         { s/$/[ai_2_cmd_query_!left_!left\]/;         b a2q; }
            /2[.KFB]{2}/         { s/$/[ai_2_cmd_query_!right_!right\]/;        b a2q; }
            /[.KFB]2/         { s/$/[ai_2_cmd_query_!left\]/;         b a2q; }
            /2[.KFB]/         { s/$/[ai_2_cmd_query_!right\]/;        b a2q; }
        }
        /\[ai_2_goal_shift_right\]/ {
            /2[.KFB]/         { s/$/[ai_2_cmd_query_!right]/;         b a2q; }
            /[.KFB][.KFB].{78}2#/ { s/$/[ai_2_cmd_query_!up_!right]/;     b a2q; }
            /2#.{78}[.KFB][.KFB]/ { s/$/[ai_2_cmd_query_!down_!right]/;   b a2q; }
        }
        /\[ai_2_goal_shift_left\]/ {
            /[.KFB]2/           { s/$/[ai_2_cmd_query_!left]/;        b a2q; }
            /[.KFB][.KFB](.{78})#2/ { s/$/[ai_2_cmd_query_!up_!left]/;    b a2q; }
            /#2(.{78})[.KFB][.KFB]/ { s/$/[ai_2_cmd_query_!down_!left]/;  b a2q; }
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
    /[@a0oxAyO*qvp](.{79}([.KFB].{79}([.KFB].{79})?)?)3.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /[.KFB].{79}[.KFB]3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]3.{78}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3[.KFB].{79}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}3[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3[.KFB][.KFB]/      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /3.{79}[.KFB]/   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /[.KFB]3/        { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3[.KFB]/        { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\[ai_3_taking_cover/! {
        s/(([@a0oxAyO])(.{79}([.KFB].{79}([.KFB].{79})?)?)3.*)$/\1\[ai_3_taking_cover_\2\]/
      }
      b ai_3_goal_handler
    }

    /3(.{79}([.KFB].{79}([.KFB].{79})?)?)[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /[.KFB].{79}[.KFB]3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]3.{78}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3[.KFB].{79}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}3[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3[.KFB][.KFB]/      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /\[ai_3_taking_cover/! {
        s/(3(.{79}([.KFB].{79}([.KFB].{79})?)?)([@a0oxAyO]).*)$/\1\[ai_3_taking_cover_\5\]/
      }
      b ai_3_goal_handler
    }
    
    /[@a0oxAyO*qvp][.KFB]?[.KFB]?[.KFB]?3.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /[.KFB].{79}[.KFB]3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]3.{78}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3[.KFB].{79}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}3[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /3[.KFB][.KFB]/      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /3.{79}[.KFB]/   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /[.KFB]3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3[.KFB]/      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\[ai_3_taking_cover/! { 
        s/(([@a0oxAyO])[.KFB]?[.KFB]?[.KFB]?3.*)$/\1\[ai_3_taking_cover_\2\]/
      }
      b ai_3_goal_handler
    }

    /3[.KFB]?[.KFB]?[.KFB]?[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_3_goal_line_(up|down)\]//g
      s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_3_goal\]/
      /[.KFB].{79}[.KFB]3/ { s/(\[ai_3_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]3.{78}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_left_down\]/  }
      /3[.KFB].{79}[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}3[.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}3/ { s/(\[ai_3_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}3/ { s/(\[ai_3_goal)\]/\1_slide_up_right\]/   }
      /3.{78}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_left\]/  }
      /3.{79}[.KFB][.KFB]/ { s/(\[ai_3_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /[.KFB].{79}3/   { s/(\[ai_3_goal)\]/\1_line_up\]/          }
      /3.{79}[.KFB]/   { s/(\[ai_3_goal)\]/\1_line_down\]/        }
      /[.KFB]3/      { s/(\[ai_3_goal)\]/\1_shift_left\]/       }
      /3[.KFB]/      { s/(\[ai_3_goal)\]/\1_shift_right\]/      }
      /\[ai_3_taking_cover/! {
        s/(3[.KFB]?[.KFB]?[.KFB]?([@a0oxAyO]).*)$/\1[ai_3_taking_cover_\2]/
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
      /[13]([.KFB]?|.{79}|.{79}[.KFB].{79})[31].*\[FIELD_END\]/ {
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
      /[32]([.KFB]?|.{79}|.{79}[.KFB].{79})[32].*\[FIELD_END\]/ {
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
      /[43]([.KFB]?|.{79}|.{79}[.KFB].{79})[34].*\[FIELD_END\]/ {
          s/\[ai_3_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_3_goal_plant_bomb]/
      }
    }
    }
  }
:ai_3_goal_handler
   /\[ai_3_goal_plant_bomb\]/! {
     /[=kfb].{79}3.*\[FIELD_END\].*\[ai_3_goal_line_up\]/ {
         s/\[ai_3_goal_line_up\]//
         s/$/[ai_3_goal_plant_bomb]/
     } 
     /[=kfb]3.*\[FIELD_END\].*\[ai_3_goal_shift_left\]/ {
         s/\[ai_3_goal_shift_left\]//
         s/$/[ai_3_goal_plant_bomb]/
     } 
     /3.{79}[=kfb].*\[FIELD_END\].*\[ai_3_goal_line_down\]/ {
         s/\[ai_3_goal_line_down\]//
         s/$/[ai_3_goal_plant_bomb]/
     }
     /3[=kfb].*\[FIELD_END\].*\[ai_3_goal_shift_right\]/ {
         s/\[ai_3_goal_shift_right\]//g
         s/$/[ai_3_goal_plant_bomb]/
     }
   }
#GOAL_HANDLER    
    /\[ai_3_cmd_query/! {
        /\[ai_3_goal_plant_bomb\]/ {
            s/\[ai_3_goal_plant_bomb\]//
            s/\[ai_3_goal_(line|shift)_(up|down|right|left)\]//g
            s/\[ai_3_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/$/\[ai_3_cmd_query_!plant\]/
            #go_away_way
            /[.KFB].{79}[.KFB]3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /[.KFB]3.{78}[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /3[.KFB].{79}[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /[.KFB].{78}3[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /3.{78}[.KFB][.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /3.{79}[.KFB][.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /[.KFB][.KFB].{79}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /[.KFB][.KFB].{78}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /[.KFB][.KFB][.KFB]3/    { s/(\[ai_3_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /3[.KFB][.KFB][.KFB]/    { s/(\[ai_3_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /3.{79}[.KFB].{79}[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down_!down\]/    }
            /[.KFB].{79}[.KFB].{79}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up_!up\]/      }
            /3.{79}[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!down\]/    }
            /[.KFB].{79}3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!up\]/      }
            /3[.KFB]/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!right\]/    }
            /[.KFB]3/ { s/(\[ai_3_cmd_query_!plant)\]/\1_!left\]/      }
        }
        /\[ai_3_goal_line_up\]/ {            
            /[.KFB].{79}3/    { s/$/[ai_3_cmd_query_!up]/;            b a3q; }
            /#[.KFB].{78}3[.KFB]/ { s/$/[ai_3_cmd_query_!right_!up]/;     b a3q; }
            /[.KFB]#.{78}[.KFB]3/ { s/$/[ai_3_cmd_query_!left_!up]/;      b a3q; }
            /[.KFB]{2}3/      { s/$/[ai_3_cmd_query_!left_!left\]/;         b a3q; }
            /3[.KFB]{2}/      { s/$/[ai_3_cmd_query_!right_!right\]/;        b a3q; }
            /[.KFB]3/         { s/$/[ai_3_cmd_query_!left\]/;         b a3q; }
            /3[.KFB]/         { s/$/[ai_3_cmd_query_!right\]/;        b a3q; }
        }
        /\[ai_3_goal_line_down\]/ {
            /3.{79}[.KFB]/    { s/$/[ai_3_cmd_query_!down]/;          b a3q; }
            /3[.KFB].{78}#[.KFB]/ { s/$/[ai_3_cmd_query_!right_!down]/;   b a3q; }
            /[.KFB]3.{78}[.KFB]#/ { s/$/[ai_3_cmd_query_!left_!down]/;    b a3q; }
            /[.KFB]{2}3/      { s/$/[ai_3_cmd_query_!left_!left\]/;         b a3q; }
            /3[.KFB]{2}/      { s/$/[ai_3_cmd_query_!right_!right\]/;        b a3q; }
            /[.KFB]3/         { s/$/[ai_3_cmd_query_!left\]/;         b a3q; }
            /3[.KFB]/         { s/$/[ai_3_cmd_query_!right\]/;        b a3q; }
        }
        /\[ai_3_goal_shift_right\]/ {
            /3[.KFB]/         { s/$/[ai_3_cmd_query_!right]/;         b a3q; }
            /[.KFB][.KFB].{78}3#/ { s/$/[ai_3_cmd_query_!up_!right]/;     b a3q; }
            /3#.{78}[.KFB][.KFB]/ { s/$/[ai_3_cmd_query_!down_!right]/;   b a3q; }
        }
        /\[ai_3_goal_shift_left\]/ {
            /[.KFB]3/           { s/$/[ai_3_cmd_query_!left]/;        b a3q; }
            /[.KFB][.KFB].{78}#3/ { s/$/[ai_3_cmd_query_!up_!left]/;      b a3q; }
            /#3.{78}[.KFB][.KFB]/ { s/$/[ai_3_cmd_query_!down_!left]/;    b a3q; }
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
    /[@a0oxAyO*qvp](.{79}([.KFB].{79}([.KFB].{79})?)?)4.*\[FIELD_END\]/ {
      #Bomb is higher
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /[.KFB].{79}[.KFB]4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]4.{78}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4[.KFB].{79}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}4[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4[.KFB][.KFB]/      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /4.{79}[.KFB]/   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /[.KFB]4/        { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4[.KFB]/        { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\[ai_4_taking_cover/! {
        s/(([@a0oxAyO])(.{79}([.KFB].{79}([.KFB].{79})?)?)4.*)$/\1\[ai_4_taking_cover_\2\]/
      }
      b ai_4_goal_handler
    }

    /4(.{79}([.KFB].{79}([.KFB].{79})?)?)[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is below
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /[.KFB].{79}[.KFB]4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]4.{78}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4[.KFB].{79}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}4[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4[.KFB][.KFB]/      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /[.KFB]4/        { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4[.KFB]/        { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\[ai_4_taking_cover/! {
        s/(4(.{79}([.KFB].{79}([.KFB].{79})?)?)([@a0oxAyO]).*)$/\1\[ai_4_taking_cover_\5\]/
      }
      b ai_4_goal_handler
    }
    
    /[@a0oxAyO*qvp][.KFB]?[.KFB]?[.KFB]?4.*\[FIELD_END\]/ {
      #Bomb is to the left
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /[.KFB].{79}[.KFB]4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]4.{78}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4[.KFB].{79}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}4[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /4[.KFB][.KFB]/      { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /[.KFB].{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /4.{79}[.KFB]/   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /4[.KFB]/        { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /[.KFB]4/        { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /\[ai_4_taking_cover/! { 
        s/(([@a0oxAyO])[.KFB]?[.KFB]?[.KFB]?4.*)$/\1\[ai_4_taking_cover_\2\]/
      }
      b ai_4_goal_handler
    }

    /4[.KFB]?[.KFB]?[.KFB]?[@a0oxAyO*qvp].*\[FIELD_END\]/ {
      #Bomb is to the right
      s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
      s/\[ai_4_goal_line_(up|down)\]//g
      s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
      s/$/\[ai_4_goal\]/
      /[.KFB].{79}[.KFB]4/ { s/(\[ai_4_goal)\]/\1_slide_left_up\]/    }
      /[.KFB]4.{78}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_left_down\]/  }
      /4[.KFB].{79}[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_down\]/ }
      /[.KFB].{78}4[.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_right_up\]/   }
      /[.KFB][.KFB].{79}4/ { s/(\[ai_4_goal)\]/\1_slide_up_left\]/    }
      /[.KFB][.KFB].{78}4/ { s/(\[ai_4_goal)\]/\1_slide_up_right\]/   }
      /4.{78}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_left\]/  }
      /4.{79}[.KFB][.KFB]/ { s/(\[ai_4_goal)\]/\1_slide_down_right\]/ }
      /[.KFB][.KFB]4/      { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /[.KFB].{79}4/   { s/(\[ai_4_goal)\]/\1_line_up\]/          }
      /4.{79}[.KFB]/   { s/(\[ai_4_goal)\]/\1_line_down\]/        }
      /[.KFB]4/        { s/(\[ai_4_goal)\]/\1_shift_left\]/       }
      /4[.KFB]/        { s/(\[ai_4_goal)\]/\1_shift_right\]/      }
      /\[ai_4_taking_cover/! {
        s/(4[.KFB]?[.KFB]?[.KFB]?([@a0oxAyO]).*)$/\1[ai_4_taking_cover_\2]/
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
      /[14]([.KFB]?|.{79}|.{79}[.KFB].{79})[41].*\[FIELD_END\]/ {
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
      /[32]([.KFB]?|.{79}|.{79}[.KFB].{79})[23].*\[FIELD_END\]/ {
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
      /[24]([.KFB]?|.{79}|.{79}[.KFB].{79})[24].*\[FIELD_END\]/ {
          s/\[ai_4_goal_(line|shift)_(up|down|right|left)\]//g
          s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
    }
  }
:ai_4_goal_handler
    /\[ai_4_goal_plant_bomb\]/! {
      /[=kfb].{79}4.*\[FIELD_END\].*\[ai_4_goal_line_up\]/ {
          s/\[ai_4_goal_line_up\]//
          s/$/[ai_4_goal_plant_bomb]/
      } 
      /[=kfb]4.*\[FIELD_END\].*\[ai_4_goal_shift_left\]/ {
          s/\[ai_4_goal_shift_left\]//
          s/$/[ai_4_goal_plant_bomb]/
      } 
      /4.{79}[=kfb].*\[FIELD_END\].*\[ai_4_goal_line_down\]/ {
          s/\[ai_4_goal_line_down\]//
          s/$/[ai_4_goal_plant_bomb]/
      }
      /4[=kfb].*\[FIELD_END\].*\[ai_4_goal_shift_right\]/ {
          s/\[ai_4_goal_shift_right\]//g
          s/$/[ai_4_goal_plant_bomb]/
      }
    }
#GOAL_HANDLER    
    /\[ai_4_cmd_query/! {
        /\[ai_4_goal_plant_bomb\]/ {
            s/\[ai_4_goal_plant_bomb\]//
            s/\[ai_4_goal_(line|shift)_(up|down|right|left)\]//g
            s/\[ai_4_goal_slide_(up|down|left|right)_(up|down|left|right)\]//g
            s/$/\[ai_4_cmd_query_!plant\]/
            #go_away_way
            /[.KFB].{79}[.KFB]4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!up\]/     }
            /[.KFB]4.{78}[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!down\]/   }
            /4[.KFB].{79}[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!down\]/  }
            /[.KFB].{78}4[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!up\]/    }
            /4.{78}[.KFB][.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down_!left\]/   }
            /4.{79}[.KFB][.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down_!right\]/  }
            /[.KFB][.KFB].{79}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up_!left\]/     }
            /[.KFB][.KFB].{78}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up_!right\]/    }
            /[.KFB][.KFB][.KFB]4/    { s/(\[ai_4_cmd_query_!plant)\]/\1_!left_!left\]/   }
            /4[.KFB][.KFB][.KFB]/    { s/(\[ai_4_cmd_query_!plant)\]/\1_!right_!right\]/ }
            /4.{79}[.KFB].{79}[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down_!down\]/    }
            /[.KFB].{79}[.KFB].{79}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up_!up\]/      }
            /4.{79}[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!down\]/    }
            /[.KFB].{79}4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!up\]/      }
            /4[.KFB]/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!right\]/    }
            /[.KFB]4/ { s/(\[ai_4_cmd_query_!plant)\]/\1_!left\]/      }
        }
        /\[ai_4_goal_line_up\]/ {            
            /[.KFB].{79}4/    { s/$/[ai_4_cmd_query_!up]/;            b a4q; }
            /#[.KFB].{78}4[.KFB]/ { s/$/[ai_4_cmd_query_!right_!up]/;     b a4q; }
            /[.KFB]#.{78}[.KFB]4/ { s/$/[ai_4_cmd_query_!left_!up]/;      b a4q; }
            /[.KFB]{2}4/         { s/$/[ai_4_cmd_query_!left_!left]/;          b a4q; }
            /4[.KFB]{2}/         { s/$/[ai_4_cmd_query_!right_!right]/;         b a4q; }
            /[.KFB]4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /4[.KFB]/         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
        }
        /\[ai_4_goal_line_down\]/ {
            /4.{79}[.KFB]/    { s/$/[ai_4_cmd_query_!down]/;          b a4q; }
            /4[.KFB].{78}#[.KFB]/ { s/$/[ai_4_cmd_query_!right_!down]/;   b a4q; }
            /[.KFB]4.{78}[.KFB]#/ { s/$/[ai_4_cmd_query_!left_!down]/;    b a4q; }
            /[.KFB]{2}4/         { s/$/[ai_4_cmd_query_!left_!left]/;          b a4q; }
            /4[.KFB]{2}/         { s/$/[ai_4_cmd_query_!right_!right]/;         b a4q; }
            /[.KFB]4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /4[.KFB]/         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
        }
        /\[ai_4_goal_shift_right\]/ {
            /4[.KFB]/         { s/$/[ai_4_cmd_query_!right]/;         b a4q; }
            /[.KFB][.KFB].{78}4#/ { s/$/[ai_4_cmd_query_!up_!right]/;     b a4q; }
            /4#.{78}[.KFB][.KFB]/ { s/$/[ai_4_cmd_query_!down_!right]/;   b a4q; }
        }
        /\[ai_4_goal_shift_left\]/ {
            /[.KFB]4/         { s/$/[ai_4_cmd_query_!left]/;          b a4q; }
            /[.KFB][.KFB].{78}#4/ { s/$/[ai_4_cmd_query_!up_!left]/;      b a4q; }
            /#4.{78}[.KFB][.KFB]/ { s/$/[ai_4_cmd_query_!down_!left]/;    b a4q; }
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
s/\[(first|second|third|fourth)_abomb_tacted\]//g

/([@a0oxAyO]).*\[FIELD_END\].*\[ai_2_taking_cover_\1/! {
    s/\[ai_2_taking_cover_[@a0oxAyO]\]//g
}
/([@a0oxAyO]).*\[FIELD_END\].*\[ai_3_taking_cover_\1/! {
    s/\[ai_3_taking_cover_[@a0oxAyO]\]//g
}
/([@a0oxAyO]).*\[FIELD_END\].*\[ai_4_taking_cover_\1/! {
    s/\[ai_4_taking_cover_[@a0oxAyO]\]//g
}
/\[ai_2_taking_cover/ {
    s/\[ai_2_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0oxAyO]).*\[FIELD_END\].*\[ai_2_taking_cover_\1/b print_after_ai
}
/\[ai_3_taking_cover/ {
    s/\[ai_3_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0oxAyO]).*\[FIELD_END\].*\[ai_3_taking_cover_\1/b print_after_ai
}
/\[ai_4_taking_cover/ {
    s/\[ai_4_goal_(line|shift)_(up|down|left|right)\]//g
    /([@a0oxAyO]).*\[FIELD_END\].*\[ai_4_taking_cover_\1/b print_after_ai
}
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
  s/#[@a0oxAyO*#34=.kfbKFBqvp]*([12])?[@a0oxAyO*#34=.kfbKFBqvp]*([12])?[@a0oxAyO*#34=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.34kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_sec_fir:\1:dissfi]/
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
  s/#[@a0oxAyO*#14=.kfbKFBqvp]*([23])?[@a0oxAyO*#14=.kfbKFBqvp]*([23])?[@a0oxAyO*#14=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.14kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_sec_th:\1:dissth]/
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
  s/#[@a0oxAyO*#13=.kfbKFBqvp]*([24])?[@a0oxAyO*#13=.kfbKFBqvp]*([24])?[@a0oxAyO*#13=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.13kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_sec_fu:\1:dissfu]/
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
  s/#[@a0oxAyO*#12=.kfbKFBqvp]*([34])?[@a0oxAyO*#12=.kfbKFBqvp]*([34])?[@a0oxAyO*#12=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.12kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_th_fu:\1:distfu]/
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
  s/#[@a0oxAyO*#42=.kfbKFBqvp]*([31])?[@a0oxAyO*#42=.kfbKFBqvp]*([31])?[@a0oxAyO*#42=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.42kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_th_fi:\1:distfi]/
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
  s/#[@a0oxAyO*#32=.kfbKFBqvp]*([41])?[@a0oxAyO*#32=.kfbKFBqvp]*([41])?[@a0oxAyO*#32=.kfbKFBqvp]*#\n/\1\2\n/g
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
  y/@ao0=*#.32kfbKFBqvp/8888888888888888888/
  s/\[.*:(.*):.*\]/[dis_fu_fi:\1:disffi]/
  s/(\[dis_fu_fi)/\1SPIKE/
  H; x; 
  s/\n?\[dis_fu_fi:8*:disffi\]//
  s/\n?(\[dis_fu_fi)SPIKE/\1/
  
  b print_to_ai_handler




# Randomly fill destoryable walls with bonuses
# Bonus list:
# K -- Bombalist    -- bomb kicker
# F -- Pyromaniac   -- extended explosions
# B -- Miser        -- +1 bomb
#
# Field must be already 'eated' by sed
# Random number in format: [RANDOM_NUMBER:$BIN$ROW$COL$TYPE[0-9]+:NR]
:bonus_generator
  /\[RANDOM_NUMBER:[0-9]+:NR\]/! {
      #NOT A NUMBER
      s/\n\[RANDOM_NUMBER:.*:NR\]//g
      s/\[RANDOM_NUMBER:.*:NR\]//g
      b end
  }
  H; x

  :restart_bonus_generator
  # Create bonus position entry
  #   Format: [BONUS_$BIN:$ROW,$COL,$TYP:$BIN_SUNOB]
  #     $BIN -- bonus index number
  #     $ROW -- bonus position: row number
  #     $COL -- bonus position: col number
  #     $TYP -- bonus type
  #
  s/$/\[BONUS:r,c,t:SUNOB\]/

  # Choosing row
  /\[RANDOM_NUMBER:1.*1:NR\]/ {
    /\[RANDOM_NUMBER:.[0-4]/ { s/(\[BONUS:)r/\101/ }
    /\[RANDOM_NUMBER:.[5-9]/ { s/(\[BONUS:)r/\102/ }
    b choosing_column
  }
  /\[RANDOM_NUMBER:[1-4]/ {
    /\[RANDOM_NUMBER:.[3-9]/ { 
        s/(\[RANDOM_NUMBER:.(.).*\[BONUS:)r/\10\2/
    }
    /\[RANDOM_NUMBER:.[0-2]/ {
      s/(\[RANDOM_NUMBER:10.*\[BONUS:)r/\104/
      s/(\[RANDOM_NUMBER:11.*\[BONUS:)r/\105/
      s/(\[RANDOM_NUMBER:12.*\[BONUS:)r/\106/
      s/(\[RANDOM_NUMBER:20.*\[BONUS:)r/\107/
      s/(\[RANDOM_NUMBER:21.*\[BONUS:)r/\108/
      s/(\[RANDOM_NUMBER:22.*\[BONUS:)r/\109/
      s/(\[RANDOM_NUMBER:30.*\[BONUS:)r/\104/
      s/(\[RANDOM_NUMBER:31.*\[BONUS:)r/\105/
      s/(\[RANDOM_NUMBER:32.*\[BONUS:)r/\106/
      s/(\[RANDOM_NUMBER:40.*\[BONUS:)r/\107/
      s/(\[RANDOM_NUMBER:41.*\[BONUS:)r/\108/
      s/(\[RANDOM_NUMBER:42.*\[BONUS:)r/\109/
    }
  }
  /\[RANDOM_NUMBER:[5-8]/ {
    s/(\[RANDOM_NUMBER:.(.).*\[BONUS:)r/\11\2/
  }
  /\[RANDOM_NUMBER:9/ {
    /\[RANDOM_NUMBER:.[0-4]/ { s/(\[RANDOM_NUMBER:.*\[BONUS:)r/\120/ }
    /\[RANDOM_NUMBER:.[5-9]/ { s/(\[RANDOM_NUMBER:.*\[BONUS:)r/\121/ }
  }
  
  :choosing_column
  /\[RANDOM_NUMBER:.{2}[0-1]/ {
    s/(\[RANDOM_NUMBER:...(.).*\[BONUS:..,)c/\10\2/
  }
  /\[RANDOM_NUMBER:.{2}[2-6]/ {
    s/(\[RANDOM_NUMBER:...(.).*\[BONUS:..,)c/\11\2/
  }
  /\[RANDOM_NUMBER:.{2}[7-9]/ {
    /(\[RANDOM_NUMBER:...)[89]/ {
      s/(\[RANDOM_NUMBER:...)[89](.*)\[BONUS:.*:SUNOB\]/\1\2/
      b restart_bonus_generator
    }
    s/(\[RANDOM_NUMBER:...(.).*\[BONUS:..,)c/\12\2/
  }

  # Choosing type
  /\[RANDOM_NUMBER:.{4}[0-3]/ {
    s/(\[BONUS:..,..,)t/\1K/
  }
  /\[RANDOM_NUMBER:.{4}[0-3]/ {
    s/(\[BONUS:..,..,)t/\1K/
  }
  /\[RANDOM_NUMBER:.{4}[4-6]/ {
    s/(\[BONUS:..,..,)t/\1F/
  }
  /\[RANDOM_NUMBER:.{4}[7-9]/ {
    s/(\[BONUS:..,..,)t/\1B/
  }

  # Put bonus on field
  s/^(.*)(\[BONUS:..,..,.:SUNOB\])/\2\1/
  s/(\[BONUS:01,0[12],(.):SUNOB\]#{79}\n#.{3})./\1\2/
  s/(\[BONUS:01,03,(.):SUNOB\]#{79}\n#.{6})./\1\2/
  s/(\[BONUS:01,04,(.):SUNOB\]#{79}\n#.{9})./\1\2/
  s/(\[BONUS:01,05,(.):SUNOB\]#{79}\n#.{12})./\1\2/
  s/(\[BONUS:01,06,(.):SUNOB\]#{79}\n#.{15})./\1\2/
  s/(\[BONUS:01,07,(.):SUNOB\]#{79}\n#.{18})./\1\2/
  s/(\[BONUS:01,08,(.):SUNOB\]#{79}\n#.{21})./\1\2/
  s/(\[BONUS:01,09,(.):SUNOB\]#{79}\n#.{24})./\1\2/
  s/(\[BONUS:01,10,(.):SUNOB\]#{79}\n#.{27})./\1\2/
  s/(\[BONUS:01,11,(.):SUNOB\]#{79}\n#.{30})./\1\2/
  s/(\[BONUS:01,12,(.):SUNOB\]#{79}\n#.{33})./\1\2/
  s/(\[BONUS:01,13,(.):SUNOB\]#{79}\n#.{36})./\1\2/
  s/(\[BONUS:01,14,(.):SUNOB\]#{79}\n#.{39})./\1\2/
  s/(\[BONUS:01,15,(.):SUNOB\]#{79}\n#.{42})./\1\2/
  s/(\[BONUS:01,16,(.):SUNOB\]#{79}\n#.{45})./\1\2/
  s/(\[BONUS:01,17,(.):SUNOB\]#{79}\n#.{48})./\1\2/
  s/(\[BONUS:01,18,(.):SUNOB\]#{79}\n#.{51})./\1\2/
  s/(\[BONUS:01,19,(.):SUNOB\]#{79}\n#.{54})./\1\2/
  s/(\[BONUS:01,20,(.):SUNOB\]#{79}\n#.{57})./\1\2/
  s/(\[BONUS:01,21,(.):SUNOB\]#{79}\n#.{60})./\1\2/
  s/(\[BONUS:01,22,(.):SUNOB\]#{79}\n#.{63})./\1\2/
  s/(\[BONUS:01,23,(.):SUNOB\]#{79}\n#.{66})./\1\2/
  s/(\[BONUS:01,24,(.):SUNOB\]#{79}\n#.{69})./\1\2/
  s/(\[BONUS:01,25,(.):SUNOB\]#{79}\n#.{72})./\1\2/
  s/(\[BONUS:01,2[67],(.):SUNOB\]#{79}\n#.{74})./\1\2/
  
  s/(\[BONUS:02,0[12],(.):SUNOB\]#{79}\n.{79}\n#.{3})./\1\2/
  s/(\[BONUS:02,03,(.):SUNOB\]#{79}\n.{79}\n#.{6})./\1\2/
  s/(\[BONUS:02,04,(.):SUNOB\]#{79}\n.{79}\n#.{9})./\1\2/
  s/(\[BONUS:02,05,(.):SUNOB\]#{79}\n.{79}\n#.{12})./\1\2/
  s/(\[BONUS:02,06,(.):SUNOB\]#{79}\n.{79}\n#.{15})./\1\2/
  s/(\[BONUS:02,07,(.):SUNOB\]#{79}\n.{79}\n#.{18})./\1\2/
  s/(\[BONUS:02,08,(.):SUNOB\]#{79}\n.{79}\n#.{21})./\1\2/
  s/(\[BONUS:02,09,(.):SUNOB\]#{79}\n.{79}\n#.{24})./\1\2/
  s/(\[BONUS:02,10,(.):SUNOB\]#{79}\n.{79}\n#.{27})./\1\2/
  s/(\[BONUS:02,11,(.):SUNOB\]#{79}\n.{79}\n#.{30})./\1\2/
  s/(\[BONUS:02,12,(.):SUNOB\]#{79}\n.{79}\n#.{33})./\1\2/
  s/(\[BONUS:02,13,(.):SUNOB\]#{79}\n.{79}\n#.{36})./\1\2/
  s/(\[BONUS:02,14,(.):SUNOB\]#{79}\n.{79}\n#.{39})./\1\2/
  s/(\[BONUS:02,15,(.):SUNOB\]#{79}\n.{79}\n#.{42})./\1\2/
  s/(\[BONUS:02,16,(.):SUNOB\]#{79}\n.{79}\n#.{45})./\1\2/
  s/(\[BONUS:02,17,(.):SUNOB\]#{79}\n.{79}\n#.{48})./\1\2/
  s/(\[BONUS:02,18,(.):SUNOB\]#{79}\n.{79}\n#.{51})./\1\2/
  s/(\[BONUS:02,19,(.):SUNOB\]#{79}\n.{79}\n#.{54})./\1\2/
  s/(\[BONUS:02,20,(.):SUNOB\]#{79}\n.{79}\n#.{57})./\1\2/
  s/(\[BONUS:02,21,(.):SUNOB\]#{79}\n.{79}\n#.{60})./\1\2/
  s/(\[BONUS:02,22,(.):SUNOB\]#{79}\n.{79}\n#.{63})./\1\2/
  s/(\[BONUS:02,23,(.):SUNOB\]#{79}\n.{79}\n#.{66})./\1\2/
  s/(\[BONUS:02,24,(.):SUNOB\]#{79}\n.{79}\n#.{69})./\1\2/
  s/(\[BONUS:02,25,(.):SUNOB\]#{79}\n.{79}\n#.{72})./\1\2/
  s/(\[BONUS:02,2[67],(.):SUNOB\]#{79}\n.{79}\n#.{74})./\1\2/

  s/(\[BONUS:03,01,(.):SUNOB\]#{79}\n(.{79}\n){2}#)./\1\2/
  s/(\[BONUS:03,02,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{3})./\1\2/
  s/(\[BONUS:03,03,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{6})./\1\2/
  s/(\[BONUS:03,04,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{9})./\1\2/
  s/(\[BONUS:03,05,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{12})./\1\2/
  s/(\[BONUS:03,06,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{15})./\1\2/
  s/(\[BONUS:03,07,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{18})./\1\2/
  s/(\[BONUS:03,08,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{21})./\1\2/
  s/(\[BONUS:03,09,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{24})./\1\2/
  s/(\[BONUS:03,10,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{27})./\1\2/
  s/(\[BONUS:03,11,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{30})./\1\2/
  s/(\[BONUS:03,12,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{33})./\1\2/
  s/(\[BONUS:03,13,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{36})./\1\2/
  s/(\[BONUS:03,14,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{39})./\1\2/
  s/(\[BONUS:03,15,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{42})./\1\2/
  s/(\[BONUS:03,16,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{45})./\1\2/
  s/(\[BONUS:03,17,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{48})./\1\2/
  s/(\[BONUS:03,18,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{51})./\1\2/
  s/(\[BONUS:03,19,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{54})./\1\2/
  s/(\[BONUS:03,20,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{57})./\1\2/
  s/(\[BONUS:03,21,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{60})./\1\2/
  s/(\[BONUS:03,22,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{63})./\1\2/
  s/(\[BONUS:03,23,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{66})./\1\2/
  s/(\[BONUS:03,24,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{69})./\1\2/
  s/(\[BONUS:03,25,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{72})./\1\2/
  s/(\[BONUS:03,26,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{74})./\1\2/
  s/(\[BONUS:03,27,(.):SUNOB\]#{79}\n(.{79}\n){2}#.{76})./\1\2/

  s/(\[BONUS:04,01,(.):SUNOB\]#{79}\n(.{79}\n){3}#)./\1\2/
  s/(\[BONUS:04,02,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{3})./\1\2/
  s/(\[BONUS:04,03,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{6})./\1\2/
  s/(\[BONUS:04,04,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{9})./\1\2/
  s/(\[BONUS:04,05,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{12})./\1\2/
  s/(\[BONUS:04,06,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{15})./\1\2/
  s/(\[BONUS:04,07,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{18})./\1\2/
  s/(\[BONUS:04,08,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{21})./\1\2/
  s/(\[BONUS:04,09,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{24})./\1\2/
  s/(\[BONUS:04,10,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{27})./\1\2/
  s/(\[BONUS:04,11,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{30})./\1\2/
  s/(\[BONUS:04,12,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{33})./\1\2/
  s/(\[BONUS:04,13,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{36})./\1\2/
  s/(\[BONUS:04,14,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{39})./\1\2/
  s/(\[BONUS:04,15,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{42})./\1\2/
  s/(\[BONUS:04,16,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{45})./\1\2/
  s/(\[BONUS:04,17,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{48})./\1\2/
  s/(\[BONUS:04,18,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{51})./\1\2/
  s/(\[BONUS:04,19,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{54})./\1\2/
  s/(\[BONUS:04,20,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{57})./\1\2/
  s/(\[BONUS:04,21,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{60})./\1\2/
  s/(\[BONUS:04,22,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{63})./\1\2/
  s/(\[BONUS:04,23,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{66})./\1\2/
  s/(\[BONUS:04,24,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{69})./\1\2/
  s/(\[BONUS:04,25,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{72})./\1\2/
  s/(\[BONUS:04,26,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{74})./\1\2/
  s/(\[BONUS:04,27,(.):SUNOB\]#{79}\n(.{79}\n){3}#.{76})./\1\2/

  s/(\[BONUS:05,01,(.):SUNOB\]#{79}\n(.{79}\n){4}#)./\1\2/
  s/(\[BONUS:05,02,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{3})./\1\2/
  s/(\[BONUS:05,03,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{6})./\1\2/
  s/(\[BONUS:05,04,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{9})./\1\2/
  s/(\[BONUS:05,05,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{12})./\1\2/
  s/(\[BONUS:05,06,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{15})./\1\2/
  s/(\[BONUS:05,07,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{18})./\1\2/
  s/(\[BONUS:05,08,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{21})./\1\2/
  s/(\[BONUS:05,09,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{24})./\1\2/
  s/(\[BONUS:05,10,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{27})./\1\2/
  s/(\[BONUS:05,11,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{30})./\1\2/
  s/(\[BONUS:05,12,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{33})./\1\2/
  s/(\[BONUS:05,13,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{36})./\1\2/
  s/(\[BONUS:05,14,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{39})./\1\2/
  s/(\[BONUS:05,15,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{42})./\1\2/
  s/(\[BONUS:05,16,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{45})./\1\2/
  s/(\[BONUS:05,17,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{48})./\1\2/
  s/(\[BONUS:05,18,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{51})./\1\2/
  s/(\[BONUS:05,19,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{54})./\1\2/
  s/(\[BONUS:05,20,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{57})./\1\2/
  s/(\[BONUS:05,21,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{60})./\1\2/
  s/(\[BONUS:05,22,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{63})./\1\2/
  s/(\[BONUS:05,23,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{66})./\1\2/
  s/(\[BONUS:05,24,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{69})./\1\2/
  s/(\[BONUS:05,25,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{72})./\1\2/
  s/(\[BONUS:05,26,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{74})./\1\2/
  s/(\[BONUS:05,27,(.):SUNOB\]#{79}\n(.{79}\n){4}#.{76})./\1\2/

  s/(\[BONUS:06,01,(.):SUNOB\]#{79}\n(.{79}\n){5}#)./\1\2/
  s/(\[BONUS:06,02,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{3})./\1\2/
  s/(\[BONUS:06,03,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{6})./\1\2/
  s/(\[BONUS:06,04,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{9})./\1\2/
  s/(\[BONUS:06,05,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{12})./\1\2/
  s/(\[BONUS:06,06,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{15})./\1\2/
  s/(\[BONUS:06,07,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{18})./\1\2/
  s/(\[BONUS:06,08,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{21})./\1\2/
  s/(\[BONUS:06,09,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{24})./\1\2/
  s/(\[BONUS:06,10,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{27})./\1\2/
  s/(\[BONUS:06,11,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{30})./\1\2/
  s/(\[BONUS:06,12,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{33})./\1\2/
  s/(\[BONUS:06,13,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{36})./\1\2/
  s/(\[BONUS:06,14,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{39})./\1\2/
  s/(\[BONUS:06,15,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{42})./\1\2/
  s/(\[BONUS:06,16,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{45})./\1\2/
  s/(\[BONUS:06,17,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{48})./\1\2/
  s/(\[BONUS:06,18,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{51})./\1\2/
  s/(\[BONUS:06,19,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{54})./\1\2/
  s/(\[BONUS:06,20,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{57})./\1\2/
  s/(\[BONUS:06,21,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{60})./\1\2/
  s/(\[BONUS:06,22,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{63})./\1\2/
  s/(\[BONUS:06,23,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{66})./\1\2/
  s/(\[BONUS:06,24,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{69})./\1\2/
  s/(\[BONUS:06,25,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{72})./\1\2/
  s/(\[BONUS:06,26,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{74})./\1\2/
  s/(\[BONUS:06,27,(.):SUNOB\]#{79}\n(.{79}\n){5}#.{76})./\1\2/

  s/(\[BONUS:07,01,(.):SUNOB\]#{79}\n(.{79}\n){6}#)./\1\2/
  s/(\[BONUS:07,02,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{3})./\1\2/
  s/(\[BONUS:07,03,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{6})./\1\2/
  s/(\[BONUS:07,04,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{9})./\1\2/
  s/(\[BONUS:07,05,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{12})./\1\2/
  s/(\[BONUS:07,06,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{15})./\1\2/
  s/(\[BONUS:07,07,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{18})./\1\2/
  s/(\[BONUS:07,08,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{21})./\1\2/
  s/(\[BONUS:07,09,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{24})./\1\2/
  s/(\[BONUS:07,10,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{27})./\1\2/
  s/(\[BONUS:07,11,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{30})./\1\2/
  s/(\[BONUS:07,12,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{33})./\1\2/
  s/(\[BONUS:07,13,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{36})./\1\2/
  s/(\[BONUS:07,14,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{39})./\1\2/
  s/(\[BONUS:07,15,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{42})./\1\2/
  s/(\[BONUS:07,16,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{45})./\1\2/
  s/(\[BONUS:07,17,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{48})./\1\2/
  s/(\[BONUS:07,18,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{51})./\1\2/
  s/(\[BONUS:07,19,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{54})./\1\2/
  s/(\[BONUS:07,20,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{57})./\1\2/
  s/(\[BONUS:07,21,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{60})./\1\2/
  s/(\[BONUS:07,22,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{63})./\1\2/
  s/(\[BONUS:07,23,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{66})./\1\2/
  s/(\[BONUS:07,24,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{69})./\1\2/
  s/(\[BONUS:07,25,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{72})./\1\2/
  s/(\[BONUS:07,26,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{74})./\1\2/
  s/(\[BONUS:07,27,(.):SUNOB\]#{79}\n(.{79}\n){6}#.{76})./\1\2/

  s/(\[BONUS:08,01,(.):SUNOB\]#{79}\n(.{79}\n){7}#)./\1\2/
  s/(\[BONUS:08,02,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{3})./\1\2/
  s/(\[BONUS:08,03,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{6})./\1\2/
  s/(\[BONUS:08,04,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{9})./\1\2/
  s/(\[BONUS:08,05,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{12})./\1\2/
  s/(\[BONUS:08,06,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{15})./\1\2/
  s/(\[BONUS:08,07,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{18})./\1\2/
  s/(\[BONUS:08,08,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{21})./\1\2/
  s/(\[BONUS:08,09,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{24})./\1\2/
  s/(\[BONUS:08,10,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{27})./\1\2/
  s/(\[BONUS:08,11,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{30})./\1\2/
  s/(\[BONUS:08,12,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{33})./\1\2/
  s/(\[BONUS:08,13,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{36})./\1\2/
  s/(\[BONUS:08,14,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{39})./\1\2/
  s/(\[BONUS:08,15,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{42})./\1\2/
  s/(\[BONUS:08,16,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{45})./\1\2/
  s/(\[BONUS:08,17,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{48})./\1\2/
  s/(\[BONUS:08,18,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{51})./\1\2/
  s/(\[BONUS:08,19,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{54})./\1\2/
  s/(\[BONUS:08,20,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{57})./\1\2/
  s/(\[BONUS:08,21,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{60})./\1\2/
  s/(\[BONUS:08,22,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{63})./\1\2/
  s/(\[BONUS:08,23,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{66})./\1\2/
  s/(\[BONUS:08,24,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{69})./\1\2/
  s/(\[BONUS:08,25,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{72})./\1\2/
  s/(\[BONUS:08,26,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{74})./\1\2/
  s/(\[BONUS:08,27,(.):SUNOB\]#{79}\n(.{79}\n){7}#.{76})./\1\2/

  s/(\[BONUS:09,01,(.):SUNOB\]#{79}\n(.{79}\n){8}#)./\1\2/
  s/(\[BONUS:09,02,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{3})./\1\2/
  s/(\[BONUS:09,03,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{6})./\1\2/
  s/(\[BONUS:09,04,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{9})./\1\2/
  s/(\[BONUS:09,05,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{12})./\1\2/
  s/(\[BONUS:09,06,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{15})./\1\2/
  s/(\[BONUS:09,07,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{18})./\1\2/
  s/(\[BONUS:09,08,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{21})./\1\2/
  s/(\[BONUS:09,09,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{24})./\1\2/
  s/(\[BONUS:09,10,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{27})./\1\2/
  s/(\[BONUS:09,11,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{30})./\1\2/
  s/(\[BONUS:09,12,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{33})./\1\2/
  s/(\[BONUS:09,13,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{36})./\1\2/
  s/(\[BONUS:09,14,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{39})./\1\2/
  s/(\[BONUS:09,15,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{42})./\1\2/
  s/(\[BONUS:09,16,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{45})./\1\2/
  s/(\[BONUS:09,17,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{48})./\1\2/
  s/(\[BONUS:09,18,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{51})./\1\2/
  s/(\[BONUS:09,19,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{54})./\1\2/
  s/(\[BONUS:09,20,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{57})./\1\2/
  s/(\[BONUS:09,21,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{60})./\1\2/
  s/(\[BONUS:09,22,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{63})./\1\2/
  s/(\[BONUS:09,23,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{66})./\1\2/
  s/(\[BONUS:09,24,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{69})./\1\2/
  s/(\[BONUS:09,25,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{72})./\1\2/
  s/(\[BONUS:09,26,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{74})./\1\2/
  s/(\[BONUS:09,27,(.):SUNOB\]#{79}\n(.{79}\n){8}#.{76})./\1\2/

  s/(\[BONUS:10,01,(.):SUNOB\]#{79}\n(.{79}\n){9}#)./\1\2/
  s/(\[BONUS:10,02,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{3})./\1\2/
  s/(\[BONUS:10,03,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{6})./\1\2/
  s/(\[BONUS:10,04,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{9})./\1\2/
  s/(\[BONUS:10,05,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{12})./\1\2/
  s/(\[BONUS:10,06,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{15})./\1\2/
  s/(\[BONUS:10,07,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{18})./\1\2/
  s/(\[BONUS:10,08,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{21})./\1\2/
  s/(\[BONUS:10,09,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{24})./\1\2/
  s/(\[BONUS:10,10,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{27})./\1\2/
  s/(\[BONUS:10,11,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{30})./\1\2/
  s/(\[BONUS:10,12,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{33})./\1\2/
  s/(\[BONUS:10,13,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{36})./\1\2/
  s/(\[BONUS:10,14,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{39})./\1\2/
  s/(\[BONUS:10,15,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{42})./\1\2/
  s/(\[BONUS:10,16,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{45})./\1\2/
  s/(\[BONUS:10,17,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{48})./\1\2/
  s/(\[BONUS:10,18,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{51})./\1\2/
  s/(\[BONUS:10,19,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{54})./\1\2/
  s/(\[BONUS:10,20,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{57})./\1\2/
  s/(\[BONUS:10,21,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{60})./\1\2/
  s/(\[BONUS:10,22,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{63})./\1\2/
  s/(\[BONUS:10,23,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{66})./\1\2/
  s/(\[BONUS:10,24,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{69})./\1\2/
  s/(\[BONUS:10,25,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{72})./\1\2/
  s/(\[BONUS:10,26,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{74})./\1\2/
  s/(\[BONUS:10,27,(.):SUNOB\]#{79}\n(.{79}\n){9}#.{76})./\1\2/

  s/(\[BONUS:11,01,(.):SUNOB\]#{79}\n(.{79}\n){10}#)./\1\2/
  s/(\[BONUS:11,02,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{3})./\1\2/
  s/(\[BONUS:11,03,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{6})./\1\2/
  s/(\[BONUS:11,04,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{9})./\1\2/
  s/(\[BONUS:11,05,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{12})./\1\2/
  s/(\[BONUS:11,06,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{15})./\1\2/
  s/(\[BONUS:11,07,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{18})./\1\2/
  s/(\[BONUS:11,08,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{21})./\1\2/
  s/(\[BONUS:11,09,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{24})./\1\2/
  s/(\[BONUS:11,10,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{27})./\1\2/
  s/(\[BONUS:11,11,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{30})./\1\2/
  s/(\[BONUS:11,12,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{33})./\1\2/
  s/(\[BONUS:11,13,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{36})./\1\2/
  s/(\[BONUS:11,14,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{39})./\1\2/
  s/(\[BONUS:11,15,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{42})./\1\2/
  s/(\[BONUS:11,16,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{45})./\1\2/
  s/(\[BONUS:11,17,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{48})./\1\2/
  s/(\[BONUS:11,18,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{51})./\1\2/
  s/(\[BONUS:11,19,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{54})./\1\2/
  s/(\[BONUS:11,20,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{57})./\1\2/
  s/(\[BONUS:11,21,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{60})./\1\2/
  s/(\[BONUS:11,22,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{63})./\1\2/
  s/(\[BONUS:11,23,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{66})./\1\2/
  s/(\[BONUS:11,24,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{69})./\1\2/
  s/(\[BONUS:11,25,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{72})./\1\2/
  s/(\[BONUS:11,26,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{74})./\1\2/
  s/(\[BONUS:11,27,(.):SUNOB\]#{79}\n(.{79}\n){10}#.{76})./\1\2/

  s/(\[BONUS:12,01,(.):SUNOB\]#{79}\n(.{79}\n){11}#)./\1\2/
  s/(\[BONUS:12,02,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{3})./\1\2/
  s/(\[BONUS:12,03,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{6})./\1\2/
  s/(\[BONUS:12,04,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{9})./\1\2/
  s/(\[BONUS:12,05,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{12})./\1\2/
  s/(\[BONUS:12,06,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{15})./\1\2/
  s/(\[BONUS:12,07,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{18})./\1\2/
  s/(\[BONUS:12,08,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{21})./\1\2/
  s/(\[BONUS:12,09,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{24})./\1\2/
  s/(\[BONUS:12,10,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{27})./\1\2/
  s/(\[BONUS:12,11,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{30})./\1\2/
  s/(\[BONUS:12,12,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{33})./\1\2/
  s/(\[BONUS:12,13,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{36})./\1\2/
  s/(\[BONUS:12,14,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{39})./\1\2/
  s/(\[BONUS:12,15,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{42})./\1\2/
  s/(\[BONUS:12,16,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{45})./\1\2/
  s/(\[BONUS:12,17,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{48})./\1\2/
  s/(\[BONUS:12,18,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{51})./\1\2/
  s/(\[BONUS:12,19,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{54})./\1\2/
  s/(\[BONUS:12,20,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{57})./\1\2/
  s/(\[BONUS:12,21,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{60})./\1\2/
  s/(\[BONUS:12,22,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{63})./\1\2/
  s/(\[BONUS:12,23,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{66})./\1\2/
  s/(\[BONUS:12,24,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{69})./\1\2/
  s/(\[BONUS:12,25,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{72})./\1\2/
  s/(\[BONUS:12,26,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{74})./\1\2/
  s/(\[BONUS:12,27,(.):SUNOB\]#{79}\n(.{79}\n){11}#.{76})./\1\2/

  s/(\[BONUS:13,01,(.):SUNOB\]#{79}\n(.{79}\n){12}#)./\1\2/
  s/(\[BONUS:13,02,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{3})./\1\2/
  s/(\[BONUS:13,03,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{6})./\1\2/
  s/(\[BONUS:13,04,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{9})./\1\2/
  s/(\[BONUS:13,05,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{12})./\1\2/
  s/(\[BONUS:13,06,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{15})./\1\2/
  s/(\[BONUS:13,07,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{18})./\1\2/
  s/(\[BONUS:13,08,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{21})./\1\2/
  s/(\[BONUS:13,09,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{24})./\1\2/
  s/(\[BONUS:13,10,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{27})./\1\2/
  s/(\[BONUS:13,11,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{30})./\1\2/
  s/(\[BONUS:13,12,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{33})./\1\2/
  s/(\[BONUS:13,13,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{36})./\1\2/
  s/(\[BONUS:13,14,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{39})./\1\2/
  s/(\[BONUS:13,15,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{42})./\1\2/
  s/(\[BONUS:13,16,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{45})./\1\2/
  s/(\[BONUS:13,17,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{48})./\1\2/
  s/(\[BONUS:13,18,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{51})./\1\2/
  s/(\[BONUS:13,19,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{54})./\1\2/
  s/(\[BONUS:13,20,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{57})./\1\2/
  s/(\[BONUS:13,21,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{60})./\1\2/
  s/(\[BONUS:13,22,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{63})./\1\2/
  s/(\[BONUS:13,23,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{66})./\1\2/
  s/(\[BONUS:13,24,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{69})./\1\2/
  s/(\[BONUS:13,25,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{72})./\1\2/
  s/(\[BONUS:13,26,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{74})./\1\2/
  s/(\[BONUS:13,27,(.):SUNOB\]#{79}\n(.{79}\n){12}#.{76})./\1\2/

  s/(\[BONUS:14,01,(.):SUNOB\]#{79}\n(.{79}\n){13}#)./\1\2/
  s/(\[BONUS:14,02,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{3})./\1\2/
  s/(\[BONUS:14,03,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{6})./\1\2/
  s/(\[BONUS:14,04,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{9})./\1\2/
  s/(\[BONUS:14,05,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{12})./\1\2/
  s/(\[BONUS:14,06,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{15})./\1\2/
  s/(\[BONUS:14,07,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{18})./\1\2/
  s/(\[BONUS:14,08,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{21})./\1\2/
  s/(\[BONUS:14,09,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{24})./\1\2/
  s/(\[BONUS:14,10,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{27})./\1\2/
  s/(\[BONUS:14,11,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{30})./\1\2/
  s/(\[BONUS:14,12,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{33})./\1\2/
  s/(\[BONUS:14,13,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{36})./\1\2/
  s/(\[BONUS:14,14,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{39})./\1\2/
  s/(\[BONUS:14,15,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{42})./\1\2/
  s/(\[BONUS:14,16,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{45})./\1\2/
  s/(\[BONUS:14,17,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{48})./\1\2/
  s/(\[BONUS:14,18,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{51})./\1\2/
  s/(\[BONUS:14,19,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{54})./\1\2/
  s/(\[BONUS:14,20,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{57})./\1\2/
  s/(\[BONUS:14,21,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{60})./\1\2/
  s/(\[BONUS:14,22,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{63})./\1\2/
  s/(\[BONUS:14,23,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{66})./\1\2/
  s/(\[BONUS:14,24,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{69})./\1\2/
  s/(\[BONUS:14,25,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{72})./\1\2/
  s/(\[BONUS:14,26,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{74})./\1\2/
  s/(\[BONUS:14,27,(.):SUNOB\]#{79}\n(.{79}\n){13}#.{76})./\1\2/

  s/(\[BONUS:15,01,(.):SUNOB\]#{79}\n(.{79}\n){14}#)./\1\2/
  s/(\[BONUS:15,02,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{3})./\1\2/
  s/(\[BONUS:15,03,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{6})./\1\2/
  s/(\[BONUS:15,04,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{9})./\1\2/
  s/(\[BONUS:15,05,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{12})./\1\2/
  s/(\[BONUS:15,06,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{15})./\1\2/
  s/(\[BONUS:15,07,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{18})./\1\2/
  s/(\[BONUS:15,08,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{21})./\1\2/
  s/(\[BONUS:15,09,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{24})./\1\2/
  s/(\[BONUS:15,10,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{27})./\1\2/
  s/(\[BONUS:15,11,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{30})./\1\2/
  s/(\[BONUS:15,12,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{33})./\1\2/
  s/(\[BONUS:15,13,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{36})./\1\2/
  s/(\[BONUS:15,14,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{39})./\1\2/
  s/(\[BONUS:15,15,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{42})./\1\2/
  s/(\[BONUS:15,16,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{45})./\1\2/
  s/(\[BONUS:15,17,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{48})./\1\2/
  s/(\[BONUS:15,18,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{51})./\1\2/
  s/(\[BONUS:15,19,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{54})./\1\2/
  s/(\[BONUS:15,20,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{57})./\1\2/
  s/(\[BONUS:15,21,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{60})./\1\2/
  s/(\[BONUS:15,22,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{63})./\1\2/
  s/(\[BONUS:15,23,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{66})./\1\2/
  s/(\[BONUS:15,24,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{69})./\1\2/
  s/(\[BONUS:15,25,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{72})./\1\2/
  s/(\[BONUS:15,26,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{74})./\1\2/
  s/(\[BONUS:15,27,(.):SUNOB\]#{79}\n(.{79}\n){14}#.{76})./\1\2/

  s/(\[BONUS:16,01,(.):SUNOB\]#{79}\n(.{79}\n){15}#)./\1\2/
  s/(\[BONUS:16,02,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{3})./\1\2/
  s/(\[BONUS:16,03,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{6})./\1\2/
  s/(\[BONUS:16,04,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{9})./\1\2/
  s/(\[BONUS:16,05,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{12})./\1\2/
  s/(\[BONUS:16,06,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{15})./\1\2/
  s/(\[BONUS:16,07,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{18})./\1\2/
  s/(\[BONUS:16,08,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{21})./\1\2/
  s/(\[BONUS:16,09,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{24})./\1\2/
  s/(\[BONUS:16,10,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{27})./\1\2/
  s/(\[BONUS:16,11,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{30})./\1\2/
  s/(\[BONUS:16,12,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{33})./\1\2/
  s/(\[BONUS:16,13,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{36})./\1\2/
  s/(\[BONUS:16,14,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{39})./\1\2/
  s/(\[BONUS:16,15,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{42})./\1\2/
  s/(\[BONUS:16,16,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{45})./\1\2/
  s/(\[BONUS:16,17,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{48})./\1\2/
  s/(\[BONUS:16,18,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{51})./\1\2/
  s/(\[BONUS:16,19,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{54})./\1\2/
  s/(\[BONUS:16,20,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{57})./\1\2/
  s/(\[BONUS:16,21,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{60})./\1\2/
  s/(\[BONUS:16,22,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{63})./\1\2/
  s/(\[BONUS:16,23,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{66})./\1\2/
  s/(\[BONUS:16,24,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{69})./\1\2/
  s/(\[BONUS:16,25,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{72})./\1\2/
  s/(\[BONUS:16,26,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{74})./\1\2/
  s/(\[BONUS:16,27,(.):SUNOB\]#{79}\n(.{79}\n){15}#.{76})./\1\2/

  s/(\[BONUS:17,01,(.):SUNOB\]#{79}\n(.{79}\n){16}#)./\1\2/
  s/(\[BONUS:17,02,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{3})./\1\2/
  s/(\[BONUS:17,03,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{6})./\1\2/
  s/(\[BONUS:17,04,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{9})./\1\2/
  s/(\[BONUS:17,05,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{12})./\1\2/
  s/(\[BONUS:17,06,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{15})./\1\2/
  s/(\[BONUS:17,07,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{18})./\1\2/
  s/(\[BONUS:17,08,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{21})./\1\2/
  s/(\[BONUS:17,09,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{24})./\1\2/
  s/(\[BONUS:17,10,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{27})./\1\2/
  s/(\[BONUS:17,11,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{30})./\1\2/
  s/(\[BONUS:17,12,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{33})./\1\2/
  s/(\[BONUS:17,13,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{36})./\1\2/
  s/(\[BONUS:17,14,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{39})./\1\2/
  s/(\[BONUS:17,15,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{42})./\1\2/
  s/(\[BONUS:17,16,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{45})./\1\2/
  s/(\[BONUS:17,17,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{48})./\1\2/
  s/(\[BONUS:17,18,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{51})./\1\2/
  s/(\[BONUS:17,19,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{54})./\1\2/
  s/(\[BONUS:17,20,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{57})./\1\2/
  s/(\[BONUS:17,21,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{60})./\1\2/
  s/(\[BONUS:17,22,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{63})./\1\2/
  s/(\[BONUS:17,23,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{66})./\1\2/
  s/(\[BONUS:17,24,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{69})./\1\2/
  s/(\[BONUS:17,25,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{72})./\1\2/
  s/(\[BONUS:17,26,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{74})./\1\2/
  s/(\[BONUS:17,27,(.):SUNOB\]#{79}\n(.{79}\n){16}#.{76})./\1\2/

  s/(\[BONUS:18,01,(.):SUNOB\]#{79}\n(.{79}\n){17}#)./\1\2/
  s/(\[BONUS:18,02,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{3})./\1\2/
  s/(\[BONUS:18,03,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{6})./\1\2/
  s/(\[BONUS:18,04,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{9})./\1\2/
  s/(\[BONUS:18,05,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{12})./\1\2/
  s/(\[BONUS:18,06,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{15})./\1\2/
  s/(\[BONUS:18,07,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{18})./\1\2/
  s/(\[BONUS:18,08,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{21})./\1\2/
  s/(\[BONUS:18,09,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{24})./\1\2/
  s/(\[BONUS:18,10,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{27})./\1\2/
  s/(\[BONUS:18,11,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{30})./\1\2/
  s/(\[BONUS:18,12,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{33})./\1\2/
  s/(\[BONUS:18,13,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{36})./\1\2/
  s/(\[BONUS:18,14,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{39})./\1\2/
  s/(\[BONUS:18,15,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{42})./\1\2/
  s/(\[BONUS:18,16,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{45})./\1\2/
  s/(\[BONUS:18,17,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{48})./\1\2/
  s/(\[BONUS:18,18,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{51})./\1\2/
  s/(\[BONUS:18,19,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{54})./\1\2/
  s/(\[BONUS:18,20,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{57})./\1\2/
  s/(\[BONUS:18,21,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{60})./\1\2/
  s/(\[BONUS:18,22,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{63})./\1\2/
  s/(\[BONUS:18,23,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{66})./\1\2/
  s/(\[BONUS:18,24,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{69})./\1\2/
  s/(\[BONUS:18,25,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{72})./\1\2/
  s/(\[BONUS:18,26,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{74})./\1\2/
  s/(\[BONUS:18,27,(.):SUNOB\]#{79}\n(.{79}\n){17}#.{76})./\1\2/

  s/(\[BONUS:19,01,(.):SUNOB\]#{79}\n(.{79}\n){18}#)./\1\2/
  s/(\[BONUS:19,02,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{3})./\1\2/
  s/(\[BONUS:19,03,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{6})./\1\2/
  s/(\[BONUS:19,04,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{9})./\1\2/
  s/(\[BONUS:19,05,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{12})./\1\2/
  s/(\[BONUS:19,06,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{15})./\1\2/
  s/(\[BONUS:19,07,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{18})./\1\2/
  s/(\[BONUS:19,08,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{21})./\1\2/
  s/(\[BONUS:19,09,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{24})./\1\2/
  s/(\[BONUS:19,10,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{27})./\1\2/
  s/(\[BONUS:19,11,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{30})./\1\2/
  s/(\[BONUS:19,12,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{33})./\1\2/
  s/(\[BONUS:19,13,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{36})./\1\2/
  s/(\[BONUS:19,14,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{39})./\1\2/
  s/(\[BONUS:19,15,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{42})./\1\2/
  s/(\[BONUS:19,16,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{45})./\1\2/
  s/(\[BONUS:19,17,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{48})./\1\2/
  s/(\[BONUS:19,18,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{51})./\1\2/
  s/(\[BONUS:19,19,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{54})./\1\2/
  s/(\[BONUS:19,20,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{57})./\1\2/
  s/(\[BONUS:19,21,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{60})./\1\2/
  s/(\[BONUS:19,22,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{63})./\1\2/
  s/(\[BONUS:19,23,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{66})./\1\2/
  s/(\[BONUS:19,24,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{69})./\1\2/
  s/(\[BONUS:19,25,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{72})./\1\2/
  s/(\[BONUS:19,26,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{74})./\1\2/
  s/(\[BONUS:19,27,(.):SUNOB\]#{79}\n(.{79}\n){18}#.{76})./\1\2/

  s/(\[BONUS:20,0[12],(.):SUNOB\]#{79}\n(.{79}\n){19}#.{3})./\1\2/
  s/(\[BONUS:20,03,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{6})./\1\2/
  s/(\[BONUS:20,04,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{9})./\1\2/
  s/(\[BONUS:20,05,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{12})./\1\2/
  s/(\[BONUS:20,06,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{15})./\1\2/
  s/(\[BONUS:20,07,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{18})./\1\2/
  s/(\[BONUS:20,08,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{21})./\1\2/
  s/(\[BONUS:20,09,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{24})./\1\2/
  s/(\[BONUS:20,10,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{27})./\1\2/
  s/(\[BONUS:20,11,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{30})./\1\2/
  s/(\[BONUS:20,12,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{33})./\1\2/
  s/(\[BONUS:20,13,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{36})./\1\2/
  s/(\[BONUS:20,14,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{39})./\1\2/
  s/(\[BONUS:20,15,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{42})./\1\2/
  s/(\[BONUS:20,16,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{45})./\1\2/
  s/(\[BONUS:20,17,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{48})./\1\2/
  s/(\[BONUS:20,18,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{51})./\1\2/
  s/(\[BONUS:20,19,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{54})./\1\2/
  s/(\[BONUS:20,20,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{57})./\1\2/
  s/(\[BONUS:20,21,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{60})./\1\2/
  s/(\[BONUS:20,22,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{63})./\1\2/
  s/(\[BONUS:20,23,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{66})./\1\2/
  s/(\[BONUS:20,24,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{69})./\1\2/
  s/(\[BONUS:20,25,(.):SUNOB\]#{79}\n(.{79}\n){19}#.{72})./\1\2/
  s/(\[BONUS:20,2[67],(.):SUNOB\]#{79}\n(.{79}\n){19}#.{74})./\1\2/

  s/(\[BONUS:21,0[12],(.):SUNOB\]#{79}\n(.{79}\n){20}#.{3})./\1\2/
  s/(\[BONUS:21,03,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{6})./\1\2/
  s/(\[BONUS:21,04,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{9})./\1\2/
  s/(\[BONUS:21,05,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{12})./\1\2/
  s/(\[BONUS:21,06,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{15})./\1\2/
  s/(\[BONUS:21,07,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{18})./\1\2/
  s/(\[BONUS:21,08,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{21})./\1\2/
  s/(\[BONUS:21,09,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{24})./\1\2/
  s/(\[BONUS:21,10,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{27})./\1\2/
  s/(\[BONUS:21,11,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{30})./\1\2/
  s/(\[BONUS:21,12,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{33})./\1\2/
  s/(\[BONUS:21,13,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{36})./\1\2/
  s/(\[BONUS:21,14,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{39})./\1\2/
  s/(\[BONUS:21,15,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{42})./\1\2/
  s/(\[BONUS:21,16,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{45})./\1\2/
  s/(\[BONUS:21,17,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{48})./\1\2/
  s/(\[BONUS:21,18,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{51})./\1\2/
  s/(\[BONUS:21,19,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{54})./\1\2/
  s/(\[BONUS:21,20,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{57})./\1\2/
  s/(\[BONUS:21,21,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{60})./\1\2/
  s/(\[BONUS:21,22,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{63})./\1\2/
  s/(\[BONUS:21,23,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{66})./\1\2/
  s/(\[BONUS:21,24,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{69})./\1\2/
  s/(\[BONUS:21,25,(.):SUNOB\]#{79}\n(.{79}\n){20}#.{72})./\1\2/
  s/(\[BONUS:21,2[67],(.):SUNOB\]#{79}\n(.{79}\n){20}#.{74})./\1\2/

  # Clean
  s/\[BONUS:.*:SUNOB\]//
  s/\n\[RANDOM_NUMBER:.*:NR\]//g
  s/\[RANDOM_NUMBER:.*:NR\]//g
  s/K(.*\[FIELD_END\])/k\1/g
  s/F(.*\[FIELD_END\])/f\1/g
  s/B(.*\[FIELD_END\])/b\1/g
  x;b end

:end
