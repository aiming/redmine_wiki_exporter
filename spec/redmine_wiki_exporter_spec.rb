require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RedmineWikiExporter" do
  describe ".self" do
    context "#url_to_wikiname" do
      context do
        subject { RedmineWikiExporter.url_to_wikiname("http://foo/bar/baz") }
        it { should == "baz" }
      end
      context do
        subject { RedmineWikiExporter.url_to_wikiname("http://foo/bar/") }
        it { should == "bar" }
      end
    end
  end
end
