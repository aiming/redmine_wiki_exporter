# encoding: utf-8

module RedmineWikiExporterModule
  class Constant
    def self.header
      <<EOS
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"> 
<head> 
<meta http-equiv="content-type" content="text/html; charset=utf-8" /> 
<title>Filament - Spec 050-130 World Zone - Aiming Redmine</title> 
<meta name="description" content="Redmine" /> 
<meta name="keywords" content="issue,bug,tracker" /> 
<meta name="csrf-param" content="authenticity_token"/> 
<meta name="csrf-token" content="F1GP2+Lh7OEwJ6fmrwldGI+nHQNgVhnSoQv29oMCLk4="/> 
<link rel='shortcut icon' href='/favicon.ico?1308721718' /> 
<link href="/stylesheets/application.css?1306774282" media="all" rel="stylesheet" type="text/css" /> 
 
<script src="/javascripts/prototype.js?1306774282" type="text/javascript"></script> 
<script src="/javascripts/effects.js?1306774282" type="text/javascript"></script> 
<script src="/javascripts/dragdrop.js?1306774282" type="text/javascript"></script> 
<script src="/javascripts/controls.js?1306774282" type="text/javascript"></script> 
<script src="/javascripts/application.js?1306774282" type="text/javascript"></script> 
<script type="text/javascript"> 
//<![CDATA[
Event.observe(window, 'load', function(){ new WarnLeavingUnsaved('このページから移動すると、保存されていないデータが失われます。'); });
//]]>
</script> 
 
<!--[if IE 6]>
    <style type="text/css">
      * html body{ width: expression( document.documentElement.clientWidth < 900 ? '900px' : '100%' ); }
      body {behavior: url(/stylesheets/csshover.htc?1306774282);}
    </style>
<![endif]--> 
 
  
      <style type="text/css"> 
    h1. Stylesheet

@import url(/themes/fil/stylesheets/application.css);

/* 見出し１ */
.wiki h1 { 
padding: 4px 0px 2px 10px; /* 余白の幅 */
border-width: 0px 0px 3px 20px;  /* 枠の幅 */
border-style: solid;  /* 枠の種類 */
line-height: 100%; /*行の高さ */
} 

/* 見出し１ */ 
.wiki h1 { 
padding: 4px 0px 2px 10px; /* 余白の幅 */ 
border-width: 0px 0px 3px 20px; /* 枠の幅 */ 
border-style: solid; /* 枠の種類 */ 
line-height: 100%; /*行の高さ */ 
} 

/* 見出し２ */
.wiki h2 { 
padding: 4px 0px 0px 8px; /* 余白の幅 */
border-width: 0px 0px 2px 15px;  /* 枠の幅 */
border-style: solid;  /* 枠の種類 */
margin:0.5em 0em 0.5em 0em; /* 上下の間隔 */
border-color: #000000; /* 枠の色 */ 
} 

/* 見出し３ */
.wiki h3 { 
padding: 3px 0px 0px 6px; /* 余白の幅 */
border-style: solid;  /* 枠の種類 */
border-width: 0px 0px 1px 10px;  /* 枠の幅 */
margin:0.5em 0em 0.5em 0.5em; /* 上下の間隔 */
border-color: #333333; /* 枠の色 */ 
} 

/* 見出し４ */
.wiki h4 { 
padding: 3px 0px 0px 6px; /* 余白の幅 */
border-style: solid;  /* 枠の種類 */
border-width: 0px 0px 1px 7px;  /* 枠の幅 */
margin:0.5em 50% 0.5em 1em; /* 上下の間隔 */
} 

/* 見出し５ */
.wiki h5 { 
padding: 3px 0px 0px 6px; /* 余白の幅 */
border-style: solid;  /* 枠の種類 */
border-width: 0px 0px 0px 5px;  /* 枠の幅 */
margin:0.5em 1.3em; /* 上下の間隔 */
} 

/* 見出し６ draft・memo用 */
.wiki h6 { 
line-height: 130%; /* 行の高さ */
margin:0.3em 0em; /* 上下の間隔 */
} 

/* p */
p { 
padding: 0px 0px 0px 2em; /* 余白の幅 */
} 

/* pre */
.wiki pre { 
padding: 3px 3px 3px 3px; /* 余白の幅 */
border-width: 2px 2px 2px 2px;  /* 枠の幅 */
} 

.fc-r {
color: #ff0000;
}

.fc-b {
color: #0000ff;
}

.fc-g {
color: #00ff00;
}

.fc-w {
color: #ffffff;
}

.draft {
font-size: 2em; /* 文字のサイズ */
color: #ffffff; /* 文字の色 */
background-color: #ff5555; /* 背景色 */
line-height: 130%; /* 行の高さ */
margin:0.3em 0em; /* 上下の間隔 */ 
padding: 0.2em; /* 余白の幅 */ 
}

.p-a {
font-size: 1em; /* 文字のサイズ */
color: #ff0000; /* 文字の色 */
padding: 0.1em; /* 余白の幅 */ 
}

.p-b {
font-size: 1em; /* 文字のサイズ */
color: #ff5500; /* 文字の色 */*/
padding: 0.1em; /* 余白の幅 */ 

}

.p-c {
font-size: 1em; /* 文字のサイズ */
color: #ffaa00; /* 文字の色 */*/
padding: 0.1em; /* 余白の幅 */ 

}

table {
margin:0.2em 2em; /* 上下の間隔 */
}


li {
margin:0.3em 0.5em; /* 上下の間隔 */
}


.dev {
font-weight:bold; /* 太字 */ 
}

.art {
font-weight:bold; /* 太字 */ 
}

.pln {
font-weight:bold; /* 太字 */ 
}

.snd {
font-weight:bold; /* 太字 */ 
}

.logic {
font-weight:bold; /* 太字 */ 
font-size: 1.3em; /* 文字のサイズ */
background-color: #eaeaea; /* 背景色 */
padding: 0.5em; /* 余白の幅 */ 
line-height: 300%; /* 行の高さ */
border-width: 1px 1px 1px 1px;  /* 枠の幅 */
border-style: solid;  /* 枠の種類 */
}

.kari {
font-weight:bold; /* 太字 */ 
color: #ffffff; /* 文字の色 */
background-color: #ff7777; /* 背景色 */
border-width: 1px 1px 1px 1px;  /* 枠の幅 */
border-style: solid;  /* 枠の種類 */
}
    </style> 
  
 
  <link href="/plugin_assets/redmine_wiki_extensions/stylesheets/wiki_extensions.css?1306928215" media="screen" rel="stylesheet" type="text/css" /> 
  <script src="/plugin_assets/redmine_wiki_extensions/javascripts/wiki_extensions.js?1306928215" type="text/javascript"></script> 
  
    <script src="/plugin_assets/redmine_wiki_extensions/javascripts/tablesort.js?1306928215" type="text/javascript"></script> 
    <script type="text/javascript"> 
      //TableSort.arrowNone = " ";
      TableSort.arrowUp   = ' <img alt="Sort_asc" src="/images/sort_asc.png?1306774281" />';
      TableSort.arrowDown = ' <img alt="Sort_desc" src="/images/sort_desc.png?1306774281" />';
    </script> 
  
 
 
<!-- page specific tags --> 
 
  <link href="/stylesheets/scm.css?1306774282" media="screen" rel="stylesheet" type="text/css" /> 
</head> 
<body>
EOS
    end

    def self.footer
      <<EOS
</body> 
</html> 
EOS
    end

    def self.css
    end
  end
end
