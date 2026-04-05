% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% iffyuan.cls — Custom academic paper style
%
% Combines:
%   - Fonts: Palatino (tgpagella) + XCharter + mathpazo + zlmtt + LM Sans
%   - Layout: 2.2cm L/R margins, single column
%   - Title box: arXiv/FAIR style (rounded, light background)
%   - Section headings: arXiv/FAIR sans-serif bold
%   - Header/Footer: minimal, page number only
%   - Author system: arXiv/FAIR custom commands
%   - Link colors: arXiv/FAIR deep purple-blue
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iffyuan}[2025/04/04 iffyuan academic paper style v1.0]

% ============================================================================
% Fonts — FSD/Berkeley: Palatino + XCharter + mathpazo + zlmtt
%         Sans-serif: Latin Modern Sans (lmss) — has proper bold/italic support
% ============================================================================
\RequirePackage{tgpagella}   % Palatino text
\RequirePackage{mathpazo}    % Palatino math
\RequirePackage{inconsolata} % tt fallback
\RequirePackage{lmodern}     % Latin Modern — provides robust sans-serif with bold
\renewcommand{\sfdefault}{lmss} % use LM Sans as the sans-serif family

% ============================================================================
% Class options and base class
% ============================================================================
\RequirePackage{xifthen}
\newboolean{nonumbering}
\newboolean{logo}
\newboolean{address}
\newboolean{copyright}
\newboolean{internal}
\DeclareOption{nonumbering}{\setboolean{nonumbering}{true}}
\DeclareOption{logo}{\setboolean{logo}{true}}
\DeclareOption{address}{\setboolean{address}{true}}
\DeclareOption{copyright}{\setboolean{copyright}{true}}
\DeclareOption{internal}{\setboolean{internal}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions
\LoadClass{extarticle}

% ============================================================================
% More fonts — XCharter for main text, zlmtt for monospace
% ============================================================================
\RequirePackage{XCharter}
\RequirePackage[scaled=1.1]{zlmtt}

% ============================================================================
% Core packages
% ============================================================================
\AtEndOfClass{\RequirePackage[tracking=smallcaps]{microtype}}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage{amsthm, amsmath, amsfonts, amssymb}
\RequirePackage{cmap}
\RequirePackage[T1]{fontenc}
\RequirePackage{url}
\RequirePackage{pifont}
\RequirePackage{textcomp}
\RequirePackage{fontawesome5}
\RequirePackage[overload]{textcase}

% ============================================================================
% Graphics, tables
% ============================================================================
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{bm}
\RequirePackage{colortbl}
\RequirePackage{tabularx}
\RequirePackage{changepage}

% ============================================================================
% Lists
% ============================================================================
\RequirePackage{enumitem}
\setlist[itemize]{noitemsep}
\setlist[enumerate]{noitemsep}

% ============================================================================
% Layout — 2.2cm L/R, no header space needed
% ============================================================================
\RequirePackage[
  top=2.25cm,
  bottom=2.5cm,
  left=2.2cm,
  right=2.2cm,
  columnsep=0.65cm
]{geometry}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{etoolbox}

% ============================================================================
% Colors — arXiv/FAIR link colors + FSD title colors
% ============================================================================
\RequirePackage[most]{tcolorbox}
\RequirePackage{xcolor}

% arXiv/FAIR colors for links
\definecolor{xiaoxiblue}{HTML}{300a7f}
\definecolor{xiaoxifg}{HTML}{262130}
\definecolor{xiaoxibg}{HTML}{f4f3f7}
\definecolor{xiaoxilink}{HTML}{371878}
\definecolor{darkred}{RGB}{174, 11, 42}

% FSD colors (kept for backward compat)
\definecolor{TinaCrimson}{HTML}{DC143C}
\definecolor{CalGoldHex}{HTML}{fff7e8}
\definecolor{IronGrey}{HTML}{6D6E71}
\definecolor{YaleBlue}{HTML}{2A5487}

% ============================================================================
% Hyperref — arXiv/FAIR colors
% ============================================================================
\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\renewcommand{\UrlFont}{\rmfamily}
\hypersetup{
  colorlinks=true,
  linkcolor=xiaoxiblue,
  citecolor=xiaoxiblue,
  filecolor=magenta,
  urlcolor=xiaoxilink,
}

% ============================================================================
% Bibliography — natbib
% ============================================================================
\RequirePackage[round,authoryear]{natbib}
\def\bibfont{\small}

% ============================================================================
% Section format — arXiv/FAIR sans-serif style
% ============================================================================
\RequirePackage{titlesec}
\RequirePackage{caption}

\titleformat*{\paragraph}{\bfseries}
\titleformat*{\section}{\Large\sffamily\bfseries}
\titleformat*{\subsection}{\large\sffamily\bfseries}
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries}
\DeclareTextFontCommand{\textbf}{\bfseries\sffamily}

