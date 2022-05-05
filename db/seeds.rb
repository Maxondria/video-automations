# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

template = <<~XXX
  <%= summary %>

  ### Presenters
  <% presenters.each do |presenter| %>
    <%= presenter.name %> <%= presenter.role %> <%= presenter.twitter_url %>
  <% end %>

  <%= '### Table of contents' unless chapter_markers.blank? %>
  <%= chapter_markers %>

  <%= '### Resources' if video_resources.any? %>

  <% video_resources.each do |r| %>
    <%= r.title %>: <%= r.url %>
  <% end %>
XXX

description_template =
  DescriptionTemplate.create(name: 'Default', template: template)

daniel =
  Presenter.create(
    name: 'Arinda Daniel',
    twitter_handle: 'dAnbeds',
    linked_in: 'https://www.linkedin.com/in/arindadaniel/',
    role: 'Sales Manager',
  )

category = Category.create(name: 'Default')
