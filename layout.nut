////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Rainbow AM Theme 2023
// Dwayne Hurst
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////   

class UserConfig {
</ label="--------  Main theme layout  --------", help="Show or hide additional images", order=1 /> uct1="select below";
   </ label="Select listbox, leftwheel", help="Select carousel wheel or listbox", options="leftwheel,listbox", order=4 /> list_type="leftwheel";
</ label=" ", help=" ", options=" ", order=10 /> divider5="";
</ label="--------    Miscellaneous    --------", help="Miscellaneous options", order=16 /> uct6="select below";
   </ label="Random Wheel Sounds", help="Play random sounds when navigating games wheel", options="Yes,No", order=25 /> enable_random_sound="Yes";
}

local my_config = fe.get_config();
local flx = fe.layout.width;
local fly = fe.layout.height;
local flw = fe.layout.width;
local flh = fe.layout.height;
fe.layout.font="Roboto-Medium.ttf";

// modules
fe.load_module("fade");
fe.load_module( "animate" );
fe.load_module("scrollingtext");

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
// Load background image
//local b_art = fe.add_image("Default.png", 0, 0, flw, flh );
local b_art = fe.add_image("backgrounds/[DisplayName].png", 0, 0, flw, flh );

//////////////////////////////////////////////////////////////////////////////////////
// create surface for snap
local surface_snap = fe.add_surface( 640, 480 );
local snap = FadeArt("snap", 0, 0, 640, 480, surface_snap);
snap.trigger = Transition.EndNavigation;
snap.preserve_aspect_ratio = false;

// now position and pinch surface of snap
// adjust the below values for the game video preview snap
surface_snap.set_pos(flx*0.357, fly*0.172, flw*0.495, flh*0.65);
surface_snap.skew_y = 0;
surface_snap.skew_x = 0;
surface_snap.pinch_y = 0;
surface_snap.pinch_x = 0;
surface_snap.rotation = 0;


//////////////////////////////////////////////////////////////////////////////////////
//Year Default

::OBJECTS <- {
  yeartest = fe.add_image("year/Default.png", flx*0.8865, fly*0.522, flw*0.0765 flh*0.13 ),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -180, end = 0, time = 800, tween = Tween.Back
}
OBJECTS.yeartest.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.yeartest, move_transition1 ) );

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
//Year 

::OBJECTS <- {
  yeartest = fe.add_image("year/[Year].png", flx*0.8865, fly*0.522, flw*0.0765 flh*0.13 ),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -180, end = 0, time = 800, tween = Tween.Back
}
OBJECTS.yeartest.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.yeartest, move_transition1 ) );

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
//word pop

class PopImage1
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "pop/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  wordpop1 = fe.add_image("pop/1.png", flx*0.8865, fly*0.7, flw*0.0765 flh*0.13),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -180, end = 0, time = 900, tween = Tween.Back
}
OBJECTS.wordpop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.wordpop1, move_transition1 ) );
PopImage1(OBJECTS.wordpop1);

//////////////////////////////////////////////////////////////////////////////////////
//category genre 

class GenreImage1
{
    mode = 1;       //0 = first match, 1 = last match, 2 = random
    supported = {
        //filename : [ match1, match2 ]
        "action": [ "action","gun", "climbing" ],
        "adventure": [ "adventure" ],
        "arcade": [ "arcade" ],
        "casino": [ "casino" ],
        "computer": [ "computer" ],
        "console": [ "console" ],
        "collection": [ "collection" ],
        "fighter": [ "fighting", "fighter", "beat-'em-up" ],
        "handheld": [ "handheld" ],
		"jukebox": [ "jukebox" ],
        "platformer": [ "platformer", "platform" ],
        "mahjong": [ "mahjong" ],
        "maze": [ "maze" ],
        "paddle": [ "breakout", "paddle" ],
        "puzzle": [ "puzzle" ],
	    "pinball": [ "pinball" ],
	    "quiz": [ "quiz" ],
	    "racing": [ "racing", "driving","motorcycle" ],
        "rpg": [ "rpg", "role playing", "role-playing" ],
	    "rhythm": [ "rhythm" ],
        "shooter": [ "shooter", "shmup", "shoot-'em-up" ],
	    "simulation": [ "simulation" ],
        "sports": [ "sports", "boxing", "golf", "baseball", "football", "soccer", "tennis", "hockey" ],
        "strategy": [ "strategy"],
        "utility": [ "utility" ]
    }

    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local cat = " " + fe.game_info(Info.Category, var).tolower();
            local matches = [];
            foreach( key, val in supported )
            {
                foreach( nickname in val )
                {
                    if ( cat.find(nickname, 0) ) matches.push(key);
                }
            }
            if ( matches.len() > 0 )
            {
                switch( mode )
                {
                    case 0:
                        ref.file_name = "glogos/" + matches[0] + "1.png";
                        break;
                    case 1:
                        ref.file_name = "glogos/" + matches[matches.len() - 1] + "1.png";
                        break;
                    case 2:
                        local random_num = floor(((rand() % 1000 ) / 1000.0) * ((matches.len() - 1) - (0 - 1)) + 0);
                        ref.file_name = "glogos/" + matches[random_num] + "1.png";
                        break;
                }
            } else
            {
			      local random_num = floor(((rand() % 1000 ) / 1000.0) * (20 - (1 - 1)) + 1);
                  ref.file_name = "glogos/unknown" + random_num + ".png";
//				  ref.file_name = "glogos/unknown1.png";
            }
        }
    }
}
		
