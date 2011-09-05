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
<link href="style.css" media="all" rel="stylesheet" type="text/css" /> 
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
