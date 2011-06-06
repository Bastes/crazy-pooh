class SitemapController < ApplicationController
  def show
    @achievements_sections = Achievement.
      group('section, subsection').order('section ASC, subsection ASC').all.
      inject(ActiveSupport::OrderedHash.new) { |r, a|
        r.tap { |r|
          r[a.section] ||= []
          r[a.section] << a.subsection } }
    @external_links_sections = ExternalLink.group('section').order('section ASC').map &:section
  end
end