% Caption format — arXiv/FAIR style
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\textbf{#1 #2}} #3}
\captionsetup{singlelinecheck=true,justification=raggedright,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Section numbering
\setcounter{secnumdepth}{3}
\ifthenelse{\boolean{nonumbering}}{\setcounter{secnumdepth}{0}}{}

% ============================================================================
% Header / Footer — minimal: page number only, no header
% ============================================================================
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}

\newtoks\correspondingauthor
\newtoks\paperurl
\newtoks\reportnumber

% Keep \runningtitle command available
\makeatletter
\newcommand\runningtitle[1]{\renewcommand\@runningtitle{#1}}
\newcommand\@runningtitle{}
\makeatother

% Default pages: page number only, no header
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[R]{\small \thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% First page: no header, only page number
\fancypagestyle{firststyle}{
  \fancyhf{}
  \fancyfoot[R]{\small \thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

% ============================================================================
% Author system — arXiv/FAIR style
% ============================================================================
\makeatletter
\newcommand\iyyuan@addtolist[5][]{%
  \begingroup%
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi%
    \let\protect\@unexpandable@protect%
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup%
}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\normalsize\sffamily \bfseries #2\textsuperscript{#1}}}
\renewcommand\author[2][]{\iyyuan@addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}
\newcommand\authorlistindent{0.03em}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\fontsize{10}{13}\selectfont \textsuperscript{#1}#2}}
\newcommand\affiliation[2][]{\iyyuan@addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\fontsize{10}{13}\selectfont \textsuperscript{#1}#2}}
\newcommand\contribution[2][]{\iyyuan@addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand\metadatalist{}
\newcommand\metadataformat[2][]{\ifstrempty{#2}{{\small {\sffamily \bfseries #1}}}{{\small {\sffamily \bfseries #1:} #2}}}
\newcommand\metadata[2][]{\iyyuan@addtolist[#1]{#2}{\metadatalist}{\metadataformat}{\par}}

\renewcommand{\abstract}[1]{\def\abstractlist{{\color{xiaoxifg} #1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\textcolor{black}{{#1}}}}

% \renewcommand\date[1]{\metadata[Date]{#1}}  % uncomment if needed
\newcommand\correspondence[1]{\metadata[Contact]{#1}}

\renewcommand{\title}[1]{\newcommand{\titlelist}{{\fontsize{20.2}{25}\selectfont\sffamily\bfseries #1}}}

% Team logo command (set path in main.tex or leave empty)
\newcommand{\teamlogo}{}
\newcommand{\setteamlogo}[1]{\renewcommand{\teamlogo}{#1}}
\makeatother

% ============================================================================
% Title box — arXiv/FAIR style (rounded corners, light purple-grey background)
% ============================================================================
\makeatletter
\newcommand{\mymaketitle}{%
  \tcbset{enhanced,frame hidden}
  \tcbset{left=0.5cm}
  \tcbset{right=0.5cm}
  \tcbset{top=0.5cm}
  \tcbset{bottom=0.5cm}
  \tcbset{arc=10pt}
  \tcbset{colback=xiaoxibg}
  \tcbset{before skip=0pt}
  \tcbset{grow to left by=1.5pt}
  \tcbset{grow to right by=1.5pt}
  %
  \begin{tcolorbox}
    \setlength{\parindent}{0cm}
    \setlength{\parskip}{0.5cm}
    {
      \setlength{\parskip}{0cm}
      \raggedright
      \nohyphens
      %
      {
        \setstretch{1.618}
        \titlelist\par
      }
      \vskip 0.25cm
      %
      {\leftskip=\authorlistindent\relax \authorlist\par}
      \vskip 0.2cm
      %
      \affiliationlist\par
      %
      \contributionlist\par
    }%
    %
    \abstractlist\par
    %
    \vskip 0.5cm
    %
    {
      \setlength{\parskip}{0cm}
      \ifx\teamlogo\empty
        \ifdefempty{\metadatalist}{\vspace*{0.65cm}}{\metadatalist\par}
      \else
        \noindent
        \begin{minipage}[b]{0.75\linewidth}
          \ifdefempty{\metadatalist}{\vspace*{0.65cm}}{\metadatalist\par}
        \end{minipage}%
        \hfill
        \begin{minipage}[b]{0.2\linewidth}
          \raggedleft
          \includegraphics[height=1.3cm]{\teamlogo}
        \end{minipage}
      \fi
    }
  \end{tcolorbox}
  \tcbset{reset}
  \FloatBarrier
}

\if@twocolumn%
\renewcommand{\maketitle}{
  \twocolumn[%
    \mymaketitle
    \vskip 0.38cm
  ]
}%
\else%
\renewcommand{\maketitle}{
  \mymaketitle
  \thispagestyle{firststyle}
}%
\fi
\makeatother

% ============================================================================
% Abstract environment (simple, used by titlebox)
% ============================================================================
% Note: \abstract is redefined above as a command taking one argument.
% If you prefer the environment form, use:
%   \abstract{Your text here}
% in the preamble before \maketitle.

% ============================================================================
% Convenience tcolorbox style (from FSD)
% ============================================================================
\tcbset{
  aibox/.style={
    colback=CalGoldHex,
    colframe=CalGoldHex,
    boxrule=0.5mm,
    arc=2mm,
    auto outer arc,
    left=5mm,
    right=5mm,
    top=5mm,
    bottom=5mm,
  }
}
