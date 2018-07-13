%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Ge Wang <gewang_cupb@outlook.com>
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{cupbthesis}[2014/10/01 v1.0 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\newif\ifcupb@singlesided \cupb@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
    \cupb@singlesidedtrue%
}
\newif\ifcupb@doublesided \cupb@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
    \cupb@doublesidedtrue%
}
\newif\ifcupb@printcopy \cupb@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \cupb@doublesidedtrue% auto enable double-sided style
    \cupb@printcopytrue%
}
%-
%-> Draft version info
%-
\newif\ifcupb@versioninfo \cupb@versioninfofalse
\DeclareOption{draftversion}{%
    \cupb@versioninfotrue%
}
%-
%-> Handle non-implemented options
%-
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\ifcupb@doublesided% if double-sided printing enabled
    \LoadClass[UTF8,a4paper,twoside,zihao=-4]{ctexbook}
\else% if double-sided printing isn't enabled
    \LoadClass[UTF8,a4paper,oneside,zihao=-4]{ctexbook}
\fi
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\cupbifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\cupbifstrbk}{\expandafter\ifblank\expandafter}% expansion control
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/cupbthesis.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%- part one -- horizontal widths
%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifcupb@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{6.3mm}% left side margin
    \setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes
%- part two -- vertical heights
%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
\setlength{\voffset}{-17.4mm}% set vertical offset
\setlength{\topmargin}{20pt}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{29.5pt}% vertical margin between footer and body text
%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}
%- line spacing
\linespread{1.5}% line space setting
\raggedbottom% prevent adding vertical white space in strange places
%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{#1}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
    \renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}% set underline color
    \renewcommand{\uline}[1]{\CJKunderline{#1}}% unified name
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \uline{#2}}
\newcommand{\ulhshift}{-4em}% horizontal shift on underline
\newcommand{\ulextend}[2][16em]{% extend underline length
    \hbox to #1{#2\hfill}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\cupb@pic@schoollogo{\includegraphics[height=2.57cm]{cupb_logo}}
\def\cupb@pic@thesis{\includegraphics[height=1.77cm]{cupb_thesis}}
\def\cupb@value@titleone{}
\def\cupb@value@titletwo{}
\newcommand{\titleone}[1]{\def\cupb@value@titleone{#1}}
\newcommand{\titletwo}[1]{\def\cupb@value@titletwo{#1}}
\def\cupb@value@major{}
\newcommand{\major}[1]{\def\cupb@value@major{#1}}
\def\cupb@value@researchfield{}
\newcommand{\researchfield}[1]{\def\cupb@value@researchfield{#1}}
\def\cupb@value@author{}
\renewcommand{\author}[1]{\def\cupb@value@author{#1}}
\def\cupb@value@advisor{}
\newcommand{\advisor}[1]{\def\cupb@value@advisor{#1}}
\def\cupb@value@chinesedate{}
\newcommand{\chinesedate}[1]{\def\cupb@value@chinesedate{#1}}

%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.5}
        \zihao{-4}\bfseries

        {\noindent\bfseries 中图分类号： G643.0}%
        \hfill
        \raisebox{-9pt}{
            \begin{tabular}{|ll|}
                \hline
                {\makebox[4em][s]{\bfseries 单位代码}：}&{\bfseries 11414}\\
                {\makebox[4em][s]{\bfseries 学号}：}&{\bfseries 2015310402}\\ \hline
            \end{tabular}
        }

        \begin{center}
            \linespread{1.5}
            \zihao{3}\bfseries

            \vspace*{\stretch{4}}

            {\cupb@pic@schoollogo}

            \vspace*{\stretch{1}}

            {\cupb@pic@thesis}

            \vspace*{\stretch{3}}

            \def\tabcolsep{1pt}
            \def\arraystretch{1.3}
            {\fanggb
            \begin{tabular}{ll}
                \makebox[4em][s]{\cupb@label@title}& \ulenhance[1.2pt]{\ulextend{\cupb@value@titleone}}\\
                & \ulenhance[1.2pt]{\ulextend{\cupb@value@titletwo}}\\
                \makebox[4em][s]{\cupb@label@major} & \ulenhance[1.2pt]{\ulextend{\cupb@value@major}}\\
                \makebox[4em][s]{\cupb@label@researchfield} & \ulenhance[1.2pt]{\ulextend{\cupb@value@researchfield}}\\
                \makebox[4em][s]{\cupb@label@author} & \ulenhance[1.2pt]{\ulextend{\cupb@value@author}}\\
                \makebox[4em][s]{\cupb@label@advisor} & \ulenhance[1.2pt]{\ulextend{\cupb@value@advisor}}\\
            \end{tabular}
            }

            \vspace*{\stretch{4.5}}

            {\mdseries\zihao{-3} \cupb@value@chinesedate}

            \vspace*{\stretch{3.5}}
        \end{center}
        \clearpage
        \if@twoside
            \thispagestyle{empty}
            \ifcupb@versioninfo
                \vspace*{\stretch{1}}
                \begin{Huge}
                    \noindent
                    Draft Version (\today)
                \end{Huge}
            \fi
            \cleardoublepage[empty]
        \else
            \ifcupb@versioninfo
                \thispagestyle{empty}
                \vspace*{\stretch{1}}
                \begin{Huge}
                    \noindent
                    Draft Version (\today)
                \end{Huge}
                \cleardoublepage[empty]
            \fi
        \fi
    }
}
%-
%-> English item commands
%-
\def\cupb@value@englishtitle{}
\newcommand{\englishtitle}[1]{\def\cupb@value@englishtitle{#1}}
\def\cupb@value@englishauthor{}
\newcommand{\englishauthor}[1]{\def\cupb@value@englishauthor{#1}}
\def\cupb@value@englishadvisor{}
\newcommand{\englishadvisor}[1]{\def\cupb@value@englishadvisor{#1}}
\def\cupb@value@englishdegreetype{}
\newcommand{\englishdegreetype}[1]{\def\cupb@value@englishdegreetype{#1}}
\def\cupb@value@englishmajor{}
\newcommand{\englishmajor}[1]{\def\cupb@value@englishmajor{#1}}
\def\cupb@value@englishinstitute{}
\newcommand{\englishinstitute}[1]{\def\cupb@value@englishinstitute{#1}}
\def\cupb@value@englishdate{}
\newcommand{\englishdate}[1]{\def\cupb@value@englishdate{#1}}
%-
%-> Redefine English style
%-
\newcommand{\makeenglishtitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.25}
        \zihao{-2}\bfseries

        \vspace*{50pt}

        {\zihao{2} \cupb@value@englishtitle}

        \vspace*{\stretch{2}}

        {\cupb@label@englishstatement}

        \vspace*{\stretch{1}}

        {By}

        {\cupb@value@englishauthor}

        {(\cupb@value@englishmajor)}

        \vspace*{\stretch{2}}

        {Dissertation Supervisor}

        {\cupb@value@englishadvisor}

        \vspace*{\stretch{3}}

        {\zihao{-3} \cupb@value@englishdate}

        \vspace*{\stretch{3}}
    \end{center}
    \clearpage
    \if@twoside
      \thispagestyle{empty}
      \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> Author's declaration
%---------------------------------------------------------------------------%
\newcommand{\makedeclaration}{%
    %\cleardoublepage[empty]
    %\thispagestyle{noheaderstyle}
    {
        \linespread{1.5}
        \zihao{-4}

        {
            \ctexset {
                chapter = {
                    format = \linespread{1.5}\zihao{-3}\sffamily\centering,
                    beforeskip = {31.2pt},
                    afterskip = {15.6pt},
                    pagestyle = noheaderstyle
                }
            }
            \chapter{博士学位论文独创性声明}
        }

        {\cupb@value@declare@creativity}

        \vspace*{6ex}

        {\hfill{} {\cupb@value@declare@s \underline{\hspace*{7em}} \hspace*{3em} \cupb@value@declare@d \underline{\hspace*{7em}} \hspace*{4em}}}

        {\hfill{} {\cupb@value@declare@t \underline{\hspace*{7em}} \hspace*{3em} \cupb@value@declare@d \underline{\hspace*{7em}} \hspace*{4em}}}

        \vspace*{6ex}

        {
            \ctexset {
                chapter = {
                    break={\par\relax},
                    format = \linespread{1.5}\zihao{-3}\sffamily\centering,
                    beforeskip = {31.2pt},
                    afterskip = {15.6pt},
                    pagestyle = noheaderstyle
                }
            }
            \chapter{博士学位论文版权使用授权书}
        }

        {\cupb@value@declare@rightsone}

        {\cupb@value@declare@rightstwo}

        {\cupb@value@declare@rightsthree}

        \vspace*{6ex}

        {\hfill{} {\cupb@value@declare@s \underline{\hspace*{7em}} \hspace*{3em} \cupb@value@declare@d \underline{\hspace*{7em}} \hspace*{4em}}}

        {\hfill{} {\cupb@value@declare@t \underline{\hspace*{7em}} \hspace*{3em} \cupb@value@declare@d \underline{\hspace*{7em}} \hspace*{4em}}}

        \vspace*{3ex}
    }
    \thispagestyle{noheaderstyle}
    \setcounter{page}{1}% 开始页码
    \pagenumbering{Roman}% 页码符号

    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\newcommand{\keywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries\sffamily \cupb@label@keywords} #1}
%- define engish keywords
\newcommand{\englishkeywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \cupb@label@englishkeywords} #1}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- define spacing and length
\def\@dotsep{1.5mu}% spacing for dots
\def\@pnumwidth{2em}% spacing between titles and page numbers
\def\@tocrmarg{2em}% right margin indentation
\def\@chaptervspace{1ex}% spacing between chapter titles
%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{-4} #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{-4}
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%---------------------------------------------------------------------------%
\endinput

