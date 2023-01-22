#!/usr/bin/env ruby
require 'html2rss'

rss =
  Html2rss.feed(
    channel: { url: 'https://cassandra.apache.org/_/blog.html', title: 'Apache Cassandra Blog', description: 'Apache Casssandra blog posts.' },
    selectors: {
      items: { selector: 'section#blog-main div.inner div#all-tiles div.openblock.card.shadow.relative.test' },
      title: { selector: 'div.content > h3' },
      description: { selector: 'div.content > div.openblock.card-content > div.content', post_process: { name: 'sanitize_html' } },
      link: { selector: 'div.content div.openblock.card-btn div.content div.paragraph.btn a.page @href', post_process: { name: 'gsub', pattern: 'blog', replacement: 'https://cassandra.apache.org/_/blog' } },
      updated: { selector: 'div.content > h4', post_process: { name: 'parse_time', time_zone: 'UTC' } }
    }
  )

puts rss