::OBJECTS <- {
  glogo1 = fe.add_image("glogos/blank.png", flx*0.8865, fly*0.3428, flw*0.0765 flh*0.13),
}

local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -180, end = 0, time = 700, tween = Tween.Back
}
OBJECTS.glogo1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.glogo1, move_transition1 ) );
GenreImage1(OBJECTS.glogo1);




//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

// Load system image

::OBJECTS <- {
  b_art2 = fe.add_image("ballsy/[DisplayName].png", flx*0.8865, fly*0.166, flw*0.0765 flh*0.13 ),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "rotation", start = -180, end = 0, time = 600, tween = Tween.Back
}
OBJECTS.b_art2.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.b_art2, move_transition1 ) );


//////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////
// The following section sets up what type and wheel and displays the users choice
// Wheel or Text List

if ( my_config["list_type"] == "listbox" )
{

local b_art3 = fe.add_image("artextra/43text.png", 0, 0, flw, flh );

local lb = fe.add_listbox( flx*0.0, fly*0.185, flw*0.31, flh*0.625 );
lb.rows = 21;
lb.charsize = 30;
lb.set_rgb( 255, 255, 255 );
lb.bg_alpha = 0;
lb.align = Align.Left;
lb.selbg_alpha = 0;
lb.sel_red = 255;
lb.sel_green = 165;
lb.sel_blue = 0;

local b_art5 = fe.add_image("43Border/[DisplayName].png", 0, 0, flw, flh );

//anything else you want for use with listbox, add here before the closing bracket

class SideTop
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "sidetop/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  sidetop1 = fe.add_image("boxart.png", 0, 0, flw, flh),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "alpha", start = 255, end = 255, time = 750, tween = Tween.Back
}
OBJECTS.sidetop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.sidetop1, move_transition1 ) );
SideTop(OBJECTS.sidetop1);

class SideBottom
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "sidebottom/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  sidebottom1 = fe.add_image("boxart.png", 0, 0, flw, flh),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "alpha", start = 255, end = 255, time = 750, tween = Tween.Back
}
OBJECTS.sidebottom1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.sidebottom1, move_transition1 ) );
SideBottom(OBJECTS.sidebottom1);

local b_art3 = fe.add_image("43Border/[DisplayName].png", 0, 0, flw, flh );
}


// Wheel art
if ( my_config["list_type"] == "leftwheel" )
{

local b_art3 = fe.add_image("artextra/43withbox.png", 0, 0, flw, flh );

local wheel1 = fe.add_artwork("wheel", flx*0.07 fly*0.11, flw*0.18, flh*0.18 );
wheel1.index_offset = -2;
wheel1.preserve_aspect_ratio = true;

local wheel2 = fe.add_artwork("wheel", flx*0.07, fly*0.26, flw*0.18, flh*0.18 );
wheel2.index_offset = -1;
wheel2.preserve_aspect_ratio = true;

local wheel3 = fe.add_artwork("wheel", flx*0.06, fly*0.4, flw*0.2, flh*0.2 );
wheel3.index_offset = 0;
wheel3.preserve_aspect_ratio = true;

local wheel4 = fe.add_artwork("wheel", flx*0.07, fly*0.56, flw*0.18, flh*0.18 );
wheel4.index_offset = 1;
wheel4.preserve_aspect_ratio = true;

local wheel5 = fe.add_artwork("wheel", flx*0.07, fly*0.71, flw*0.18, flh*0.18 );
wheel5.index_offset = 2;
wheel5.preserve_aspect_ratio = true;

//anything else you want for use with leftwheel, add here before the closing bracket
// Load random top and bottom images

class SideTop
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "sidetop/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  sidetop1 = fe.add_image("boxart.png", 0, 0, flw, flh),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "alpha", start = 255, end = 255, time = 750, tween = Tween.Back
}
OBJECTS.sidetop1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.sidetop1, move_transition1 ) );
SideTop(OBJECTS.sidetop1);

