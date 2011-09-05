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
  def root_url
    @root_url
  end

  def project
    @project
  end

  def agent
    @agent
  end

  def exporting_path
    @exporting_path
  end
  def exporting_path=(path)
    @exporting_path = path
  end

  def page_name
    agent.page.uri.to_s.split('/').last
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
      image.save("#{exporting_path}/images/#{url.split('/').last}.png")
    end
  end

  def save_page
    header = RedmineWikiExporterModule::Constant.header
    footer = RedmineWikiExporterModule::Constant.footer
    doc = Hpricot(agent.page.body)
    wiki = (doc/"div.wiki")
    (wiki/:img).each do |img|
      img[:src] = "images/#{img[:src].split('/').last}.png" if image_urls.include? img[:src]
    end
    (wiki/:a).each do |link|
      link[:href] = "#{link[:href].to_s.split('/').last}.html" if link[:href].to_s.include? "/wiki/"
    end
    file = open("#{exporting_path}/#{page_name}.html", "w")
    file.write(header + wiki.inner_html + footer)
    file.close
  end

  def mkdirs
    Dir::mkdir("#{exporting_path}") rescue nil
    Dir::mkdir("#{exporting_path}/images") rescue nil
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
      save(url.split('/').last)
    end
  end
end
