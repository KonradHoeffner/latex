%% This is a modified copy of file `imiseposter.cls', a copy of 'baposter.cls' with very slight modifications to conform to the corporate design of IMISE and the medical faculty of the University of Leipzig.

\ProvidesClass{kiesgrube}[2011/11/26 v2.0 kiesgrube class]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\LoadClass[10pt]{extarticle}
\typeout{baposter: Brian Amberg, 2007, 2008, 2009, 2010, 2011 | http://www.brian-amberg.de/uni/poster/}
\typeout{baposter: Reinhold Kainhofer, 2011 | http://reinhold.kainhofer.com/}


%% Define lengths only once on inclusion, such that we can make multiple posters
\newlength{\kiesgrube@basepaperwidth}
\newlength{\kiesgrube@basepaperheight}
\newlength{\kiesgrube@basemargin}
\newlength{\kiesgrube@finalpaperwidth}
\newlength{\kiesgrube@finalpaperheight}
\newlength{\kiesgrube@finalmargin}
\newlength{\headerheight}%
\newlength{\colwidth}%
\newlength{\colheight}%
\newlength{\kiesgrube@@colspacing}%
\newlength{\kiesgrube@box@@cornerradius}%
\newlength{\kiesgrube@box@@boxheaderheight}%
\newlength{\kiesgrube@box@@boxpadding}%
\newlength{\boxstartx}%
\newlength{\boxstarty}%
\newlength{\boxwidth}%
\newlength{\boxheight}%
\newlength{\kiesgrube@titleimage@left@width}%
\newlength{\kiesgrube@titleimage@right@width}%
\newlength{\kiesgrube@titleimage@textwidth}%
\newbox\kiesgrube@box@content%
\newbox\kiesgrube@titleimage@left%
\newbox\kiesgrube@titleimage@title%
\newbox\kiesgrube@titleimage@right%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%-------------------------------------------------------------------------------
% The only ``weird'' dependency of this package is pgf. All the rest should be
% installed on any decent system.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\typeout{Use Packages}
\RequirePackage{xkeyval}
\RequirePackage{calc}
%\RequirePackage[cmyk]{xcolor}
\RequirePackage{tikz}
\RequirePackage{pgf}
\RequirePackage{ifthen}
\RequirePackage[T1]{fontenc}
%\RequirePackage[l2tabu, orthodox]{nag}
\usetikzlibrary{decorations}
\usetikzlibrary{fadings}
\usetikzlibrary{snakes}
\usetikzlibrary{calc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose a smaller value for larger fonts
\newcommand{\kiesgrube@fontscale}{0.350}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom
%-------------------------------------------------------------------------------
% We scale the page from fontscale * papersize up to papersize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Paper sizes
\newif\if@landscape
\newif\if@geometryKnowsThisSize
\DeclareOptionX{landscape}{\@landscapetrue}
\DeclareOptionX{portrait}{}

\newcommand{\kiesgrube@setfinalpapersize}[2]{%
\if@geometryKnowsThisSize
  \setlength{\kiesgrube@finalpaperwidth}{#1}%
  \setlength{\kiesgrube@finalpaperheight}{#2}%
\else
\if@landscape
% Transpose length, if geometry does not handle the papersize based on the key
  \setlength{\kiesgrube@finalpaperwidth}{#2}%
  \setlength{\kiesgrube@finalpaperheight}{#1}%
\else
  \setlength{\kiesgrube@finalpaperwidth}{#1}%
  \setlength{\kiesgrube@finalpaperheight}{#2}%
\fi
\fi
}

% Default paperwidth and paperheight = screen169
%\DeclareOptionX{paperwidth}[841mm]{\setlength{\kiesgrube@finalpaperwidth}{#1}}
%\DeclareOptionX{paperheight}[1189mm]{\setlength{\kiesgrube@finalpaperheight}{#1}}

\@geometryKnowsThisSizetrue\kiesgrube@setfinalpapersize{640mm}{360mm}

\DeclareOptionX{screen169}        {\@geometryKnowsThisSizetrue\kiesgrube@setfinalpapersize{640mm}{360mm}}%g
\DeclareOptionX{screen1610}        {\@geometryKnowsThisSizetrue\kiesgrube@setfinalpapersize{640mm}{400mm}}%g

% Margin
\setlength{\kiesgrube@finalmargin}{1.0cm}
\DeclareOptionX{fontscale}[0.292]{\renewcommand{\kiesgrube@fontscale}{#1}}
\DeclareOptionX{margin}   [1.5cm]{\setlength{\kiesgrube@finalmargin}{#1}}

% move text/poster body to the right (or to the left if negative)
\newlength{\kiesgrube@movebody}
\setlength{\kiesgrube@movebody}{0cm}
\DeclareOptionX{movebody}[0cm]{\setlength{\kiesgrube@movebody}{#1}}


\newif\if@debug
\DeclareOptionX{debug}{\@debugtrue}
%% Will be passed on to other packages (xcolor and geometry), still we don't want unused warnings
\DeclareOptionX{table}{}
\DeclareOptionX{showframe}{}

\ProcessOptionsX

\if@debug
\newcommand{\debug}[1]{\typeout{#1}}
\else
\newcommand{\debug}[1]{}
\fi



\setlength{\kiesgrube@basepaperwidth} {\kiesgrube@fontscale\kiesgrube@finalpaperwidth }
\setlength{\kiesgrube@basepaperheight}{\kiesgrube@fontscale\kiesgrube@finalpaperheight}
\setlength{\kiesgrube@basemargin}     {\kiesgrube@fontscale\kiesgrube@finalmargin}
\newlength{\kiesgrube@basemarginright}
\setlength{\kiesgrube@basemarginright}{\kiesgrube@basemargin}
\addtolength{\kiesgrube@basemarginright}{-\kiesgrube@fontscale\kiesgrube@movebody}
\newlength{\kiesgrube@basemarginleft}
\setlength{\kiesgrube@basemarginleft}{\kiesgrube@basemargin}
\addtolength{\kiesgrube@basemarginleft}{\kiesgrube@fontscale\kiesgrube@movebody}

\typeout{Paperwidth=\the\kiesgrube@finalpaperwidth}
\typeout{Paperheight=\the\kiesgrube@finalpaperheight}
\typeout{BasePaperwidth=\the\kiesgrube@basepaperwidth}
\typeout{BasePaperheight=\the\kiesgrube@basepaperheight}
\usepackage[
   paperwidth=\kiesgrube@basepaperwidth,
   paperheight=\kiesgrube@basepaperheight,
   tmargin=\kiesgrube@basemargin,
   bmargin=\kiesgrube@basemargin,
   lmargin=\kiesgrube@basemarginleft,
   rmargin=\kiesgrube@basemarginright,
   ]{geometry} 

\usepackage{pgfpages}
\if@landscape
\if@geometryKnowsThisSize
\pgfpagesuselayout{resize to}[physical paper width=\kiesgrube@finalpaperheight,physical paper height=\kiesgrube@finalpaperwidth]
\else
\pgfpagesuselayout{resize to}[physical paper width=\kiesgrube@finalpaperwidth,physical paper height=\kiesgrube@finalpaperheight]
\fi
\else
\pgfpagesuselayout{resize to}[physical paper width=\kiesgrube@finalpaperwidth,physical paper height=\kiesgrube@finalpaperheight]
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Default functions for borders/backgrounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These functions will all be redefined from the actual option values. In
%% particular, they will be set to \kiesgrube@optionname@optionvalue, which
%% should do the actual work / setting for that particular optionvalue.

\newcommand{\kiesgrubePosterDrawBackground}[2]{} % Draw poster background

\newcommand{\kiesgrubeBoxGetShape}{}             % Returns path of text box shape
\newcommand{\kiesgrubeBoxDrawBackground}[2]{}    % Draw bg of boxes
\newcommand{\kiesgrubeBoxDrawBorder}[1]{}        % Draw border of individual boxes

\newcommand{\kiesgrubeHeaderGetShape}{}          % Returns path of text box shape
\newcommand{\kiesgrubeHeaderSetShade}[3]{}       % Set bg style for box headers
\newcommand{\kiesgrubeHeaderDrawBackground}[3]{} % Draw background of box header
\newcommand{\kiesgrubeHeaderDrawBorder}[1]{}     % Draw border of box header
\newcommand{\kiesgrubeHeaderDrawText}[1]{}       % Draw text inside box header

\newcommand{\@@previousbox}{notset}             % stores the previously processed box for below=auto

% Function to set a user-defined background
\newcommand{\kiesgrube@backgroundCmd}{\error{No background command defined. Use \background{...} to define background}}
\newcommand{\background}[1]{\renewcommand{\kiesgrube@backgroundCmd}{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle poster and box options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\debug{Handling keys}

%%
%% POSTER OPTIONS
%%
%% Store all poster options in variables of the form \kiesgrube@option
%% choose-keys also store the index in \kiesgrube@optionnr
%% choose-keys typically also assign a function
\definecolor{kiesgrube@silver}{cmyk}{0,0,0,0.7}
\define@boolkey[ba]{poster}[kiesgrube@]{grid}                 [false]       {}
\define@boolkey[ba]{poster}[kiesgrube@]{eyecatcher}           [true]        {}
\define@cmdkey [ba]{poster}[kiesgrube@]{headerheight}         [0.1\textheight]{}
\define@cmdkey [ba]{poster}[kiesgrube@]{columns}              [{}]          {}
\define@cmdkey [ba]{poster}[kiesgrube@]{colspacing}           [1em]         {}
\define@cmdkey [ba]{poster}[kiesgrube@]{bgColorOne}           [kiesgrube@silver]{}
\define@cmdkey [ba]{poster}[kiesgrube@]{bgColorTwo}           [green]       {}

% background can be one of: shadeLR, shadeTB, plain, user, none
\define@choicekey*+[ba]{poster}{background}%
    [\kiesgrube@background\kiesgrube@backgroundnr]%
    {shadeLR, shadeTB, plain, user, none} [plain] {%
  \debug{Poster background: \kiesgrube@background}
  \renewcommand{\kiesgrubePosterDrawBackground}[2]{
      \csname kiesgrube@background@\kiesgrube@background\endcsname{##1}{##2}}
}{
  \PackageWarning{kiesgrube}{Unknown background `\kiesgrube@background' (use
      shadeLR, shadeTB, plain, none, or user). If user is used, you also
      have to define \background{...}.}
  \renewcommand{\kiesgrubePosterDrawBackground}[2]{\kiesgrube@background@none{##1}{##2}}
}


%%
%%  BOX OPTIONS
%%
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{cornerradius}          [1em]         {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{boxheaderheight}       [2em]         {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{boxpadding}            [0.5em]       {}


% textborder can be one of: none, bars, coils, triangles, rectangle, rounded,
% roundedleft, roundedsmall, faded; UNIMPLEMENTED: roundedright
\edef\kiesgrube@box@textborder@validvalues{none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedsmall,faded}
\define@choicekey*+[ba]{posterbox}{textborder}%
    [\kiesgrube@box@textborder\kiesgrube@box@textbordernr]%
    {none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedright,roundedsmall,faded} [rectangle] {%
  \debug{Text border: \kiesgrube@box@textborder}
  \renewcommand{\kiesgrubeBoxGetShape}{
      \csname kiesgrube@box@boxshape@\kiesgrube@box@textborder\endcsname}
  \renewcommand{\kiesgrubeBoxDrawBorder}[1]{
      \csname kiesgrube@box@drawborder@\kiesgrube@box@textborder\endcsname{##1}}
}{
  \PackageWarning{kiesgrube}{Unknown text-border style `\kiesgrube@box@textborder'.
      Edit your file to choose a valid option (\kiesgrube@box@textborder@validvalues).}
  \renewcommand{\kiesgrubeBoxGetShape}{\kiesgrube@boxshape@rectangle}
  \renewcommand{\kiesgrubeBoxDrawBorder}[1]{\kiesgrube@drawborder@rectangle{##1}}
}

% boxshade can be one of: shadeLR, shadeTB, plain, none
\define@choicekey*+[ba]{posterbox}{boxshade}%
    [\kiesgrube@box@boxshade\kiesgrube@box@boxshadenr]%
    {shadelr,shadetb,plain,none} [none] {%
  \debug{Box shade: \kiesgrube@box@boxshade}
  \renewcommand{\kiesgrubeBoxDrawBackground}[2]{
      \csname kiesgrube@box@drawbackground@\kiesgrube@box@boxshade\endcsname{##1}{##2}}
}{
  \PackageWarning{kiesgrube}{Unknown boxshade style `\kiesgrube@boxshade'.
      Edit your file to choose a valid option.}
  \renewcommand{\kiesgrubeBoxDrawBackground}[2]{\kiesgrube@box@drawbackground@none{##1}{##2}}
}

% headershade can be one of: shade-lr, shade-tb, shade-tb-inverse, plain
\define@choicekey*+[ba]{posterbox}{headershade}%
    [\kiesgrube@box@headershade\kiesgrube@box@headershadenr]%
    {shadelr,shadetb,shadetbinverse,plain} [shadelr] {%
  \debug{Header shade: \kiesgrube@box@headershade}
  \renewcommand{\kiesgrubeHeaderSetShade}[3]{
      \csname kiesgrube@box@headershade@\kiesgrube@box@headershade\endcsname{##1}{##2}{##3}}
}{
  \PackageWarning{kiesgrube}{Unknown headershade style `\kiesgrube@box@headershade'.
      Edit your file to choose a valid option.}
  \renewcommand{\kiesgrubeHeaderSetShade}[3]{\kiesgrube@box@headershade@none{##1}{##2}{##3}}
}

% headershape can be one of: rectangle, rounded, smallrounded, roundedleft, roundedright
\define@choicekey*+[ba]{posterbox}{headershape}%
    [\kiesgrube@box@headershape\kiesgrube@box@headershapenr]%
    {rectangle,rounded,smallrounded,roundedleft,roundedright} [roundedright] {%
  \debug{Header shape: \kiesgrube@box@headershape}
  \renewcommand{\kiesgrubeHeaderGetShape}{
      \csname kiesgrube@box@headershape@\kiesgrube@box@headershape\endcsname}
  \renewcommand{\kiesgrubeHeaderDrawText}[1]{
      \csname kiesgrube@box@headerdrawtext@\kiesgrube@box@headershape\endcsname{##1}}
  \renewcommand{\kiesgrubeHeaderDrawBorder}[1]{
      \csname kiesgrube@box@headerdrawborder@\kiesgrube@box@headershape\endcsname{##1}}
}{
  \PackageWarning{kiesgrube}{Unknown headershape style `\kiesgrube@headershape'.
      Edit your file to choose a valid option.}
  \renewcommand{\kiesgrubeHeaderGetShape}{\kiesgrube@box@headershape@rectangle}
  \renewcommand{\kiesgrubeHeaderDrawText}[1]{\kiesgrube@box@headerdrawtext@rectangle{##1}}
  \renewcommand{\kiesgrubeHeaderDrawBorder}[1]{\kiesgrube@box@headerdrawborder@rectangle{##1}}
}

% headerborder can be one of: open, closed, none
\define@choicekey*+[ba]{posterbox}{headerborder}%
    [\kiesgrube@box@headerborder\kiesgrube@box@headerbordernr]%
    {open,closed,none} [open] {%
  \debug{Header border: \kiesgrube@box@headerborder}
%   \renewcommand{\kiesgrubeHeaderBorder}{
%       \csname kiesgrube@headerborder@\kiesgrube@box@headerborder\endcsname}
}{
  \PackageWarning{kiesgrube}{Unknown headerborder style `\kiesgrube@headerborder'.
      Edit your file to choose a valid option.}
%   \renewcommand{\kiesgrubeHeaderBorder}{\kiesgrube@box@headerborder@rectangle}
}


\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{borderColor}           [yellow]      {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{headerColorOne}        [red]         {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{headerColorTwo}        [brown]       {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{headerFontColor}       [black]       {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{boxColorOne}           [magenta]     {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{boxColorTwo}           [cyan]        {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{headerfont}            [\scshape\Large]   {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{textfont}              [{}]          {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{boxopacity}            [1.0]   {}

\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{linewidth}             [2pt]         {}

\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{below}  [notset]{}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{above}  [notset]{}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{aligned}[notset]{}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{bottomaligned}[notset]{}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{column} [0]     {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{row}    [0]     {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{span}   [1]     {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{height} [auto]  {}
\define@cmdkey[ba]{posterbox}[kiesgrube@box@]{name}   [noname]{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IMISE Additions
\definecolor{mediblue}{RGB}{0,138,201}
\definecolor{medigray}{RGB}{157,157,157}
\definecolor{medidarkgray}{RGB}{71,80,84}
\definecolor{mixblue}{RGB}{0,167,214}
\definecolor{aquamarine}{RGB}{138,194,209}
%% IMISE Modifications 
% Set some default values, the poster and posterbox environments can override:
\setkeys[ba]{poster}{
  % Debug grid
  grid=false,
  % Is there an eyecatcher image
  eyecatcher=true,
  columns=2,
  colspacing=1em,
  % Colours
  bgColorOne=white,
  bgColorTwo=white,
  %
  headerheight=0.12\textheight,
  background=none,
}{}
\setkeys[ba]{posterbox}{
  % Position
  column=0,row=0,span=1,
  below=notset,above=notset,
  bottomaligned=notset,
  aligned=notset,
  height=auto,
  % Name
  name=noname,
  % Box design: border:
  borderColor=black,
  cornerradius=0em,
  % text box:
  textfont={},
  boxshade=none,
  boxColorOne=white,
  boxColorTwo=black,
  textborder=roundedleft,
  boxpadding=0.5em,
  % header
  %headerfont=\scshape\Large,% or headerfont=\color{white}\textsf\textbf
  headerFontColor=mediblue,
  headerColorOne=white,
  headerColorTwo=white,
  headershape=rectangle,
  headerborder=open,
  boxheaderheight=2em,
  boxopacity=1.0,
  linewidth=0.25mm,
  headershade=shadelr,                                                                                   
  headerfont=\large\bf\textsf, %Sans Serif
  textfont={\setlength{\parindent}{0em}},
  boxshade=plain,
}{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multicol Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\columnsep}{1.5em}
\setlength{\columnseprule}{0mm}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Save space in lists. Use this after the opening of the list
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\compresslist}{%
\setlength{\itemsep}{1pt}%
\setlength{\parskip}{0pt}%
\setlength{\parsep}{0pt}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Background options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\kiesgrube@background@shadelr}[2]{
  \debug{kiesgrube: Using shade left right background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \shade [shading=axis,left color=#1,right color=#2] (current page.north west)
           rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\kiesgrube@background@shadetb}[2]{
  \debug{kiesgrube: Using shade top to bottom background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \shade [shading=axis,top color=#1,bottom color=#2] (current page.north west)
           rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\kiesgrube@background@plain}[2]{
  \debug{kiesgrube: Using plain background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \fill [fill=#1] (current page.north west) rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\kiesgrube@background@user}[2]{
  \debug{kiesgrube: Using user background.}
  \kiesgrube@backgroundCmd%
}
\newcommand{\kiesgrube@background@none}[2]{
  \debug{kiesgrube: Using no background.}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\kiesgrube@box@boxshape@none}{\kiesgrube@box@boxshape@rectangle}
\newcommand{\kiesgrube@box@boxshape@bars}{
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name sw) %
  (\kiesgrube@box@name se) -- (\kiesgrube@box@name tne)
}
\newcommand{\kiesgrube@box@boxshape@coils}{\kiesgrube@box@boxshape@bars}
\newcommand{\kiesgrube@box@boxshape@triangles}{\kiesgrube@box@boxshape@bars}
\newcommand{\kiesgrube@box@boxshape@rectangle}{
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name sw) -- %
  (\kiesgrube@box@name se) -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@boxshape@faded}{
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name sw) %
  (\kiesgrube@box@name tne) -- (\kiesgrube@box@name se)
  }
\newcommand{\kiesgrube@box@boxshape@rounded}{
  [rc] \kiesgrube@box@boxshape@rectangle%
}
\newcommand{\kiesgrube@box@boxshape@roundedsmall}{
  [src] \kiesgrube@box@boxshape@rectangle
}
\newcommand{\kiesgrube@box@boxshape@roundedleft}{
  (\kiesgrube@box@name tnw) {[rc]-- (\kiesgrube@box@name sw)} -- %
  (\kiesgrube@box@name se) -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@boxshape@roundedright}{
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name sw) {[rc]-- %
  (\kiesgrube@box@name se)} -- (\kiesgrube@box@name tne)%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box background (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
\newcommand{\kiesgrube@box@drawbackground@none}[2]{
  \tikzstyle{box colors}=[]
}
\newcommand{\kiesgrube@box@drawbackground@plain}[2]{
  \tikzstyle{box colors}=[fill=#1]
  \fill[box colors, opacity=\kiesgrube@box@boxopacity] \kiesgrubeBoxGetShape;
}
\newcommand{\kiesgrube@box@drawbackground@shadelr}[2]{
  \tikzstyle{box colors}=[shading=axis, left color=#1, right color=#2]%
  \fill[box colors] \kiesgrubeBoxGetShape;
}
\newcommand{\kiesgrube@box@drawbackground@shadetb}[2]{
  \tikzstyle{box colors}=[shading=axis, top color=#1, bottom color=#2]%
  \fill[box colors] \kiesgrubeBoxGetShape;
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box border
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: borderColor
\newcommand{\kiesgrube@box@drawborder@none}[1]{}
\newcommand{\kiesgrube@box@drawborder@bars}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@coils}[1]{
  \draw[color=#1,segment amplitude=0.35em,segment length=0.4em,snake=coil] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@triangles}[1]{
  \draw[color=#1,segment amplitude=0.2em,segment length=0.4em,snake=triangles] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@rectangle}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@rounded}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@roundedleft}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@roundedright}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}
\newcommand{\kiesgrube@box@drawborder@faded}[1]{
  % This is the right way to do it, but it does not work with evince, and has problems during printing, so instead we do
  %\draw[color=#1,path fading=south] \kiesgrubeBoxGetShape;%
  % this
 %\foreach \x in {0,1,...,90} { \draw[color=#1!\x] ($(\kiesgrube@box@name tnw)!{(100-\x)/100}!(\kiesgrube@box@name sw)$) -- ($(\kiesgrube@box@name tnw)!{(100-(\x+10))/100}!(\kiesgrube@box@name sw)$); }% 
 %\foreach \x in {0,1,...,90} { \draw[color=#1!\x] ($(\kiesgrube@box@name tne)!{(100-\x)/100}!(\kiesgrube@box@name se)$) -- ($(\kiesgrube@box@name tne)!{(100-(\x+10))/100}!(\kiesgrube@box@name se)$); }%
  \foreach \x in {0,1,...,99} { \draw[color=#1,opacity=\x/100] ($(\kiesgrube@box@name tnw)!{(100-\x)/100}!(\kiesgrube@box@name sw)$) -- ($(\kiesgrube@box@name tnw)!{(100-(\x+1))/100}!(\kiesgrube@box@name sw)$); }% 
  \foreach \x in {0,1,...,99} { \draw[color=#1,opacity=\x/100] ($(\kiesgrube@box@name tne)!{(100-\x)/100}!(\kiesgrube@box@name se)$) -- ($(\kiesgrube@box@name tne)!{(100-(\x+1))/100}!(\kiesgrube@box@name se)$); }%
}
\newcommand{\kiesgrube@box@drawborder@roundedsmall}[1]{
  \draw[color=#1] \kiesgrubeBoxGetShape;%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
% TODO: For headerborder==none, use (\kiesgrube@box@name outer tnw) instead!
\newcommand{\kiesgrube@box@headershape@rectangle}{%
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name nw) -- %
  (\kiesgrube@box@name ne) -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@headershape@smallrounded}{%
  (\kiesgrube@box@name tnw) {[src] -- (\kiesgrube@box@name nw) -- %
  (\kiesgrube@box@name ne)} -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@headershape@roundedright}{%
  (\kiesgrube@box@name tnw) -- (\kiesgrube@box@name nw) {[rc] -- %
  (\kiesgrube@box@name ne)} -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@headershape@roundedleft}{%
  (\kiesgrube@box@name tnw) {[rc]-- (\kiesgrube@box@name nw)} -- %
  (\kiesgrube@box@name ne) -- (\kiesgrube@box@name tne)%
}
\newcommand{\kiesgrube@box@headershape@rounded}{%
  (\kiesgrube@box@name tnw) {[rc] -- (\kiesgrube@box@name nw) -- %
  (\kiesgrube@box@name ne) } -- (\kiesgrube@box@name tne)%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header text drawing (one function for each possible value of headershape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take one argument: the header text
\newcommand{\kiesgrube@box@headerdrawtext@rectangle}[1]{
  \path (\kiesgrube@box@name nw) +(0em,-0.5\kiesgrube@box@@boxheaderheight) node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\kiesgrube@box@headerdrawtext@smallrounded}[1]{
  \path (\kiesgrube@box@name nw) +(0.5\boxwidth,-0.5\kiesgrube@box@@boxheaderheight) node[anchor=center] {#1};%
}
\newcommand{\kiesgrube@box@headerdrawtext@roundedright}[1]{
  \path (\kiesgrube@box@name nw) +(0em,-0.5\kiesgrube@box@@boxheaderheight)%
        node[anchor=west,inner sep=0.4em,text depth=0.0em] {#1};%
}
\newcommand{\kiesgrube@box@headerdrawtext@roundedleft}[1]{
  \path (\kiesgrube@box@name nw) +(0em,-0.5\kiesgrube@box@@boxheaderheight)%
        node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\kiesgrube@box@headerdrawtext@rounded}[1]{
    \path (\kiesgrube@box@name nw) +(0.5\boxwidth,-0.5\kiesgrube@box@@boxheaderheight) node[anchor=center] {#1};%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header shade options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: headerColorOne, headerColorTwo and borderColor
\newcommand{\kiesgrube@box@headershade@shadelr}[3]{
    \debug{Header-Shade: Shade Left - Right}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      left color=#1,%
      right color=#2%
    ]%
}
\newcommand{\kiesgrube@box@headershade@shadetb}[3]{
    \debug{Header-Shade: Shade Top - Bottom}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      top color=#1,%
      bottom color=#2%
    ]%
}
\newcommand{\kiesgrube@box@headershade@shadetbinverse}[3]{
    \tikzstyle{header colors}=[%
      top color=#1!75!#2,%
      bottom color=#2!100!#1,%
      shading angle=20%
    ]%
    \colorlet{kiesgrubeHeaderFontColor}{white}%
}
\newcommand{\kiesgrube@box@headershade@plain}[3]{
    \debug{Header-Shade: Plain}
    \tikzstyle{header colors}=[%
      color=#3,%
      fill=#1%
    ]%
}
\newcommand{\kiesgrube@box@headershade@none}[3]{
    \debug{Header-Shade: none}
    \tikzstyle{header colors}=[]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The main poster environment
%%% \begin{kiesgrube}{settings}{Eye Catcher}{Title}{Author}{University Logo}
%%%-----------------------------------------------------------------------------
%%% The settings are
%%%   - grid=true,[false]:Show grid to help with alignment
%%%   - colspacing=0.7em: Column spacing
%%%   - columns=4:        number of columns (default 4 in landscape and 3 in portrait format) (maximum number is 6)
%%%   - color=[orange]:   xcolor color definition used as the main color of the poster
%%%   - colortwo=[white]: The other color for gradient based layouts
%%%   - textborder=none,bars,coils,triangles,rectangle,rounded,roundedsmall,roundedleft,roundedright,[faded]
%%%                       The style of the box around the text area
%%%   - headerborder=none,closed,open
%%%                       No extra border around box header, full border around box header or border that is open below.
%%%   - headershape=rectangle,rounded,roundedleft,roundedright
%%%                       Shape of the box-header region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{poster}[5]{%
  \thispagestyle{empty}% Suppress Page Number
  \debug{Poster Starts}%
  % This setkeys call parses all provided options and depending on the option
  % value, assigns different handler functions to the \kiesgrube(Box|Header)*
  % functions. Once that is done, we don't have to care about particular
  % values for border, shading, etc. All we have to do is call the
  % handler functions and let them do their job.
  % This also allows the user to override the poster-wide defaults on a per-box
  % basis.
  \setkeys[ba]{posterbox,poster}{#1}%
%
  % TODO: Move all those assignments to the key macros!
  % Parse Keys%
  \colorlet{bgColorOne}{\kiesgrube@bgColorOne}
  \colorlet{bgColorTwo}{\kiesgrube@bgColorTwo}
%
  %% Boxes%
  \setlength{\headerheight}{\kiesgrube@headerheight}%
  \setlength{\colheight}{\textheight-\kiesgrube@headerheight}%
  \renewcommand{\@@previousbox}{notset}

  \debug{Format}%
  % Set default for columns if unset (4 for landscape, 3 for portrait)
  \ifthenelse{\equal{\kiesgrube@columns}{}}{%
    \if@landscape
      \renewcommand{\kiesgrube@columns}{4}
    \else
      \renewcommand{\kiesgrube@columns}{3}
    \fi
    %
  }{}
%
  \debug{Columns: \kiesgrube@columns}%
  \setlength{\kiesgrube@@colspacing}{\kiesgrube@colspacing}%
  \setlength{\colwidth}{\textwidth}%
  \addtolength{\colwidth}{\kiesgrube@@colspacing*(1-\kiesgrube@columns)}%
  \ifcase\kiesgrube@columns\relax
    \error{You need to have at least one column!}
  \or % 1
    \setlength{\colwidth}{\colwidth}%
  \or % 2
    \setlength{\colwidth}{0.5\colwidth}%
  \or % 3
    \setlength{\colwidth}{0.3333333333333\colwidth}%
  \or % 4
    \setlength{\colwidth}{0.25\colwidth}%
  \or % 5
    \setlength{\colwidth}{0.2\colwidth}%
  \or % 6
    \setlength{\colwidth}{0.16666666666\colwidth}%
  \else % >6
    \error{You do not want so many columns}
  \fi
%
  \newcommand{\kiesgrube@reference}{north west}%
%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % A box with a header and some content. The basic unit of the poster%
  %---------------------------------------------------------------------------%
  % Each box has a name and can be placed absolutely or relatively.%
  % The only inconvenience is that you can only specify a relative position %
  % towards an already declared box. So if you have a box attached to the %
  % bottom, one to the top and a third one which should be inbetween, you %
  % have to specify the top and bottom boxes before you specify the middle %
  % box.%
  %%
  % below=  name of other node%
  % above=  name of other node%
  % aligned=name of other node%
  % bottomaligned=name of other node%
  % column= [0]     %
  % row=    [0]     %
  % span=   [1]     %
  % height= <size in percent of column height>,[auto]%
  % name=   [noname]%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Backward-compatibility definition (\headerbox command uses posterbox env):
  \newcommand{\headerbox}[3]{%
    \begin{posterbox}[##2]{##1}
      ##3
    \end{posterbox}
  }

  \newenvironment{posterbox}[2][]{%
    \debug{Poster box options: ##1}%
    % Override the poster-wide defaults on a per-box basis
    \setkeys[ba]{posterbox}{##1}%
%
    \def\kiesgrube@box@title{##2}
%
    \colorlet{borderColor}{\kiesgrube@box@borderColor}
    \colorlet{headerColorOne}{\kiesgrube@box@headerColorOne}
    \colorlet{headerColorTwo}{\kiesgrube@box@headerColorTwo}
    \colorlet{headerFontColor}{\kiesgrube@box@headerFontColor}
    \colorlet{boxColorOne}{\kiesgrube@box@boxColorOne}
    \colorlet{boxColorTwo}{\kiesgrube@box@boxColorTwo}
%
    \setlength{\kiesgrube@box@@cornerradius}{\kiesgrube@box@cornerradius}%
    \ifthenelse{\equal{\kiesgrube@box@title}{}}{% No header
    \setlength{\kiesgrube@box@@boxheaderheight}{0pt}%
    }{ % With header
    \setlength{\kiesgrube@box@@boxheaderheight}{\kiesgrube@box@boxheaderheight}%
    }%
    \setlength{\kiesgrube@box@@boxpadding}{\kiesgrube@box@boxpadding}%


    %% The columns is always given absolute
    % boxstartx = column * colwidth + column * colspacing
    \setlength{\boxstartx}{(\colwidth+\kiesgrube@@colspacing)*\kiesgrube@box@column}%
%
    %% The width is gvien absolute
    % Box Width = span * colwidth + (span-1) * colspacing
    \setlength{\boxwidth}{\kiesgrube@box@span\colwidth} %
    \addtolength{\boxwidth}{\kiesgrube@@colspacing*(\kiesgrube@box@span-1)}%
%
    %% Measure the content of the box%
    \setbox\kiesgrube@box@content=\hbox\bgroup%
      \begin{pgfinterruptpicture}%
        \begin{minipage}[t]{\boxwidth-\kiesgrube@box@@boxpadding*2}%
          \kiesgrube@box@textfont\bgroup%
  }% End of posterbox preamble
  %%% HERE COME THE ACTUAL CONTENTS OF THE HEADERBOX ENVIRONMENT
  {% posterbox handling after contents (i.e. drawing everything)
          \egroup%
        \end{minipage}%
      \end{pgfinterruptpicture}%
    \egroup%
    \setlength{\boxheight}{\ht\kiesgrube@box@content}%
    \addtolength{\boxheight}{\dp\kiesgrube@box@content}%
    \addtolength{\boxheight}{\kiesgrube@box@@boxheaderheight} % Header%
    \addtolength{\boxheight}{2\kiesgrube@box@@boxpadding} % Inner Sep
%
    \ifthenelse{\equal{\kiesgrube@box@height}{bottom}}{%
    }{\ifthenelse{\equal{\kiesgrube@box@height}{auto}}{%
    }{ % Neither auto nor bottom%
      \setlength{\boxheight}{\kiesgrube@box@height\colheight}%
    }}%
%
    %% Determine the box position%
    \debug{Setting Coordinates}%
    \debug{Upper Right}%
    \debug{\kiesgrube@box@name}%
%
    %%% Upper Right Corner%
    % if below=auto, set it to the previous box
    % TODO: We should generalize this to the previous box of the used column,
    %       currently we use the previous box, which might be in a different column
    \ifthenelse{\equal{\kiesgrube@box@below}{auto}}{%
        \edef\kiesgrube@box@below{\@@previousbox}
        \debug{Box \kiesgrube@box@name  has below=auto, placing it below box \kiesgrube@box@below.}
    }{}
    \xdef\@@previousbox{\kiesgrube@box@name}

    \ifthenelse{\not\equal{\kiesgrube@box@below}{notset} }{%
      %% Below%
      \debug{Below}%
      \path[shape=coordinate] (\boxstartx,0pt |- \kiesgrube@box@below se) ++(0pt,-\kiesgrube@@colspacing) coordinate(\kiesgrube@box@name nw);%
    }{%
      \ifthenelse{\not\equal{\kiesgrube@box@aligned}{notset} }{%
        %% Aligned%
        \debug{Aligned: \kiesgrube@box@aligned}%
        \path[shape=coordinate] (\boxstartx,0pt |- \kiesgrube@box@aligned nw)                           coordinate(\kiesgrube@box@name nw);%
      }{%
        %% Fixed%
        \debug{Fixed}%
        \setlength{\boxstarty}{\kiesgrube@box@row\colheight}%
        \path[shape=coordinate] (\boxstartx,\colheight-\boxstarty)                                                  coordinate(\kiesgrube@box@name nw);%
    }}%
%
    %% Lower Left Corner%
    \debug{Lower Left}%
    \ifthenelse{\equal{\kiesgrube@box@above}{bottom}}{%
      %% Above = Bottom%
      \debug{Above bottom}%
      \ifthenelse{\equal{\kiesgrube@box@below}{notset} \and \equal{\kiesgrube@box@aligned}{notset}}{%
      \path[shape=coordinate] (\boxstartx,\boxheight)                                                              coordinate(\kiesgrube@box@name nw);%
      }{}%
      \path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                           coordinate(\kiesgrube@box@name se);%
      }{\ifthenelse{\not \equal{\kiesgrube@box@bottomaligned}{notset}}{%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \kiesgrube@box@bottomaligned se)                       coordinate(\kiesgrube@box@name se);%
      }{{\ifthenelse{\not \equal{\kiesgrube@box@above}{notset}}{%
        %% Above = Node%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \kiesgrube@box@above nw)  +(0pt,\kiesgrube@@colspacing) coordinate(\kiesgrube@box@name se);%
      }{%
        %% Above = notset%
        \debug{Above=not set}%
        \ifthenelse{\equal{\kiesgrube@box@height}{bottom}}{%
          %% height=bottom%
          \debug{height=bottom}%
          \path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                       coordinate(\kiesgrube@box@name se);%
        }{ %% height=auto or fixed%
          \debug{height=auto or fixed}%
          \path[shape=coordinate] (\kiesgrube@box@name nw) ++(\boxwidth,-\boxheight)                                coordinate(\kiesgrube@box@name se);%
	  }}}}}%
%
        %
    % Set coordinates relative to nw,se%
    \debug{Fixing Coordinates}%
    \path[shape=coordinate]%
      (\kiesgrube@box@name nw) +(0pt,-\kiesgrube@box@@boxheaderheight)                coordinate(\kiesgrube@box@name tnw)%
      (\kiesgrube@box@name nw |- \kiesgrube@box@name se)   coordinate(\kiesgrube@box@name sw)%
      (\kiesgrube@box@name se |- \kiesgrube@box@name nw)   coordinate(\kiesgrube@box@name ne)%
      (\kiesgrube@box@name ne) +(0pt,-\kiesgrube@box@@boxheaderheight)                coordinate(\kiesgrube@box@name tne)%
%
      (\kiesgrube@box@name nw)  +(-0.025em,0pt)           coordinate(\kiesgrube@box@name outer nw)%
      (\kiesgrube@box@name tnw) +(-0.025em,0pt)           coordinate(\kiesgrube@box@name outer tnw)%
      (\kiesgrube@box@name sw)  +(-0.025em,0pt)           coordinate(\kiesgrube@box@name outer sw)%
%
      (\kiesgrube@box@name ne)  +( 0.025em,0pt)           coordinate(\kiesgrube@box@name outer ne)%
      (\kiesgrube@box@name tne) +( 0.025em,0pt)           coordinate(\kiesgrube@box@name outer tne)%
      (\kiesgrube@box@name se)  +( 0.025em,0pt)           coordinate(\kiesgrube@box@name outer se);%
%
      %% Setting the bg colors of the box header
      \kiesgrubeHeaderSetShade{headerColorOne}{headerColorTwo}{borderColor}
%
      \tikzstyle{rc}=[rounded corners=\kiesgrube@box@@cornerradius];%
      \tikzstyle{src}=[rounded corners=0.5em];%
%

    %% Now that everything is set up, draw the actual box, with bg and header
    \begin{scope}[line width=\kiesgrube@box@linewidth]
      %% Header%
      \debug{Header}%
      \debug{Header-Shape: \kiesgrube@box@headershape, header-border: \kiesgrube@box@headerborder (\kiesgrube@box@headerbordernr)}%
      % TODO: Also turn this last ifcase construct into a handler function
      %       We only need to determine (fill|shade)(draw|)...
%       \kiesgrubeHeaderDrawBackground{bgColorOne}{bgColorTwo}{borderColor}
%       \kiesgrubeHeaderDrawBorder{borderColor}
    \ifthenelse{\equal{\kiesgrube@box@title}{}}{% No header
    }{% With header
      \ifcase\kiesgrube@box@headerbordernr\relax%
        % open
        \ifthenelse{\equal{\kiesgrube@box@headershade}{plain}}{
          \filldraw  [style=header colors, opacity=\kiesgrube@box@boxopacity] \kiesgrubeHeaderGetShape;%
        }{
          \shadedraw [style=header colors] \kiesgrubeHeaderGetShape;%
        }
      \or
        % closed
        \ifthenelse{\equal{\kiesgrube@box@headershade}{plain}}{
          \filldraw  [style=header colors, opacity=\kiesgrube@box@boxopacity] \kiesgrubeHeaderGetShape -- cycle;%
        }{
          \shadedraw [style=header colors] \kiesgrubeHeaderGetShape -- cycle;%
        }
      \or
        % none
        \ifthenelse{\equal{\kiesgrube@box@headershade}{plain}}{
          \fill      [style=header colors, opacity=\kiesgrube@box@boxopacity] \kiesgrubeHeaderGetShape;%
        }{
          \shade     [style=header colors] \kiesgrubeHeaderGetShape;%
        }
      \fi
      %
      %% Draw the text inside the box header:
      \kiesgrubeHeaderDrawText{\color{headerFontColor}\kiesgrube@box@headerfont{\kiesgrube@box@title}};%
    }
      %
      %% Text borders (border around boxes)
      \debug{Poster boxes}%
      % First set box shade
      \kiesgrubeBoxDrawBackground{boxColorOne}{boxColorTwo}
      \kiesgrubeBoxDrawBorder{borderColor}
      %%
      %% Text Box%
      \debug{Drawing Text}%
      \path (\kiesgrube@box@name tnw) node(text) [anchor=north west,
            outer sep=-0.000em,text width=\boxwidth-2\kiesgrube@box@@boxpadding,inner sep=\kiesgrube@box@@boxpadding,
            text justified] {\usebox{\kiesgrube@box@content}};%
    \end{scope}
    %
    % Finally store the box name as the previous box for the next call
%     \xdef\@@previousbox{\kiesgrube@box@name}%
  }% END of posterbox definition
%
  %% Poster Background%
  \kiesgrubePosterDrawBackground{bgColorOne}{bgColorTwo}%
  %% Poster header/title
  \hspace{-1.5em}%
  \begin{tikzpicture}[inner sep=0pt,outer sep=0pt,line width=0.05em]%
    \useasboundingbox (0em,0em) rectangle(\textwidth,\textheight);%
    \path[shape=coordinate]%
      (0pt,\colheight) coordinate(north west) (\textwidth,\colheight) coordinate(north east)%
      (0pt,0pt) coordinate(south west)        (\textwidth,0pt) coordinate(south east);%
%
    \ifkiesgrube@eyecatcher% Has eye catcher
      \debug{Eyecatcher found!}
      \setbox\kiesgrube@titleimage@left=\hbox{#2}%
    \else% Has no eye catcher%
      \setbox\kiesgrube@titleimage@left=\hbox{}%
    \fi%
    \setlength{\kiesgrube@titleimage@left@width}{\wd\kiesgrube@titleimage@left}%
    \setbox\kiesgrube@titleimage@right=\hbox{#5}%
    \setlength{\kiesgrube@titleimage@right@width}{\wd\kiesgrube@titleimage@right}%
    \setlength{\kiesgrube@titleimage@textwidth}{\textwidth}%
    \addtolength{\kiesgrube@titleimage@textwidth}{-\kiesgrube@titleimage@left@width}%
    \addtolength{\kiesgrube@titleimage@textwidth}{-\kiesgrube@titleimage@right@width}%

    \debug{#3}
    %
    %
    %      % Draw Header%
    \draw (north west) +(0em,1em+0.5\headerheight) node(image)[anchor=west]   { {\usebox{\kiesgrube@titleimage@left }} };%
    \draw (north east) +(0em,1em+0.5\headerheight) node(logo) [anchor=east]   { {\usebox{\kiesgrube@titleimage@right}} };%
    %
    \ifkiesgrube@eyecatcher% Has eye catcher%
      \draw (image.east) node(title)[anchor=west,text width=\kiesgrube@titleimage@textwidth]{%
        \begin{minipage}{\kiesgrube@titleimage@textwidth}%
          \begin{center}%
          \textbf{\textcolor{black}{\Huge#3}}\\%
%%          {\Large \textcolor{medigray}{#4}}%
          \end{center}%
        \end{minipage}
      };%
    \else% Has no eye catcher
      \draw (image.east) node(title)[anchor=west]  { {\begin{minipage}{\kiesgrube@titleimage@textwidth}{\bfseries\huge #3}\\{\large #4}\end{minipage}} };%
    \fi
  }% END poster begin
% The body
  {% BEGIN poster end
    % The end, draw gridlines if neccesary
    \ifkiesgrube@grid
      \newdimen{\gridpos}
      \typeout{\kiesgrube@columns-1}
      \pgfmathsetmacro{\z}{\kiesgrube@columns-1}
     \foreach \y in {0,...,\z}
     {
       \setlength{\gridpos}{\y\colwidth+\y\kiesgrube@@colspacing}
       \draw[draw=green,draw opacity=0.7] (\gridpos,0pt)  -- (\gridpos,\colheight)
           (\gridpos+\colwidth,0pt)  -- (\gridpos+\colwidth,\colheight);%
     }
     % Horizontal lines, every 0.1:
     %% Explicitly list all percentages, because with {0.0, 0.1, ..., 1.0} we
     %% get rounding errors in the displayed numbers!
     \foreach \y in {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}
       \draw[draw=green,draw opacity=0.7] (0pt,\colheight-\y\colheight)  --
           (\textwidth,\colheight-\y\colheight) node[anchor=west] {\y};%
    \fi%


\end{tikzpicture}%
 % \xkvview{}
 \par
  }% END poster end
