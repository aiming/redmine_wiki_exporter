# encoding: utf-8

require 'hpricot'
require 'mechanize'
require 'open-uri'
require File.expand_path(File.dirname(__FILE__) + '/redmine_wiki_exporter/constant')

# ignoring SSL verify
require 'openssl'
module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class RedmineWikiExporter
  class WikiURL
    def url
      @url
    end

    def initialize(url)
      @url = url
    end

    def wikiname
      url.to_s.split('/').last
    end
  end

  def url_to_wikiname(url)
    WikiURL.new(url).wikiname
  end

  def root_url
    @root_url
  end

  def project
    @project
  end

  def agent
    @agent
  end

  def homepage_wikiname
    @homepage_wikiname
  end
  def homepage_wikiname=(wikiname)
    @homepage_wikiname = wikiname
  end

  def exporting_path
    @exporting_path
  end
  def exporting_path=(path)
    @exporting_path = "#{path}/"
  end
  def html_dir_name
    "html"
  end
  def html_path
    "#{exporting_path}#{html_dir_name}/"
  end
  def image_dir_name
    "images"
  end
  def image_path
    "#{html_path}#{image_dir_name}/"
  end

  def page_name
    url_to_wikiname(agent.page.uri)
  end

  def initialize(root, project)
    @root_url = root
    @project = project
    @agent = Mechanize.new
  end

  def login(username, password)
    agent.get("#{root_url}/login")
    login_form = agent.page.form_with(:action => "/login")
    login_form['username'] = username
    login_form['password'] = password
    login_form.submit
  end

  def image_urls
    agent.page.images.map {|img| img.src}
  end

  def save_images
    agent.page.images.map {|i| i.url}.select {|url| url.include? "/attachments/download/"}.each do |url|
      image = agent.get(url)
      image.save("#{image_path}#{url_to_wikiname(url)}.png")
    end
  end

  def save_page
    header = RedmineWikiExporterModule::Constant.header
    footer = RedmineWikiExporterModule::Constant.footer
    doc = Hpricot(agent.page.body)
    wiki = (doc/"div.wiki")
    (wiki/:img).each do |img|
      if img[:src].to_s.include? "http"
        scanned = img[:src].to_s.scan(/.*\/attachments\/(.*)\/.*\.(.*)/).first
        image_filename = "#{scanned[0]}.#{scanned[1]}"
        img[:src] = "#{image_dir_name}/#{image_filename}"
      else
        img[:src] = "#{image_dir_name}/#{url_to_wikiname(img[:src])}.png" if image_urls.include? img[:src]
      end
    end
    (wiki/:a).each do |link|
      if link[:href].to_s.include? "/wiki/"
        link_wikiname = url_to_wikiname(link[:href])
        if link_wikiname == homepage_wikiname
          page_filename = "../#{link_wikiname}.html"
        else
          page_filename = "#{link_wikiname}.html"
        end
        page_filename = "#{html_dir_name}/#{link_wikiname}.html" if url_to_wikiname(agent.page.uri) == homepage_wikiname
        link[:href] = "#{page_filename}"
      elsif link[:href].to_s.include? "/attachments/"
        scanned = link[:href].to_s.scan(/.*\/attachments\/(.*)\/.*\.(.*)/).first
        image_filename = "#{scanned[0]}.#{scanned[1]}"
        link[:href] = "#{image_dir_name}/#{image_filename}"
      end
    end

    if url_to_wikiname(agent.page.uri) == homepage_wikiname
      filename = "#{exporting_path}#{page_name}.html"
    else
      filename = "#{html_path}#{page_name}.html"
    end
    file = open(filename, "w")
    file.write(header + wiki.inner_html + footer)
    file.close
  end

  def mkdirs
    Dir::mkdir("#{exporting_path}") rescue nil
    Dir::mkdir("#{html_path}") rescue nil
    Dir::mkdir("#{image_path}") rescue nil
  end

  def save(wiki_name)
    url = "#{root_url}/projects/#{project}/wiki/#{wiki_name}"
    agent.get(url)
    mkdirs
    save_page
    save_images
  end

  def wiki_urls
    return @wiki_urls if @wiki_urls
    url = "#{root_url}/projects/#{project}/wiki/index"
    agent.get(url)
    agent.page.links.map {|link|
      link.href
    }
  end

  def scraping_selector=(selector)
    @scraping_selector = selector
  end
  def scraping_selector
    @scraping_selector
  end

  def scrape
    wiki_urls.select(&scraping_selector).each do |url|
      save(url_to_wikiname(url))
    end
  end
end
