require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "RedmineWikiExporter" do
  context "#url_to_wikiname" do
    let(:exporter) { RedmineWikiExporter.new(nil, nil) }
    context do
      subject { exporter.url_to_wikiname("http://foo/bar/baz") }
      it { should == "baz" }
    end
    context do
      subject { exporter.url_to_wikiname("http://foo/bar/") }
      it { should == "bar" }
    end
  end
end
