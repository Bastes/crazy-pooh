class SitemapController < ApplicationController
  def show
    @achievements_sections = Achievement.
      unscoped.
      select('section, subsection').
      group('section, subsection').
      order('section ASC, subsection ASC').all.
      inject(ActiveSupport::OrderedHash.new) { |r, a|
        r.tap { |r|
          r[a.section] ||= []
          r[a.section] << a.subsection } }
    @external_links_sections = ExternalLink.
      unscoped.
      select('section').
      group('section').
      order('section ASC').
      all.
      map &:section
  end
end