class SideBottom
{
    ref = null;
    constructor( image )
    {
        ref = image;
        fe.add_transition_callback( this, "transition" );
    }
    
    function transition( ttype, var, ttime )
    {
        if ( ttype == Transition.ToNewSelection || ttype == Transition.ToNewList )
        {
            local random_num = floor(((rand() % 1000 ) / 1000.0) * (10 - (1 - 1)) + 1);
            ref.file_name = "sidebottom/"+random_num+".png";
        }
    }
}

::OBJECTS <- {
  sidebottom1 = fe.add_image("boxart.png", 0, 0, flw, flh),
}
local move_transition1 = {
  when = Transition.EndNavigation ,property = "alpha", start = 255, end = 255, time = 750, tween = Tween.Back
}
OBJECTS.sidebottom1.trigger = Transition.EndNavigation;
animation.add( PropertyAnimation( OBJECTS.sidebottom1, move_transition1 ) );
SideBottom(OBJECTS.sidebottom1);

local b_art3 = fe.add_image("43Border/[DisplayName].png", 0, 0, flw, flh );
}

///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
// Play random sound when transitioning to next / previous game on wheel
function sound_transitions(ttype, var, ttime) 
{
	if (my_config["enable_random_sound"] == "Yes")
	{
		local random_num = floor(((rand() % 1000 ) / 1000.0) * (124 - (1 - 1)) + 1);
		local sound_name = "sounds/GS"+random_num+".mp3";
		switch(ttype) 
		{
		case Transition.EndNavigation:		
			local Wheelclick = fe.add_sound(sound_name);
			Wheelclick.playing=true;
			break;
		}
		return false;
	}
}
fe.add_transition_callback("sound_transitions")

//////////////////////////////////////////////////////////////////////////////////////
// Box art and cart art, uses the emulator.cfg path for boxart image location

local boxart = fe.add_artwork("boxart", flx*0.76, fly*0.875, flw*0.175, flh*0.1 );
boxart.preserve_aspect_ratio = true;

local cartart = fe.add_artwork("cartart", flx*0.855, fly*0.886, flw*0.1, flh*0.08 );
cartart.preserve_aspect_ratio = true;

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////

//Game count text info
local textgc = fe.add_text( "[ListEntry]-[ListSize]", flx*0.435, fly*0.93, flw*0.4, flh*0.025  );
textgc.set_rgb( 255, 255, 255 );
//textgc.style = Style.Bold;
textgc.align = Align.Left;
textgc.rotation = 0;
textgc.word_wrap = true;

//Filter text info
local textf = fe.add_text( "Filter: [ListFilterName]", flx*0.375, fly*0.93, flw*0.4, flh*0.025  );
textf.set_rgb( 255, 255, 255 );
//textgc.style = Style.Bold;
textf.align = Align.Left;
textf.rotation = 0;
textf.word_wrap = true;

//Emulator text info
local textemu = fe.add_text( "[Emulator]", flx*0.37, fly*0.89, flw*0.6, flh*0.035  );
textemu.set_rgb( 255, 255, 255 );
//textemu.style = Style.Bold;
textemu.align = Align.Left;
textemu.rotation = 0;
textemu.word_wrap = true;

//Rom Name text info
local textemu = fe.add_text( "[Title]", flx*0.45, fly*0.93, flw*0.4, flh*0.025  );
textf.set_rgb( 255, 255, 255 );
//textgc.style = Style.Bold;
textf.align = Align.Left;
textf.rotation = 0;
textf.word_wrap = true;

//////////////////////////////////////////////////////////////////////////////////////

