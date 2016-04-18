# aurl&mdash;Abbreviated URLs for LaTeX
Extends the hyperref package with a mechanism for hyperlinked URLs abbreviated with prefixes. 

# Purpose
The Semantic Web community heavily uses prefixes to abbreviate URLs (AURLs), such as `owl:class` or `rdf:type`.
The LaTeX `hyperref` package defines the `url` command to print and hyperlink a URL but if used for AURLs, the hyperlink fails.
But `href` from `hyperref` is tedious to use.
The aurl package introduces `\aurl{prefix}{suffix}` and includes the 100 most popular prefixes from [prefix.cc](http://prefix.cc).
If you want to include the 1000 most popular prefixes instead, use `\usepackage[1000]{aurl}`.

# Usage
1. copy [aurl.sty](https://raw.githubusercontent.com/KonradHoeffner/latex/master/aurl/aurl.sty) to your working directory
2. add `\usepackage{aurl}` to your preamble
4. (optional)  define non-default prefixes using `\daurl{prefix}{prefix expansion}`
3. add your AURLs with `\aurl{prefix}{suffix}`

# Example
	\documentclass{article}
	\usepackage{aurl}
	\begin{document}
	 \aurl{rdfs}{label}
	 \aurl{owl}{class}
	 \daurl{bbc}{http://bbc.com/}
	\aurl{bbc}{news}
	\end{document}
