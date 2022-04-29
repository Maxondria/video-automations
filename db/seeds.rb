# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

template = DescriptionTemplate.create(template: 'test', name: 'Test Template')

tonny =
  Presenter.create(
    name: 'Tonny Stark',
    twitter_handle: 'tonnystark',
    linked_in: 'https://www.linkedin.com/in/tonnystark/',
    role: 'CEO',
  )

mark =
  Presenter.create(
    name: 'Mark Zuckerberg',
    twitter_handle: 'markzuckerberg',
    linked_in: 'https://www.linkedin.com/in/markzuckerberg/',
    role: 'Super hero',
  )

video =
  Video.create!(
    youtube_id: 'aR2jA-Co-OA',
    title: 'Test video',
    tags: %w[a b c],
    chapter_markers: '00:00 start',
    description_template: template,
    presenters: [tonny, mark],
  )
